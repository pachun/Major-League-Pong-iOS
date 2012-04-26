//
//  PlayerSelectVC.h
//  MLP
//
//  Created by Nicholas Pachulski on 4/7/12.
//  Copyright (c) 2012 RPI. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PlayerSelectView;
@class PlayerReselectVC;
@interface PlayerSelectVC : UIViewController
@property int firstShotTeamIdentifier;
@property(copy, nonatomic)Team *homeTeam;
@property(copy, nonatomic)Team *awayTeam;
@property(strong, nonatomic)IBOutlet UILabel *homeTeamNameLabel;
@property(strong, nonatomic)IBOutlet UILabel *awayTeamNameLabel;
@property(strong, nonatomic)IBOutlet UIBarButtonItem *cancelGameButton;
@property(strong, nonatomic)IBOutlet PlayerSelectView *homeTeamPlayerSelectView;
@property(strong, nonatomic)IBOutlet PlayerSelectView *awayTeamPlayerSelectView;
@property(strong, nonatomic)UITapGestureRecognizer *homeTeamGravatar1Gesturizer;
@property(strong, nonatomic)UITapGestureRecognizer *homeTeamGravatar2Gesturizer;
@property(strong, nonatomic)UITapGestureRecognizer *homeTeamGravatar3Gesturizer;
@property(strong, nonatomic)UITapGestureRecognizer *awayTeamGravatar1Gesturizer;
@property(strong, nonatomic)UITapGestureRecognizer *awayTeamGravatar2Gesturizer;
@property(strong, nonatomic)UITapGestureRecognizer *awayTeamGravatar3Gesturizer;
@property(strong, nonatomic)IBOutlet UITableView *reselectHomeTeamPlayerView;
@property(strong, nonatomic)IBOutlet UITableView *reselectAwayTeamPlayerView;
@property(strong, nonatomic)PlayerReselectVC *reselectHomeTeamPlayerController;
@property(strong, nonatomic)PlayerReselectVC *reselectAwayTeamPlayerController;

- (void)playerReselectedOnTeam:(NSString *)team forTeamIndex:(int)teamPlayerIndex withNewPlayerIdentifier:(int)identifier;
- (IBAction)cancelButtonTapped;
- (IBAction)homeTeamShootsFirst;
- (IBAction)awayTeamShootsFirst;
@end
