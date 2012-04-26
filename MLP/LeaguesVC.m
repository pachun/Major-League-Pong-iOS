//
//  LeaguesVC.m
//  MLP
//
//  Created by Nicholas Pachulski on 4/3/12.
//  Copyright (c) 2012 RPI. All rights reserved.
//

#import "League.h"
#import "LeagueDC.h"
#import "SeasonDC.h"

#import "LeaguesVC.h"

@interface LeaguesVC ()
- (void)segue;
@end

@implementation LeaguesVC

#pragma mark - Accessor Synthesizers

@synthesize signOutButton = _signOutButton;

#pragma mark - Interface Actions

- (void)signOutPressed {
    [self dismissModalViewControllerAnimated:YES];
}

# pragma mark - Table View Methods

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table View Data Source Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[LeagueDC sharedInstance] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"LeagueCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    cell.textLabel.text = ((League *)[[LeagueDC sharedInstance] leagueAtIndex:indexPath.row]).name;
    
    return cell;
}

#pragma mark - Table View Delegate Methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Load seasons for selected league and then segue
    [[NSNotificationCenter defaultCenter] addObserver:self 
                                             selector:@selector(segue) 
                                                 name:@"SeasonsLoaded" 
                                               object:[SeasonDC sharedInstance]];
    [[LeagueDC sharedInstance] setSelected:indexPath.row];
    [[SeasonDC sharedInstance] loadSeasons];
}

# pragma mark - Private Methods

- (void)segue {
    
    // Stop watching notifications and segue to next VC
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self performSegueWithIdentifier:@"ShowSeasonsSegue" sender:[SeasonDC sharedInstance]];
}

@end
