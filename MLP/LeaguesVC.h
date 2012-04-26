//
//  LeaguesVC.h
//  MLP
//
//  Created by Nicholas Pachulski on 4/3/12.
//  Copyright (c) 2012 RPI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeaguesVC : UITableViewController
@property(strong, nonatomic)IBOutlet UIBarButtonItem *signOutButton;

- (void)signOutPressed;
@end
