//
//  UITeamCell.m
//  MLP
//
//  Created by Nicholas Pachulski on 4/5/12.
//  Copyright (c) 2012 RPI. All rights reserved.
//

#import "UITeamCell.h"

@implementation UITeamCell
@synthesize nameLabel = _nameLabel;
@synthesize LPPLabel = _LPPLabel;
@synthesize winLossLabel = _winLossLabel;
@synthesize player1Gravatar = _player1Gravatar;
@synthesize player2Gravatar = _player2Gravatar;
@synthesize player3Gravatar = _player3Gravatar;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
