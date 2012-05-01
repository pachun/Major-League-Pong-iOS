//
//  GameDC.m
//  MLP
//
//  Created by Nicholas Pachulski on 4/3/12.
//  Copyright (c) 2012 RPI. All rights reserved.
//

#import "Game.h"
#import "Season.h"
#import "SeasonDC.h"

#import "TeamDC.h" /** Need Team Object Mapping **/

#import "GameDC.h"

@implementation GameDC

#pragma mark - Accessor Synthesizers

@synthesize games = _games;
@synthesize selected = _selected;
@synthesize mapping = _mapping;

#pragma mark - Class Methods

static GameDC *sharedInstance;
+ (GameDC *)sharedInstance {
    if(sharedInstance == nil)
        sharedInstance = [[GameDC alloc] init];
    return sharedInstance;
}

+ (NSString *)authpath:(NSString *)path {
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    return [NSString stringWithFormat:@"%@?auth_token=%@", path, [prefs valueForKey:@"token"]];
}

#pragma mark - Instance Methods

- (id)init {
    if(self = [super init]) {
        
        // Set up the object mapping
        self.mapping = [RKObjectMapping mappingForClass:[Game class]];
        [self.mapping mapKeyPath:@"id" toAttribute:@"identifier"];
        [self.mapping mapKeyPath:@"league_id" toAttribute:@"league_identifier"];
        [self.mapping mapKeyPath:@"season_id" toAttribute:@"season_identifier"];
        [self.mapping mapKeyPath:@"rounds_count" toAttribute:@"rounds_count"];
        [self.mapping mapKeyPath:@"winner_id" toAttribute:@"winner_id"];
        [self.mapping mapKeyPath:@"url" toAttribute:@"path"];
        [self.mapping mapKeyPath:@"date" toAttribute:@"date"];
        [self.mapping mapKeyPath:@"time" toAttribute:@"time"];
        [self.mapping mapKeyPath:@"home_team" toRelationship:@"home_team" withMapping:[TeamDC sharedInstance].mapping];
        [self.mapping mapKeyPath:@"away_team" toRelationship:@"away_team" withMapping:[TeamDC sharedInstance].mapping];
    }
    return self;
}

- (int)count {
    return [self.games count];
}

- (Game *)selectedGame {
    return [self.games objectAtIndex:self.selected];
}

- (Game *)gameAtIndex:(int)index {
    if(index >= 0 && index < [self count])
        return [self.games objectAtIndex:index];
    else return nil;
}

- (void)loadGames {
    
    // Authenticate & use mapping to load objects
    NSString *authedPath = [GameDC authpath:
                            [NSString stringWithFormat:
                             @"%@/games.json", [[SeasonDC sharedInstance] selectedSeason].path]];
    [[RKObjectManager sharedManager].mappingProvider setMapping:self.mapping forKeyPath:@""];
    [[RKObjectManager sharedManager] loadObjectsAtResourcePath:authedPath delegate:self];
}

#pragma mark - RKObjectLoader Delegate Methods

- (void)objectLoader:(RKObjectLoader *)objectLoader didLoadObjects:(NSArray *)objects {
    //RKLogInfo(@"Object loader succeeded with objects: %@", objects);
    
    // Populate the local array with the returned objects
    _games = [[NSMutableArray alloc] init];
    for(Game *g in objects) {
        [_games addObject:g];
    }
    
    // Sort the games according to their date / times
    _games = (NSMutableArray *)[_games sortedArrayUsingSelector:@selector(compare:)];
    NSLog(@"Games just sorted.");
    for(Game *g in _games)
        NSLog(@"%@ %@", g.date, g.time);
    
    // Post a notification indicating Game load time is completed
    [[NSNotificationCenter defaultCenter] postNotificationName:@"GamesLoaded" object:self];
}

- (void)objectLoader:(RKObjectLoader *)objectLoader didFailWithError:(NSError *)error {
    
    // Yell for attention!
    NSLog(@"ERROR! (In Games object loader)");
    
}

@end
