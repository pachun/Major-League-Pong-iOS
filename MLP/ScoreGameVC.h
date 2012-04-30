//
//  ScoreGameVC.h
//  MLP
//
//  Created by Nicholas Pachulski on 4/26/12.
//  Copyright (c) 2012 RPI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <RestKit/RestKit.h>

@class GameScore, PlayerTurnView, WinnerView, Player;
@interface ScoreGameVC : UIViewController <RKObjectLoaderDelegate>
@property(strong, nonatomic)GameScore *score;
@property(copy, nonatomic)NSMutableArray *homeTeamPlayers;
@property(copy, nonatomic)NSMutableArray *awayTeamPlayers;
@property(copy, nonatomic)NSMutableArray *playerTurnViews;
@property(strong, nonatomic)UITapGestureRecognizer *doneWithGameTap;
@property(strong, nonatomic)IBOutlet PlayerTurnView *player1TurnView;
@property(strong, nonatomic)IBOutlet PlayerTurnView *player2TurnView;
@property(strong, nonatomic)IBOutlet PlayerTurnView *player3TurnView;
@property(strong, nonatomic)IBOutlet WinnerView *winnerView;

@property int roundCount;
@property int shotInRound;
@property int homeTeamCupHits;
@property int awayTeamCupHits;
@property int shootingTeamIdentifier;

- (void)undoTappedForPlayerView:(PlayerTurnView *)view;
- (void)cupHitBy:(Player *)p inView:(PlayerTurnView *)view;
- (void)cupMissedBy:(Player *)p inView:(PlayerTurnView *)view;
@end