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

# pragma mark - Instance Methods

- (void)flashLabel {
    NSLog(@"Flashing cup indicator!");
    
    // (1) Show for .4 seconds
    // (2) hide for .2
    // (3) show for .2
    // (4) repeat 2 & 3
    [UIView animateWithDuration:0.4 
                          delay:.4 
                        options:kNilOptions 
                     animations:^{
                         [_cupLabel setHidden:YES];
                     } 
                     completion:^(BOOL finished) { NSLog(@"Done!"); }];
    
    for(int i = 0; i < 2; i++) {
        [UIView animateWithDuration:0.2 
                              delay:.2 
                            options:kNilOptions 
                         animations:^{
                             [_cupLabel setHidden:NO];
                         } 
                         completion:^(BOOL finished) { NSLog(@"Done!"); }];
        [UIView animateWithDuration:0.2 
                              delay:.2 
                            options:kNilOptions 
                         animations:^{
                             [_cupLabel setHidden:YES];
                         } 
                         completion:^(BOOL finished) { NSLog(@"Done!"); }];
    }
}

# pragma mark - Interface Actions

- (IBAction)cupHit {
    ScoreGameVC *score = (ScoreGameVC *)_delegate;
    [score cupHitInView:self];
}

- (IBAction)cupMissed {
    ScoreGameVC *score = (ScoreGameVC *)_delegate;
    [score cupMissedInView:self];
}

- (IBAction)undoTapped {
    ScoreGameVC *score = (ScoreGameVC *)_delegate;
    [score undoTappedForPlayerView:self];
}

@end
