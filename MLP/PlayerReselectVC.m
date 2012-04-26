//
//  PlayerReselectVC.m
//  MLP
//
//  Created by Nicholas Pachulski on 4/18/12.
//  Copyright (c) 2012 RPI. All rights reserved.
//

#import "Player.h"
#import "PlayerDC.h"

#import "Team.h"
#import "TeamDC.h"

#import "PlayerSelectVC.h"
#import "PlayerReselectVC.h"

@interface PlayerReselectVC ()

@end

@implementation PlayerReselectVC

# pragma mark - Accessor Synthesizers

@synthesize selectedPlayersID = _selectedPlayersID;
@synthesize playersTeamIndex = _playersTeamIndex;
@synthesize team = _team;
@synthesize delegate = _delegate;

# pragma mark - Table View Methods

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

# pragma mark - Table Data Source Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView { return 2; }

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section==0) return 1;
    else return [[PlayerDC sharedInstance] count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if(section==0) return @"Selected";
    else return @"Substitutes";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    Player *current;
    if(indexPath.section==0) {
        current = [[PlayerDC sharedInstance] playerWithIdentifier:self.selectedPlayersID];
        cell.textLabel.text = current.name;
        return cell;
    } else {
        current = [[PlayerDC sharedInstance] playerAtIndex:indexPath.row];
        cell.textLabel.text = current.name;
    }
    
    return cell;
}

# pragma mark - Table View Delegate Methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section==0) {
        // Tell the delegate to reset the player and remove this reselect view
        PlayerSelectVC *reselectVC = (PlayerSelectVC *)self.delegate;
        [reselectVC playerReselectedOnTeam:self.team forTeamIndex:self.playersTeamIndex withNewPlayerIdentifier:self.selectedPlayersID];
    } else {
        // Reset the selected player cell and reload the table view
        [self setSelectedPlayersID:[[PlayerDC sharedInstance] playerAtIndex:indexPath.row].identifier];
        [self.tableView reloadData];
    }
}

@end
