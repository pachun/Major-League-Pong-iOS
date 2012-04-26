//
//  PlayersVC.h
//  MLP
//
//  Created by Nicholas Pachulski on 4/3/12.
//  Copyright (c) 2012 RPI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlayersVC : UITableViewController
@property(strong, nonatomic)IBOutlet UIBarButtonItem *doneButton;
- (IBAction)doneButtonPressed;
@end
