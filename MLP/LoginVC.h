//
//  Login.h
//  MLP
//
//  Created by Nicholas Pachulski on 4/2/12.
//  Copyright (c) 2012 RPI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <RestKit/RestKit.h>

@interface LoginVC : UITableViewController <RKRequestDelegate>

// Outlets
@property(strong, nonatomic)IBOutlet UILabel *errorLabel;
@property(strong, nonatomic)IBOutlet UIButton *signInButton;
@property(strong, nonatomic)IBOutlet UISwitch *rememberMeSwitch;
@property(strong, nonatomic)IBOutlet UITextField *usernameField;
@property(strong, nonatomic)IBOutlet UITextField *passwordField;

// Actions
- (IBAction)doneWithKeyboard:(id)sender;
- (IBAction)signIn;

@end
