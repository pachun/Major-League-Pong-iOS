//
//  PlayerTurnView.h
//  MLP
//
//  Created by Nicholas Pachulski on 4/19/12.
//  Copyright (c) 2012 RPI. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Player;
@interface PlayerTurnView : UIView
@property(weak, nonatomic)id delegate;
@property(strong, nonatomic)Player *player;
@property(strong, nonatomic)IBOutlet UILabel *cupLabel;
@property(strong, nonatomic)IBOutlet UILabel *nameLabel;
@property(strong, nonatomic)IBOutlet UIButton *hitButton;
@property(strong, nonatomic)IBOutlet UIButton *missButton;
@property(strong, nonatomic)IBOutlet UIButton *undoButton;
@property(strong, nonatomic)IBOutlet UIImageView *playerGravatar;

- (IBAction)cupHit;
- (IBAction)cupMissed;
- (IBAction)undoTapped;
- (void)flashLabel;
@end
