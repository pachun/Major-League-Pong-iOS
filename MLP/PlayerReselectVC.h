//
//  PlayerReselectVC.h
//  MLP
//
//  Created by Nicholas Pachulski on 4/18/12.
//  Copyright (c) 2012 RPI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlayerReselectVC : UITableViewController
@property int selectedPlayersID;
@property int playersTeamIndex;
@property(copy, nonatomic)NSString *team;
@property(weak, nonatomic)id delegate;
@end
