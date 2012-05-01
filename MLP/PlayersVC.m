//
//  PlayersVC.m
//  MLP
//
//  Created by Nicholas Pachulski on 4/3/12.
//  Copyright (c) 2012 RPI. All rights reserved.
//

#import "Season.h"
#import "SeasonDC.h"

#import "Player.h"
#import "PlayerDC.h"

#import "PlayersVC.h"

#import "UIPlayerCell.h"

@interface PlayersVC ()
- (void)commonInit;
@end

@implementation PlayersVC

# pragma mark - Accessor Synthesizers

@synthesize doneButton = _doneButton;

#pragma mark - Interface Actions

-(IBAction) doneButtonPressed {
    [self dismissModalViewControllerAnimated:YES];
}

# pragma mark - Table View Methods

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if(self = [super initWithCoder:aDecoder]) {
        [self commonInit];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.tabBarController.navigationItem.titleView.hidden = YES;
    /* Not Working....
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"Players";
    self.tabBarController.navigationItem.titleView = titleLabel;*/
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table View Data Source Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[PlayerDC sharedInstance] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"PlayerCell";
    UIPlayerCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    Player *current = [[PlayerDC sharedInstance] playerAtIndex:indexPath.row];
    cell.LPPLabel.text = [NSString stringWithFormat:@"%0.3f", current.pointPercentage];
    cell.gravatarImage.image = [UIImage imageWithData:[current gravatar]];
    cell.nameLabel.text = current.name;
    
    return cell;
}

#pragma mark - Table View Delegate Methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [[PlayerDC sharedInstance] setSelected:indexPath.row];
    [self performSegueWithIdentifier:@"PlayerDetailsSegue" sender:self];
}

# pragma mark - Private Methods

- (void)commonInit { }

@end
