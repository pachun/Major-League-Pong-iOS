//
//  TeamsVC.m
//  MLP
//
//  Created by Nicholas Pachulski on 4/3/12.
//  Copyright (c) 2012 RPI. All rights reserved.
//

#import "Player.h"
#import "PlayerDC.h"

#import "Season.h"
#import "SeasonDC.h"

#import "Team.h"
#import "TeamDC.h"

#import "TeamsVC.h"

#import "UITeamCell.h"

@interface TeamsVC ()
- (void)commonInit;
@end

@implementation TeamsVC

# pragma mark - Accessor Synthesizers

// None

#pragma mark - Interface Actions

// None

# pragma mark - Table View Methods

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if(self = [super initWithCoder:aDecoder]) {
        [self commonInit];
    }
    return self;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table View Data Source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[TeamDC sharedInstance] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"TeamCell";
    UITeamCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    Team *current = [[TeamDC sharedInstance] teamAtIndex:indexPath.row];
    
    Player *player1 = [[PlayerDC sharedInstance] playerWithIdentifier:((Player *)[current.players objectAtIndex:0]).identifier];
    Player *player2 = [[PlayerDC sharedInstance] playerWithIdentifier:((Player *)[current.players objectAtIndex:1]).identifier];
    Player *player3 = [[PlayerDC sharedInstance] playerWithIdentifier:((Player *)[current.players objectAtIndex:2]).identifier];

    cell.nameLabel.text = current.name;
    cell.LPPLabel.text = [NSString stringWithFormat:@"%0.3f", current.pointPercentage];
    cell.winLossLabel.text = [NSString stringWithFormat:@"%i - %i", current.wins, current.losses];
    cell.player1Gravatar.image = [UIImage imageWithData:player1.gravatar];
    cell.player2Gravatar.image = [UIImage imageWithData:player2.gravatar];
    cell.player3Gravatar.image = [UIImage imageWithData:player3.gravatar];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [[TeamDC sharedInstance] setSelected:indexPath.row];
    [self performSegueWithIdentifier:@"TeamDetailsSegue" sender:self];
}

# pragma mark - Private Methods

- (void)commonInit {
    self.navigationItem.title = [[SeasonDC sharedInstance] selectedSeason].name;
}

@end
