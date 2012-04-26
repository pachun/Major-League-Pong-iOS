//
//  PlayerSelectVC.m
//  MLP
//
//  Created by Nicholas Pachulski on 4/7/12.
//  Copyright (c) 2012 RPI. All rights reserved.
//

#import "Team.h"
#import "TeamDC.h"

#import "Player.h"
#import "PlayerDC.h"

#import "Game.h"
#import "GameDC.h"

#import "GameScore.h"
#import "ScoreGameVC.h"
#import "PlayerTurnView.h"

#import "PlayerSelectView.h"
#import "PlayerReselectVC.h"

#import "PlayerSelectVC.h"

@interface PlayerSelectVC ()
- (void)commonInit;
@end

@implementation PlayerSelectVC

#pragma mark - Accessor Synthesizers

@synthesize cancelGameButton = _cancelGameButton;
@synthesize firstShotTeamIdentifier = _firstShotTeamIdentifier;
@synthesize homeTeamPlayerSelectView = _homeTeamPlayerSelectView;
@synthesize awayTeamPlayerSelectView = _awayTeamPlayerSelectView;
@synthesize homeTeamNameLabel = _homeTeamNameLabel,
            awayTeamNameLabel = _awayTeamNameLabel;
@synthesize reselectHomeTeamPlayerController = _reselectHomeTeamPlayerController,
            reselectAwayTeamPlayerController = _reselectAwayTeamPlayerController;
@synthesize reselectHomeTeamPlayerView = _reselectHomeTeamPlayerView,
            reselectAwayTeamPlayerView = _reselectAwayTeamPlayerView;
@synthesize homeTeamGravatar1Gesturizer = _homeTeamGravatar1Gesturizer,
            homeTeamGravatar2Gesturizer = _homeTeamGravatar2Gesturizer,
            homeTeamGravatar3Gesturizer = _homeTeamGravatar3Gesturizer;
@synthesize awayTeamGravatar1Gesturizer = _awayTeamGravatar1Gesturizer,
            awayTeamGravatar2Gesturizer = _awayTeamGravatar2Gesturizer,
            awayTeamGravatar3Gesturizer = _awayTeamGravatar3Gesturizer;
@synthesize homeTeam = _homeTeam,
            awayTeam = _awayTeam;

#pragma mark - View Methods

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])
        [self commonInit];
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if(self = [super initWithCoder:aDecoder])
        [self commonInit];
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // Hide the status bar
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    
    // Connect mini table views to controllers
    self.reselectAwayTeamPlayerController.tableView = _reselectAwayTeamPlayerView;
    self.reselectHomeTeamPlayerController.tableView = _reselectHomeTeamPlayerView;
    
    // Load team names
    _homeTeamNameLabel.text = _homeTeam.name;
    _awayTeamNameLabel.text = _awayTeam.name;
    
    // Load Gravatars
    Player *htp1 = [[PlayerDC sharedInstance] playerWithIdentifier:((Player *)[self.homeTeam.players objectAtIndex:0]).identifier];
    Player *htp2 = [[PlayerDC sharedInstance] playerWithIdentifier:((Player *)[self.homeTeam.players objectAtIndex:1]).identifier];
    Player *htp3 = [[PlayerDC sharedInstance] playerWithIdentifier:((Player *)[self.homeTeam.players objectAtIndex:2]).identifier];
    Player *atp1 = [[PlayerDC sharedInstance] playerWithIdentifier:((Player *)[self.awayTeam.players objectAtIndex:0]).identifier];
    Player *atp2 = [[PlayerDC sharedInstance] playerWithIdentifier:((Player *)[self.awayTeam.players objectAtIndex:1]).identifier];
    Player *atp3 = [[PlayerDC sharedInstance] playerWithIdentifier:((Player *)[self.awayTeam.players objectAtIndex:2]).identifier];
    
    UIImage *HTp1Image = [UIImage imageWithData:[htp1 gravatar]];
    UIImage *HTp2Image = [UIImage imageWithData:[htp2 gravatar]];
    UIImage *HTp3Image = [UIImage imageWithData:[htp3 gravatar]];
    UIImage *ATp1Image = [UIImage imageWithData:[atp1 gravatar]];
    UIImage *ATp2Image = [UIImage imageWithData:[atp2 gravatar]];
    UIImage *ATp3Image = [UIImage imageWithData:[atp3 gravatar]];
    
    _homeTeamPlayerSelectView.player1Image.image = HTp1Image;
    _homeTeamPlayerSelectView.player2Image.image = HTp2Image;
    _homeTeamPlayerSelectView.player3Image.image = HTp3Image;
    _awayTeamPlayerSelectView.player1Image.image = ATp1Image;
    _awayTeamPlayerSelectView.player2Image.image = ATp2Image;
    _awayTeamPlayerSelectView.player3Image.image = ATp3Image;
    
    // Add a single touch gesturizer to each gravatar
    _homeTeamPlayerSelectView.player1Image.userInteractionEnabled = YES;
    _homeTeamPlayerSelectView.player2Image.userInteractionEnabled = YES;
    _homeTeamPlayerSelectView.player3Image.userInteractionEnabled = YES;
    _awayTeamPlayerSelectView.player1Image.userInteractionEnabled = YES;
    _awayTeamPlayerSelectView.player2Image.userInteractionEnabled = YES;
    _awayTeamPlayerSelectView.player3Image.userInteractionEnabled = YES;
    
    _homeTeamGravatar1Gesturizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(homeTeamPlayer1Select)];
    _homeTeamGravatar2Gesturizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(homeTeamPlayer2Select)];
    _homeTeamGravatar3Gesturizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(homeTeamPlayer3Select)];
    _awayTeamGravatar1Gesturizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(awayTeamPlayer1Select)];
    _awayTeamGravatar2Gesturizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(awayTeamPlayer2Select)];
    _awayTeamGravatar3Gesturizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(awayTeamPlayer3Select)];
    
    [_homeTeamGravatar1Gesturizer setNumberOfTapsRequired:1];
    [_homeTeamGravatar2Gesturizer setNumberOfTapsRequired:1];
    [_homeTeamGravatar3Gesturizer setNumberOfTapsRequired:1];
    [_awayTeamGravatar1Gesturizer setNumberOfTapsRequired:1];
    [_awayTeamGravatar2Gesturizer setNumberOfTapsRequired:1];
    [_awayTeamGravatar3Gesturizer setNumberOfTapsRequired:1];
    
    [_homeTeamGravatar1Gesturizer setNumberOfTouchesRequired:1];
    [_homeTeamGravatar2Gesturizer setNumberOfTouchesRequired:1];
    [_homeTeamGravatar3Gesturizer setNumberOfTouchesRequired:1];
    [_awayTeamGravatar1Gesturizer setNumberOfTouchesRequired:1];
    [_awayTeamGravatar2Gesturizer setNumberOfTouchesRequired:1];
    [_awayTeamGravatar3Gesturizer setNumberOfTouchesRequired:1];
    
    [_homeTeamPlayerSelectView.player1Image addGestureRecognizer:_homeTeamGravatar1Gesturizer];
    [_homeTeamPlayerSelectView.player2Image addGestureRecognizer:_homeTeamGravatar2Gesturizer];
    [_homeTeamPlayerSelectView.player3Image addGestureRecognizer:_homeTeamGravatar3Gesturizer];
    [_awayTeamPlayerSelectView.player1Image addGestureRecognizer:_awayTeamGravatar1Gesturizer];
    [_awayTeamPlayerSelectView.player2Image addGestureRecognizer:_awayTeamGravatar2Gesturizer];
    [_awayTeamPlayerSelectView.player3Image addGestureRecognizer:_awayTeamGravatar3Gesturizer];
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft ||
            interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

# pragma mark - Gesturizer Actions

- (void)awayTeamPlayer1Select {
    
    // Reset data and reload table view
    [self.reselectAwayTeamPlayerController setDelegate:self];
    [self.reselectAwayTeamPlayerController setPlayersTeamIndex:0];
    [self.reselectAwayTeamPlayerController setSelectedPlayersID:((Player *)[self.awayTeam.players objectAtIndex:0]).identifier];
    [self.reselectAwayTeamPlayerController.tableView reloadData];
    
    // Unhide table view
    [self.reselectAwayTeamPlayerController.tableView setHidden:NO];
}

- (void)awayTeamPlayer2Select {
    
    // Reset data and reload table view
    [self.reselectAwayTeamPlayerController setDelegate:self];
    [self.reselectAwayTeamPlayerController setPlayersTeamIndex:1];
    [self.reselectAwayTeamPlayerController setSelectedPlayersID:((Player *)[self.awayTeam.players objectAtIndex:1]).identifier];
    [self.reselectAwayTeamPlayerController.tableView reloadData];
    
    // Unhide table view
    [self.reselectAwayTeamPlayerController.tableView setHidden:NO];
}

- (void)awayTeamPlayer3Select {
    
    // Reset data and reload table view
    [self.reselectAwayTeamPlayerController setDelegate:self];
    [self.reselectAwayTeamPlayerController setPlayersTeamIndex:2];
    [self.reselectAwayTeamPlayerController setSelectedPlayersID:((Player *)[self.awayTeam.players objectAtIndex:2]).identifier];
    [self.reselectAwayTeamPlayerController.tableView reloadData];
    
    // Unhide table view
    [self.reselectAwayTeamPlayerController.tableView setHidden:NO];
}

- (void)homeTeamPlayer1Select {
    
    // Reset data and reload table view
    [self.reselectHomeTeamPlayerController setDelegate:self];
    [self.reselectHomeTeamPlayerController setPlayersTeamIndex:0];
    [self.reselectHomeTeamPlayerController setSelectedPlayersID:((Player *)[self.homeTeam.players objectAtIndex:0]).identifier];
    [self.reselectHomeTeamPlayerController.tableView reloadData];
    
    // Unhide table view
    [self.reselectHomeTeamPlayerController.tableView setHidden:NO];
}

- (void)homeTeamPlayer2Select {
    
    // Reset data and reload table view
    [self.reselectHomeTeamPlayerController setDelegate:self];
    [self.reselectHomeTeamPlayerController setPlayersTeamIndex:1];
    [self.reselectHomeTeamPlayerController setSelectedPlayersID:((Player *)[self.homeTeam.players objectAtIndex:1]).identifier];
    [self.reselectHomeTeamPlayerController.tableView reloadData];
    
    // Unhide table view
    [self.reselectHomeTeamPlayerController.tableView setHidden:NO];
}

- (void)homeTeamPlayer3Select {
    
    // Reset data and reload table view
    [self.reselectHomeTeamPlayerController setDelegate:self];
    [self.reselectHomeTeamPlayerController setPlayersTeamIndex:2];
    [self.reselectHomeTeamPlayerController setSelectedPlayersID:((Player *)[self.homeTeam.players objectAtIndex:2]).identifier];
    [self.reselectHomeTeamPlayerController.tableView reloadData];
    
    // Unhide table view
    [self.reselectHomeTeamPlayerController.tableView setHidden:NO];
}

# pragma mark - PlayerSelectVC Delegate Methods

- (void)playerReselectedOnTeam:(NSString *)team forTeamIndex:(int)teamPlayerIndex withNewPlayerIdentifier:(int)identifier {
    
    if([team isEqualToString:@"Away"]) {
        [self.awayTeam.players replaceObjectAtIndex:teamPlayerIndex withObject:[[PlayerDC sharedInstance] playerWithIdentifier:identifier]];
        [self.reselectAwayTeamPlayerView setHidden:YES];
    } else {
        [self.homeTeam.players replaceObjectAtIndex:teamPlayerIndex withObject:[[PlayerDC sharedInstance] playerWithIdentifier:identifier]];
        [self.reselectHomeTeamPlayerView setHidden:YES];
    }
    
    [self viewWillAppear:YES];
}

# pragma mark - Interface Actions

- (IBAction)cancelButtonTapped {
    
    // Unhide the status bar
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)homeTeamShootsFirst {
    
    self.firstShotTeamIdentifier = self.homeTeam.identifier;
    [self performSegueWithIdentifier:@"StartGameSegue" sender:self];
}

- (IBAction)awayTeamShootsFirst {
    
    self.firstShotTeamIdentifier = self.awayTeam.identifier;
    [self performSegueWithIdentifier:@"StartGameSegue" sender:self];
}

# pragma mark - Private Methods


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if([[segue identifier] isEqualToString:@"StartGameSegue"]) {
        
        // Sync team and player data to next VC
        Game *selectedGame = [[GameDC sharedInstance] selectedGame];
        ScoreGameVC *scoreView = (ScoreGameVC *)[segue destinationViewController];
        
        scoreView.shootingTeamIdentifier = self.firstShotTeamIdentifier;
        
        scoreView.score.homeTeamIdentifier = self.homeTeam.identifier;
        scoreView.score.awayTeamIdentifier = self.awayTeam.identifier;
        
        scoreView.score.dateString = [selectedGame date];
        scoreView.score.timeString = [selectedGame time];
        
        for(Player *p in self.homeTeam.players)
            [scoreView.score.homeTeamPlayerIdentifiers addObject:[NSNumber numberWithInt:p.identifier]];
        
        for(Player *p in self.awayTeam.players)
            [scoreView.score.awayTeamPlayerIdentifiers addObject:[NSNumber numberWithInt:p.identifier]];
    }
}

- (void)commonInit {
    
    // Set up default team players
    Game *selectedGame = [[GameDC sharedInstance] selectedGame];
    self.homeTeam = [[TeamDC sharedInstance] teamWithIdentifier:selectedGame.home_team.identifier];
    self.awayTeam = [[TeamDC sharedInstance] teamWithIdentifier:selectedGame.away_team.identifier];
    
    // Initialize mini table view controllers
    self.reselectAwayTeamPlayerController = [[PlayerReselectVC alloc] init];
    self.reselectAwayTeamPlayerController.selectedPlayersID = 1;
    self.reselectAwayTeamPlayerController.team = @"Away";
    
    self.reselectHomeTeamPlayerController = [[PlayerReselectVC alloc] init];
    self.reselectHomeTeamPlayerController.selectedPlayersID = 1;
    self.reselectHomeTeamPlayerController.team = @"Home";
}

@end
