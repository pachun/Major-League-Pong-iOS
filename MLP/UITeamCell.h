//
//  UITeamCell.h
//  MLP
//
//  Created by Nicholas Pachulski on 4/5/12.
//  Copyright (c) 2012 RPI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITeamCell : UITableViewCell
@property(strong, nonatomic)IBOutlet UILabel *nameLabel;
@property(strong, nonatomic)IBOutlet UILabel *LPPLabel;
@property(strong, nonatomic)IBOutlet UILabel *winLossLabel;
@property(strong, nonatomic)IBOutlet UIImageView *player1Gravatar;
@property(strong, nonatomic)IBOutlet UIImageView *player2Gravatar;
@property(strong, nonatomic)IBOutlet UIImageView *player3Gravatar;
@end
