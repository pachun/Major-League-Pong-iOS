//
//  SeasonsVC.m
//  MLP
//
//  Created by Nicholas Pachulski on 4/3/12.
//  Copyright (c) 2012 RPI. All rights reserved.
//

#import "TeamDC.h"
#import "GameDC.h"
#import "PlayerDC.h"

#import "Season.h"
#import "SeasonDC.h"

#import "League.h"
#import "LeagueDC.h"

#import "SeasonsVC.h"

#import "MBProgressHUD.h"

@interface SeasonsVC ()
- (void)seguePart1;
- (void)seguePart2;
- (void)seguePart3;
- (void)commonInit;
@end

@implementation SeasonsVC

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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[SeasonDC sharedInstance] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"SeasonCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    cell.textLabel.text = [[SeasonDC sharedInstance] seasonAtIndex:indexPath.row].name;
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Initialize data controllers so all object mappings are initialized (Games uses Teams OM)
    [PlayerDC sharedInstance];
    [TeamDC sharedInstance];
    [GameDC sharedInstance];
    
    // ORDER:
    //  (1) Load Players
    //  (2) Load Teams
    //  (3) Load Games
    
    // Create a smooth popup with the message
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //[hud setMode:MBProgressHUDModeAnnularDeterminate];
    [hud setLabelText:@"Loading Season"];
    
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.01 * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        
        // Load players for selected season and then segue
        [[NSNotificationCenter defaultCenter] addObserver:self 
                                                 selector:@selector(seguePart1) 
                                                     name:@"PlayersLoaded" 
                                                   object:[PlayerDC sharedInstance]];
        [[SeasonDC sharedInstance] setSelected:indexPath.row];
        [[PlayerDC sharedInstance] loadPlayers];
    });
}

# pragma mark - Private Methods

- (void)commonInit {
    self.navigationItem.title = [[LeagueDC sharedInstance] selectedLeague].name;
}

- (void)seguePart1 {
    
    // Load teams for selected season and then segue
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[NSNotificationCenter defaultCenter] addObserver:self 
                                             selector:@selector(seguePart2) 
                                                 name:@"TeamsLoaded" 
                                               object:[TeamDC sharedInstance]];
    [[TeamDC sharedInstance] loadTeams];
}

- (void)seguePart2 {
    
    // Load games for selected season and then segue
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[NSNotificationCenter defaultCenter] addObserver:self 
                                             selector:@selector(seguePart3) 
                                                 name:@"GamesLoaded" 
                                               object:[GameDC sharedInstance]];
    [[GameDC sharedInstance] loadGames];
}

- (void)seguePart3 {
    
    // Hide the progress indicator
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    // Segue
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self performSegueWithIdentifier:@"ShowSeasonDetailsSegue" sender:self];
}

@end
