//
//  GamesVC.m
//  MLP
//
//  Created by Nicholas Pachulski on 4/3/12.
//  Copyright (c) 2012 RPI. All rights reserved.
//

#import "Team.h"
#import "TeamDC.h"
#import "TeamPlayer.h"

#import "Season.h"
#import "SeasonDC.h"

#import "Game.h"
#import "GameDC.h"
#import "GameScore.h"

#import "GamesVC.h"
#import "UIGameCell.h"

#import "PlayerSelectVC.h"

@interface GamesVC ()
- (void)commonInit;
@end

@implementation GamesVC

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
    return [[GameDC sharedInstance] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"GameCell";
    UIGameCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    Game *g = [[GameDC sharedInstance] gameAtIndex:indexPath.row];
    NSString *home_team = g.home_team.name;
    NSString *away_team = g.away_team.name;
    cell.timeLabel.text = [NSString stringWithFormat:@"@ %@", g.time];
    cell.homeTeamLabel.text = home_team;
    cell.awayTeamLabel.text = away_team;
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Prepare for and take segue
    [[GameDC sharedInstance] setSelected:indexPath.row];
    [self performSegueWithIdentifier:@"TeamSelectSegue" sender:self];
}

# pragma mark - Private Methods

- (void)commonInit {
    //self.navigationItem.title = [[SeasonDC sharedInstance] selectedSeason].name;
}

@end
