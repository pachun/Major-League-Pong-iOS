//
//  PlayerDC.m
//  MLP
//
//  Created by Nicholas Pachulski on 4/3/12.
//  Copyright (c) 2012 RPI. All rights reserved.
//

#import "Player.h"
#import "Season.h"
#import "SeasonDC.h"

#import "PlayerDC.h"

@implementation PlayerDC

#pragma mark - Accessor Synthesizers

@synthesize players = _players;
@synthesize gravatarsGrabbed = _gravatarsGrabbed;
@synthesize selected = _selected;
@synthesize mapping = _mapping;

#pragma mark - Class Methods

static PlayerDC *sharedInstance;
+ (PlayerDC *)sharedInstance {
    if(sharedInstance == nil)
        sharedInstance = [[PlayerDC alloc] init];
    return sharedInstance;
}

+ (NSString *)authpath:(NSString *)path {
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    return [NSString stringWithFormat:@"%@?auth_token=%@", path, [prefs valueForKey:@"token"]];
}

#pragma mark - Instance Methods

- (id)init {
    if(self = [super init]) {
        
        // Initialize object mapping
        self.mapping = [RKObjectMapping mappingForClass:[Player class]];
        [self.mapping mapKeyPath:@"id" toAttribute:@"identifier"];
        [self.mapping mapKeyPath:@"name" toAttribute:@"name"];
        [self.mapping mapKeyPath:@"story" toAttribute:@"story"];
        [self.mapping mapKeyPath:@"email_hash" toAttribute:@"emailHash"];
        [self.mapping mapKeyPath:@"point_percentage" toAttribute:@"pointPercentage"];
        [self.mapping mapKeyPath:@"hit_percentage" toAttribute:@"hitPercentage"];
        [self.mapping mapKeyPath:@"last_cups" toAttribute:@"lastCups"];
        [self.mapping mapKeyPath:@"shot_count" toAttribute:@"shotCount"];
        [self.mapping mapKeyPath:@"hit_count" toAttribute:@"hitCount"];
        [self.mapping mapKeyPath:@"wins" toAttribute:@"wins"];
        [self.mapping mapKeyPath:@"losses" toAttribute:@"losses"];
    }
    return self;
}

- (int)count {
    return [self.players count];
}

- (Player *)selectedPlayer {
    return [self.players objectAtIndex:self.selected];
}

- (Player *)playerAtIndex:(int)index {
    if(index >= 0 && index < [self count])
        return [self.players objectAtIndex:index];
    else
        return nil;
}

- (Player *)playerWithIdentifier:(int)identifier {
    for(Player *p in _players)
        if(p.identifier == identifier)
            return p;
    NSLog(@"Returning NIL for player...");
    return nil;
}

- (void)gravatarIn {
    self.gravatarsGrabbed++;
    if(self.gravatarsGrabbed == [self count]) {
        
        // Clean up
        self.gravatarsGrabbed = 0;
        [[NSNotificationCenter defaultCenter] removeObserver:self];
        [[RKClient sharedClient] setBaseURL:[RKURL URLWithBaseURLString:@"http://mlpong.herokuapp.com"]];
        
        // Post a notification indicating player (& gravatar) load time is complete
        [[NSNotificationCenter defaultCenter] postNotificationName:@"PlayersLoaded" object:self];
    }
}

- (void)loadPlayers {
    
    // Authenticate & use mapping to load objects
    NSString *authedPath = [PlayerDC authpath:
                            [NSString stringWithFormat:
                             @"%@/players.json", [[SeasonDC sharedInstance] selectedSeason].path]];
    [[RKObjectManager sharedManager].mappingProvider setMapping:self.mapping forKeyPath:@""];
    [[RKObjectManager sharedManager] loadObjectsAtResourcePath:authedPath delegate:self];
}

- (int)indexOfPlayerWithIdentifier:(int)identifier {
    for(int i = 0; i < [_players count]; i++)
        if(((Player *)[_players objectAtIndex:i]).identifier == identifier)
            return i;
    return -1;
}

#pragma mark - RKObjectLoader Delegate Methods

- (void)objectLoader:(RKObjectLoader *)objectLoader didLoadObjects:(NSArray *)objects {
    
    // Populate the local array with the returned objects
    _players = [[NSMutableArray alloc] init];
    for(Player *p in objects)
        [self.players addObject:p];
    
    // Sort the players by point percentage
    _players = (NSMutableArray *)[_players sortedArrayUsingSelector:@selector(compare:)];
    
    // **Players ALL Loaded**
    
    // Now load player gravatars
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    for(Player *p in self.players)
        [nc addObserver:self selector:@selector(gravatarIn) name:@"GravatarLoaded" object:p];
    
    [[RKClient sharedClient] setBaseURL:[RKURL URLWithBaseURLString:@"http://gravatar.com"]];
    for(Player *p in self.players) [p getGravatar];
}

- (void)objectLoader:(RKObjectLoader *)objectLoader didFailWithError:(NSError *)error {
    
    // Yell for attention!
    NSLog(@"ERROR! (In Players object loader)");
    
}

@end
