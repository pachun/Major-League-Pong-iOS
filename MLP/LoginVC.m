//
//  Login.m
//  MLP
//
//  Created by Nicholas Pachulski on 4/2/12.
//  Copyright (c) 2012 RPI. All rights reserved.
//

#import "LeagueDC.h"

#import "LoginVC.h"

@interface LoginVC ()
- (void)getAuthToken;
- (void)segue;
@end

@implementation LoginVC

#pragma mark - Accessor Synthesizers

@synthesize errorLabel = _errorLabel;
@synthesize signInButton = _signInButton;
@synthesize rememberMeSwitch = _rememberMeSwitch;
@synthesize usernameField = _usernameField;
@synthesize passwordField = _passwordField;

#pragma mark - Interface Actions

// Forward the keyboard to the next field
- (IBAction)doneWithKeyboard:(id)sender {
    if(sender == self.usernameField) {
        [sender resignFirstResponder];
        [self.passwordField becomeFirstResponder];
    } else {
        [sender resignFirstResponder];
    }
}

- (IBAction)signIn {
    
    // Save / Forget information (Needs work...)
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    if([self.rememberMeSwitch isOn]) {
        [prefs setBool:YES forKey:@"RememberMe"];
        [prefs setValue:self.usernameField.text forKey:@"email"];
        [prefs setValue:self.passwordField.text forKey:@"password"];
    } else [prefs setBool:NO forKey:@"RememberMe"];
    
    // Authenticate w/API
    [self getAuthToken];
}

#pragma mark - Table View Methods

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // Fill in information
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    if([prefs boolForKey:@"RememberMe"]) {
        self.usernameField.text = [prefs valueForKey:@"email"];
        self.passwordField.text = [prefs valueForKey:@"password"];
    } else {
        self.usernameField.text = @"";
        self.passwordField.text = @"";
    }
}

#pragma mark - RKRequestDelegate Methods

- (void)request:(RKRequest *)request didLoadResponse:(RKResponse *)response {
    
    if([request isPOST] && [response isJSON]) {
        
        // Parse Response
        NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:response.body 
                                                                     options:kNilOptions 
                                                                       error:nil];
        NSString *token = [jsonResponse objectForKey:@"token"];
        if([token length] > 0) {
            
            // On success
            self.errorLabel.hidden = YES;
            NSLog(@"Succeeded with token: %@", token);
            [[NSUserDefaults standardUserDefaults] setValue:token forKey:@"token"];
            
            // Load leagues and then segue
            [[LeagueDC sharedInstance] loadLeagues];
            [[NSNotificationCenter defaultCenter] addObserver:self 
                                                     selector:@selector(segue) 
                                                         name:@"LeaguesLoaded" 
                                                       object:[LeagueDC sharedInstance]];
        } else {
            
            // On error
            NSLog(@"Failed with json error: %@", [response bodyAsString]);
            self.errorLabel.hidden = NO;
        }
    }
}

#pragma mark - Private Methods

- (void)getAuthToken {
    
    // Get info
    NSString *email = self.usernameField.text;
    NSString *pass  = self.passwordField.text;
    
    // Error check
    if([email isEqualToString:@""] || [pass isEqualToString:@""]) {
        self.errorLabel.hidden = NO;
        return;
    }
    
    // Send request
    [[RKClient sharedClient] setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:email, @"email", pass, @"password", nil];
    [[RKClient sharedClient] post:@"/tokens.json" params:params delegate:self];
}

- (void)segue {
    
    // Stop watching notifications and segue to next VC
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self performSegueWithIdentifier:@"ShowLeaguesSegue" sender:[LeagueDC sharedInstance]];
}

@end