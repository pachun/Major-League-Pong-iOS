//
//  PlayerDetailVC.m
//  MLP
//
//  Created by Nicholas Pachulski on 4/8/12.
//  Copyright (c) 2012 RPI. All rights reserved.
//

#import "Player.h"
#import "PlayerDC.h"

#import "PlayerDetailVC.h"

@interface PlayerDetailVC ()

@end

@implementation PlayerDetailVC
@synthesize gravatar = _gravatar;
@synthesize playerNameLabel = _playerNameLabel;
@synthesize pointPercentageLabel = _pointPercentageLabel;
@synthesize hitPercentageLabel = _hitPercentageLabel;
@synthesize shotCountLabel = _shotCountLabel;
@synthesize hitCountLabel = _hitCountLabel;
@synthesize winsLabel = _winsLabel;
@synthesize lossesLabel = _lossesLabel;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    Player *current = [[PlayerDC sharedInstance] selectedPlayer];
    self.gravatar.image = [UIImage imageWithData:[current gravatar]];
    self.playerNameLabel.text = current.name;
    self.pointPercentageLabel.text = [NSString stringWithFormat:@"%0.3f", current.pointPercentage];
    self.hitPercentageLabel.text = [NSString stringWithFormat:@"%0.3f", current.hitPercentage];
    self.shotCountLabel.text = [NSString stringWithFormat:@"%i", current.shotCount];
    self.hitCountLabel.text = [NSString stringWithFormat:@"%i", current.hitCount];
    self.winsLabel.text = [NSString stringWithFormat:@"%i", current.wins];
    self.lossesLabel.text = [NSString stringWithFormat:@"%i", current.losses];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
