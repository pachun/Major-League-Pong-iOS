//
//  ScoreGameVC.m
//  MLP
//
//  Created by Nicholas Pachulski on 4/26/12.
//  Copyright (c) 2012 RPI. All rights reserved.
//


# pragma mark - Imports

#import "ScoreGameVC.h"

// Model Imports
#import "Shot.h"
#import "Game.h"
#import "Team.h"
#import "Round.h"
#import "Season.h"
#import "League.h"
#import "Player.h"
#import "GameScore.h"

// View Imports
#import "WinnerView.h"
#import "PlayerTurnView.h"

// Controller Imports
#import "GameDC.h"
#import "PlayerDC.h"
#import "SeasonDC.h"
#import "LeagueDC.h"

@interface ScoreGameVC ()
- (void)commonInit;
- (void)prepareForGame;
- (void)prepareForRound;
- (void)prepareForTurn;
- (void)checkForWinner;
- (void)reportScore;
- (void)doneGame;
- (void)updateHitCounter;
- (void)shooter:(Player*)shooter didHitACup:(BOOL)didHit;
- (void)updateViewForShooter:(Player *)shooter withCupHit:(BOOL)didHit;
@end

@implementation ScoreGameVC

# pragma mark - Accessor Synthesizers

@synthesize score = _score;
@synthesize winnerView = _winnerView;
@synthesize doneWithGameTap = _doneWithGameTap;
@synthesize homeTeamPlayers = _homeTeamPlayers,
            awayTeamPlayers = _awayTeamPlayers;
@synthesize player1TurnView = _player1TurnView,
            player2TurnView = _player2TurnView,
            player3TurnView = _player3TurnView;
@synthesize playerTurnViews = _playerTurnViews;
@synthesize homeTeamCupHits = _homeTeamCupHits,
            awayTeamCupHits = _awayTeamCupHits,
            roundCount = _roundCount,
            shotInRound = _shotInRound,
            shootingTeamIdentifier = _shootingTeamIdentifier;

# pragma  mark - Accessor Overrides

// Get a mutable copy...
- (void)setHomeTeamPlayers:(NSMutableArray *)homeTeamPlayers {
    if(_homeTeamPlayers != homeTeamPlayers)
        _homeTeamPlayers = [homeTeamPlayers mutableCopy];
}

// Get a mutable copy...
- (void)setAwayTeamPlayers:(NSMutableArray *)awayTeamPlayers {
    if(_awayTeamPlayers != awayTeamPlayers)
        _awayTeamPlayers = [awayTeamPlayers mutableCopy];
}

// Get a mutable copy...
- (void)setPlayerTurnViews:(NSMutableArray *)playerTurnViews {
    if(_playerTurnViews != playerTurnViews)
        _playerTurnViews = [playerTurnViews mutableCopy];
}

# pragma mark - Instance Methods

// Storyboard initializer
- (id)initWithCoder:(NSCoder *)aDecoder {
    if(self = [super initWithCoder:aDecoder]) {
        [self commonInit];
        return self;
    }
    return nil;
}

# pragma mark - View Methods

// (After prepareForSegue in previous VC)
- (void)viewWillAppear:(BOOL)animated {
    
    // Populate local players array for convenience
    for(NSNumber *identifier in _score.homeTeamPlayerIdentifiers)
    {
        Player *current = [[PlayerDC sharedInstance] playerWithIdentifier:[identifier intValue]];
        [_homeTeamPlayers addObject:current];
    }
    for(NSNumber *identifier in _score.awayTeamPlayerIdentifiers)
    {
        Player *current = [[PlayerDC sharedInstance] playerWithIdentifier:[identifier intValue]];
        [_awayTeamPlayers addObject:current];
    }
    
    // Put the turn views in a local array
    [_playerTurnViews addObject:_player1TurnView];
    [_playerTurnViews addObject:_player2TurnView];
    [_playerTurnViews addObject:_player3TurnView];
    
    // Set this VC as the turn view's delegates
    for(PlayerTurnView *ptv in _playerTurnViews)
        ptv.delegate = self;
    
    // Prepare last touch gesturizer
    [_doneWithGameTap setNumberOfTapsRequired:1];
    [_doneWithGameTap setNumberOfTouchesRequired:1];
    _winnerView.userInteractionEnabled = YES;
    [_winnerView addGestureRecognizer:_doneWithGameTap];
    
    // Set up for new game
    [self prepareForGame];
}

// Only landscape orientations
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft ||
            interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

# pragma mark - Private Methods

// Initialize member arrays (before prepareForSegue in previous VC)
- (void)commonInit {
    _score = [GameScore new];
    _playerTurnViews = [NSMutableArray new];
    _homeTeamPlayers = [NSMutableArray new];
    _awayTeamPlayers = [NSMutableArray new];
    
    // initialize gesturizer that detects end of game touches
    _doneWithGameTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doneGame)];
}

- (void)doneGame {
    [self dismissModalViewControllerAnimated:YES];
}

- (void)prepareForGame {
    
    // Set up game metadata
    _roundCount = -1;
    _homeTeamCupHits = 0;
    _awayTeamCupHits = 0;
    
    // Prepare for a new round
    [self prepareForRound];
}

- (void)prepareForRound {
    
    // Set up round metadata
    _shotInRound = 0;
    _roundCount++;
    
    // Add a round to the score object
    [_score addRound];
    
    // Prepare for a new turn
    [self prepareForTurn];
}

- (void)prepareForTurn {
    
    // Update title to reflect current teams cup hit count
    [self updateHitCounter];
    
    // Set the player gravatars and names
    int index = 0;
    if(_shootingTeamIdentifier == _score.homeTeamIdentifier) {
        for(Player *p in _homeTeamPlayers) {
            [((PlayerTurnView*)[_playerTurnViews objectAtIndex:index]) setPlayer:p];
            index++;
        }
    } else {
        for(Player *p in _awayTeamPlayers) {
            [((PlayerTurnView*)[_playerTurnViews objectAtIndex:index]) setPlayer:p];
            index++;
        }
    }
    
    // Ensure correct view components are displayed/hidden
    for(PlayerTurnView *ptv in _playerTurnViews) {
        [ptv setBackgroundColor:[UIColor whiteColor]];
        [ptv.hitButton setHidden:NO];
        [ptv.missButton setHidden:NO];
        [ptv.undoButton setHidden:YES];
        [ptv.cupLabel setHidden:YES];
    }
}

- (void)checkForWinner {
    if(_homeTeamCupHits == 10 || _awayTeamCupHits == 10) {
        
        // report the score to the server
        [self reportScore];
        
        // Prepare winner view
        if(_homeTeamCupHits==10) _winnerView.winnerLabel.text = [[GameDC sharedInstance] selectedGame].home_team.name;
        else _winnerView.winnerLabel.text = [[GameDC sharedInstance] selectedGame].away_team.name;
        
        // Show winner view
        [_winnerView setHidden:NO];
    }
}

- (void)reportScore {
    
    // Get the current games path for posting
    NSString *path = [[GameDC sharedInstance] selectedGame].path;
    
    // Set this as the post path
    RKObjectRouter *router = [RKObjectRouter new];
    [router routeClass:[GameScore class] toResourcePath:path];
    [RKObjectManager sharedManager].router = router;
    
    // Post the game
    [[RKObjectManager sharedManager] postObject:_score delegate:self];
}

// Reset title to indicate cups remaining (not hit yet)
- (void)updateHitCounter {
    if(_shootingTeamIdentifier == _score.homeTeamIdentifier)
        self.navigationItem.title = [NSString stringWithFormat:@"%i / 10", (10-_homeTeamCupHits)];
    else
        self.navigationItem.title = [NSString stringWithFormat:@"%i / 10", (10-_awayTeamCupHits)];
}

- (void)shooter:(Player*)shooter didHitACup:(BOOL)didHit {
    
    // Create a shot
    Shot *shot = [Shot new];
    
    // Set shot metadata
    shot.leagueIdentifier = [[LeagueDC sharedInstance] selectedLeague].identifier;
    shot.seasonIdentifier = [[SeasonDC sharedInstance] selectedSeason].identifier;
    shot.teamIdentifier = _shootingTeamIdentifier;
    shot.playerIdentifier = shooter.identifier;
    
    // Set shot index and cup
    shot.shotNumberInRound = _shotInRound;
    if(_shootingTeamIdentifier == _score.homeTeamIdentifier) {
        if(didHit) _homeTeamCupHits++;
        shot.cup = _homeTeamCupHits;
    } else {
        if(didHit) _awayTeamCupHits++;
        shot.cup = _awayTeamCupHits;
    }
    
    // Check for a winner!
    [self checkForWinner];
    
    // Add the shot to the game data structure
    [((Round *)[_score.roundsAttributes lastObject]).shots addObject:shot];
    
    // Update the view to reflect hit or miss
    [self updateViewForShooter:shooter withCupHit:didHit];
    
    // Update the round's shot count
    _shotInRound++;
    
    // If necessary, prepare for a new round
    if(_shotInRound == 6) {
        
        // Switch shooting team ID
        _shootingTeamIdentifier = _shootingTeamIdentifier == _score.homeTeamIdentifier  ? _score.awayTeamIdentifier : _score.homeTeamIdentifier;
        
        // Prepare for a new round
        [self prepareForRound];
    }
    
    // If necessary, prepare for a new turn
    if(_shotInRound == 3) {
        
        // Switch shooting team ID
        _shootingTeamIdentifier = _shootingTeamIdentifier == _score.homeTeamIdentifier  ? _score.awayTeamIdentifier : _score.homeTeamIdentifier;
        
        // Prepare for a new round
        [self prepareForTurn];
    }
}

- (void)updateViewForShooter:(Player *)shooter withCupHit:(BOOL)didHit {
    
    // Adjust the appropriate turn view (find it)
    for(PlayerTurnView *ptv in _playerTurnViews)
        if(ptv.player.identifier == shooter.identifier) {
            
            // Update cup label
            if(_shootingTeamIdentifier == _score.homeTeamIdentifier)
                if(!didHit) [ptv.cupLabel setText:@"-"];
                else [ptv.cupLabel setText:[NSString stringWithFormat:@"%i", _homeTeamCupHits]];
            else
                if(!didHit) [ptv.cupLabel setText:@"-"];
                else [ptv.cupLabel setText:[NSString stringWithFormat:@"%i", _awayTeamCupHits]];
            
            // Show/hide relevant turn view components
            [ptv.hitButton setHidden:YES];
            [ptv.missButton setHidden:YES];
            [ptv.undoButton setHidden:NO];
            [ptv.cupLabel setHidden:NO];
            
            // Change the player's name to a white color
            for(PlayerTurnView *ptv in _playerTurnViews)
                if(ptv.player == shooter)
                    ptv.nameLabel.textColor = [UIColor whiteColor];
             
            // Switch background color
            [ptv setBackgroundColor:[UIColor blackColor]];
        }
}

# pragma mark - RKObjectLoader Delegate Methods

- (void)objectLoader:(RKObjectLoader *)objectLoader didFailWithError:(NSError *)error {
    NSLog(@"Object Loader Failed With Error: %@", error);
}

# pragma mark - PlayerTurnView Delegate Methods

- (void)cupHitBy:(Player *)p inView:(PlayerTurnView *)view {
    [self shooter:p didHitACup:YES];
    [self updateHitCounter];
}

- (void)cupMissedBy:(Player *)p inView:(PlayerTurnView *)view {
    [self shooter:p didHitACup:NO];
}

# pragma mark - RKObjectMapping Delegate Methods

@end
