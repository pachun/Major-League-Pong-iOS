//
//  PlayerCell.h
//  MLP
//
//  Created by Nicholas Pachulski on 4/5/12.
//  Copyright (c) 2012 RPI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIPlayerCell : UITableViewCell
@property(strong, nonatomic)IBOutlet UILabel *nameLabel;
@property(strong, nonatomic)IBOutlet UILabel *LPPLabel;
@property(strong, nonatomic)IBOutlet UIImageView *gravatarImage;
@end
