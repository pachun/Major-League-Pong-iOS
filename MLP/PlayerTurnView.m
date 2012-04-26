//
//  PlayerTurnView.m
//  MLP
//
//  Created by Nicholas Pachulski on 4/19/12.
//  Copyright (c) 2012 RPI. All rights reserved.
//

#import "Player.h"

#import "ScoreGameVC.h"
#import "PlayerTurnView.h"

@implementation PlayerTurnView

# pragma mark - Accessor Synthesizers

@synthesize delegate = _delegate;
@synthesize cupLabel = _cupLabel;
@synthesize player = _player;
@synthesize nameLabel = _nameLabel;
@synthesize hitButton = _hitButton,
            missButton = _missButton,
            undoButton = _undoButton;
@synthesize playerGravatar = _playerGravatar;

# pragma mark - Accessor Overrides

// Set the player and set the gravatar for the player
- (void)setPlayer:(Player *)player {
    _player = player;
    self.nameLabel.text = player.name;
    self.nameLabel.textColor = [UIColor blackColor];
    self.playerGravatar.image = [UIImage imageWithData:[player gravatar]];
}

# pragma mark - Interface Actions

- (IBAction)cupHit {
    ScoreGameVC *score = (ScoreGameVC *)_delegate;
    [score cupHitBy:_player inView:self];
}

- (IBAction)cupMissed {
    ScoreGameVC *score = (ScoreGameVC *)_delegate;
    [score cupMissedBy:_player inView:self];
}

- (IBAction)undoHit {
    
}

@end
