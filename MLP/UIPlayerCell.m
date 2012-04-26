//
//  PlayerCell.m
//  MLP
//
//  Created by Nicholas Pachulski on 4/5/12.
//  Copyright (c) 2012 RPI. All rights reserved.
//

#import "UIPlayerCell.h"

@implementation UIPlayerCell
@synthesize nameLabel = _nameLabel;
@synthesize LPPLabel = _LPPLabel;
@synthesize gravatarImage = _gravatarImage;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
        return self;
    return nil;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end
