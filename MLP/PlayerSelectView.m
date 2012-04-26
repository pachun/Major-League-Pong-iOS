//
//  PlayerSelectView.m
//  MLP
//
//  Created by Nicholas Pachulski on 4/7/12.
//  Copyright (c) 2012 RPI. All rights reserved.
//

#import "PlayerSelectView.h"

@implementation PlayerSelectView
@synthesize player1Image = _player1Image;
@synthesize player2Image = _player2Image;
@synthesize player3Image = _player3Image;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
