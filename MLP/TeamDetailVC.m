//
//  TeamDetailVC.m
//  MLP
//
//  Created by Nicholas Pachulski on 4/8/12.
//  Copyright (c) 2012 RPI. All rights reserved.
//

#import "Team.h"
#import "TeamDC.h"

#import "Player.h"
#import "PlayerDC.h"

#import "TeamDetailVC.h"

@interface TeamDetailVC ()

@end

@implementation TeamDetailVC
@synthesize player1Gravatar = _player1Gravatar;
@synthesize player2Gravatar = _player2Gravatar;
@synthesize player3Gravatar = _player3Gravatar;
@synthesize pointPercentageLabel = _pointPercentageLabel;
@synthesize hitPercentageLabel = _hitPercentageLabel;
@synthesize shotCountLabel = _shotCountLabel;
@synthesize hitCountLabel = _hitCountLabel;
@synthesize winsLabel = _winsLabel;
@synthesize lossesLabel = _lossesLabel;
@synthesize gravatar1Gesturizer = _gravatar1Gesturizer;
@synthesize gravatar2Gesturizer = _gravatar2Gesturizer;
@synthesize gravatar3Gesturizer = _gravatar3Gesturizer;

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
    
    // Set up the outlets
    Team *selected = [[TeamDC sharedInstance] selectedTeam];
    
    self.navigationItem.title = selected.name;
    
    int pid1 = ((Player *)[[selected players] objectAtIndex:0]).identifier;
    int pid2 = ((Player *)[[selected players] objectAtIndex:1]).identifier;
    int pid3 = ((Player *)[[selected players] objectAtIndex:2]).identifier;
    
    self.player1Gravatar.image = [UIImage imageWithData:((Player *)[[PlayerDC sharedInstance] playerWithIdentifier:pid1]).gravatar];
    self.player2Gravatar.image = [UIImage imageWithData:((Player *)[[PlayerDC sharedInstance] playerWithIdentifier:pid2]).gravatar];
    self.player3Gravatar.image = [UIImage imageWithData:((Player *)[[PlayerDC sharedInstance] playerWithIdentifier:pid3]).gravatar];
    
    self.pointPercentageLabel.text = [NSString stringWithFormat:@"%0.3f", selected.pointPercentage];
    self.hitPercentageLabel.text = [NSString stringWithFormat:@"%0.3f", selected.hitPercentage];
    self.shotCountLabel.text = [NSString stringWithFormat:@"%i", selected.shotCount];
    self.hitCountLabel.text = [NSString stringWithFormat:@"%i", selected.hitCount];
    self.winsLabel.text = [NSString stringWithFormat:@"%i", selected.wins];
    self.lossesLabel.text = [NSString stringWithFormat:@"%i", selected.losses];
    
    // Link to player gravatars to player profiles on tap
    self.player1Gravatar.userInteractionEnabled = YES;
    self.player2Gravatar.userInteractionEnabled = YES;
    self.player3Gravatar.userInteractionEnabled = YES;
    
    self.gravatar1Gesturizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(Gravatar1Tapped)];
    self.gravatar2Gesturizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(Gravatar2Tapped)];
    self.gravatar3Gesturizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(Gravatar3Tapped)];
    
    [self.gravatar1Gesturizer setNumberOfTapsRequired:1];
    [self.gravatar2Gesturizer setNumberOfTapsRequired:1];
    [self.gravatar3Gesturizer setNumberOfTapsRequired:1];
    
    [self.gravatar1Gesturizer setNumberOfTouchesRequired:1];
    [self.gravatar2Gesturizer setNumberOfTouchesRequired:1];
    [self.gravatar3Gesturizer setNumberOfTouchesRequired:1];
    
    [self.player1Gravatar addGestureRecognizer:self.gravatar1Gesturizer];
    [self.player2Gravatar addGestureRecognizer:self.gravatar2Gesturizer];
    [self.player3Gravatar addGestureRecognizer:self.gravatar3Gesturizer];
}

- (void)Gravatar1Tapped {
    
    // Set selected player to tapped player and segue to player details
    Team *selectedTeam = [[TeamDC sharedInstance] selectedTeam];
    int selectedPlayeridentifier = ((Player *)[selectedTeam.players objectAtIndex:0]).identifier;
    int selectedPlayerIndex = [[PlayerDC sharedInstance] indexOfPlayerWithIdentifier:selectedPlayeridentifier];
    [[PlayerDC sharedInstance] setSelected:selectedPlayerIndex];
    [self performSegueWithIdentifier:@"TeamPlayerDetailsSegue" sender:self];
}

- (void)Gravatar2Tapped {
    
    // Set selected player to tapped player and segue to player details
    Team *selectedTeam = [[TeamDC sharedInstance] selectedTeam];
    int selectedPlayeridentifier = ((Player *)[selectedTeam.players objectAtIndex:1]).identifier;
    int selectedPlayerIndex = [[PlayerDC sharedInstance] indexOfPlayerWithIdentifier:selectedPlayeridentifier];
    [[PlayerDC sharedInstance] setSelected:selectedPlayerIndex];
    [self performSegueWithIdentifier:@"TeamPlayerDetailsSegue" sender:self];
}


- (void)Gravatar3Tapped {
    
    // Set selected player to tapped player and segue to player details
    Team *selectedTeam = [[TeamDC sharedInstance] selectedTeam];
    int selectedPlayeridentifier = ((Player *)[selectedTeam.players objectAtIndex:2]).identifier;
    int selectedPlayerIndex = [[PlayerDC sharedInstance] indexOfPlayerWithIdentifier:selectedPlayeridentifier];
    [[PlayerDC sharedInstance] setSelected:selectedPlayerIndex];
    [self performSegueWithIdentifier:@"TeamPlayerDetailsSegue" sender:self];
}

/*
- (void)ClickEventOnImage:(UIImageView *)gravatarTouched {
    NSLog(@"Event triggered!");
    
    Team *selectedTeam = [[TeamDC sharedInstance] selectedTeam];
    
    if(gravatarTouched == self.player1Gravatar) {
        int selectedPlayeridentifier = ((Player *)[selectedTeam.players objectAtIndex:0]).identifier;
        int selectedPlayerIndex = [[PlayerDC sharedInstance] indexOfPlayerWithIdentifier:selectedPlayeridentifier];
        [[PlayerDC sharedInstance] setSelected:selectedPlayerIndex];
        [self performSegueWithIdentifier:@"TeamPlayerDetailsSegue" sender:self];
    } else if(gravatarTouched == self.player2Gravatar) {
        int selectedPlayeridentifier = ((Player *)[selectedTeam.players objectAtIndex:1]).identifier;
        int selectedPlayerIndex = [[PlayerDC sharedInstance] indexOfPlayerWithIdentifier:selectedPlayeridentifier];
        [[PlayerDC sharedInstance] setSelected:selectedPlayerIndex];
        [self performSegueWithIdentifier:@"TeamPlayerDetailsSegue" sender:self];
    } if(gravatarTouched == self.player3Gravatar) {
        int selectedPlayeridentifier = ((Player *)[selectedTeam.players objectAtIndex:2]).identifier;
        int selectedPlayerIndex = [[PlayerDC sharedInstance] indexOfPlayerWithIdentifier:selectedPlayeridentifier];
        [[PlayerDC sharedInstance] setSelected:selectedPlayerIndex];
        [self performSegueWithIdentifier:@"TeamPlayerDetailsSegue" sender:self];
    }
}
*/

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
