//
//  PlayerDetailVC.h
//  MLP
//
//  Created by Nicholas Pachulski on 4/8/12.
//  Copyright (c) 2012 RPI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlayerDetailVC : UITableViewController
@property(strong, nonatomic)IBOutlet UIImageView *gravatar;
@property(strong, nonatomic)IBOutlet UILabel *playerNameLabel;
@property(strong, nonatomic)IBOutlet UILabel *pointPercentageLabel;
@property(strong, nonatomic)IBOutlet UILabel *hitPercentageLabel;
@property(strong, nonatomic)IBOutlet UILabel *shotCountLabel;
@property(strong, nonatomic)IBOutlet UILabel *hitCountLabel;
@property(strong, nonatomic)IBOutlet UILabel *winsLabel;
@property(strong, nonatomic)IBOutlet UILabel *lossesLabel;
@end
