//
//  TeamDetailVC.h
//  MLP
//
//  Created by Nicholas Pachulski on 4/8/12.
//  Copyright (c) 2012 RPI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TeamDetailVC : UITableViewController <UIGestureRecognizerDelegate>
@property(strong, nonatomic)IBOutlet UIImageView *player1Gravatar;
@property(strong, nonatomic)IBOutlet UIImageView *player2Gravatar;
@property(strong, nonatomic)IBOutlet UIImageView *player3Gravatar;
@property(strong, nonatomic)IBOutlet UILabel *pointPercentageLabel;
@property(strong, nonatomic)IBOutlet UILabel *hitPercentageLabel;
@property(strong, nonatomic)IBOutlet UILabel *shotCountLabel;
@property(strong, nonatomic)IBOutlet UILabel *hitCountLabel;
@property(strong, nonatomic)IBOutlet UILabel *winsLabel;
@property(strong, nonatomic)IBOutlet UILabel *lossesLabel;
@property(strong, nonatomic)UITapGestureRecognizer *gravatar1Gesturizer;
@property(strong, nonatomic)UITapGestureRecognizer *gravatar2Gesturizer;
@property(strong, nonatomic)UITapGestureRecognizer *gravatar3Gesturizer;
@end
