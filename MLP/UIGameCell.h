//
//  UIGameCellCell.h
//  MLP
//
//  Created by Nicholas Pachulski on 4/5/12.
//  Copyright (c) 2012 RPI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIGameCell : UITableViewCell
@property(strong, nonatomic)IBOutlet UILabel *homeTeamLabel;
@property(strong, nonatomic)IBOutlet UILabel *awayTeamLabel;
@property(strong, nonatomic)IBOutlet UILabel *timeLabel;
@end
