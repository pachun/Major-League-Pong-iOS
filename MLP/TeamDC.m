//
//  TeamDC.m
//  MLP
//
//  Created by Nicholas Pachulski on 4/3/12.
//  Copyright (c) 2012 RPI. All rights reserved.
//

#import "Season.h"
#import "SeasonDC.h"

#import "Team.h"
#import "TeamPlayer.h"

#import "TeamDC.h"

@implementation TeamDC

#pragma mark - Accessor Synthesizers

@synthesize teams = _teams;
@synthesize selected = _selected;
@synthesize mapping = _mapping;
@synthesize teamPlayerMapping = _teamPlayerMapping;

#pragma mark - Class Methods

static TeamDC *sharedInstance;
+ (TeamDC *)sharedInstance {
    if(sharedInstance == nil)
        sharedInstance = [[TeamDC alloc] init];
    return sharedInstance;
}

+ (NSString *)authpath:(NSString *)path {
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    return [NSString stringWithFormat:@"%@?auth_token=%@", path, [prefs valueForKey:@"token"]];
}

#pragma mark - Instance Methods

- (id)init {
    if(self = [super init]) {
        
        // Set up the nested "TeamPlayer" mapping
        self.teamPlayerMapping = [RKObjectMapping mappingForClass:[TeamPlayer class]];
        [self.teamPlayerMapping mapKeyPath:@"id" toAttribute:@"identifier"];
        [self.teamPlayerMapping mapKeyPath:@"name" toAttribute:@"name"];
        
        // Set up the object mapping
        self.mapping = [RKObjectMapping mappingForClass:[Team class]];
        [self.mapping mapKeyPath:@"id" toAttribute:@"identifier"];
        [self.mapping mapKeyPath:@"name" toAttribute:@"name"];
        [self.mapping mapKeyPath:@"url" toAttribute:@"path"];
        [self.mapping mapKeyPath:@"point_percentage" toAttribute:@"pointPercentage"];
        [self.mapping mapKeyPath:@"hit_percentage" toAttribute:@"hitPercentage"];
        [self.mapping mapKeyPath:@"shot_count" toAttribute:@"shotCount"];
        [self.mapping mapKeyPath:@"hit_count" toAttribute:@"hitCount"];
        [self.mapping mapKeyPath:@"wins" toAttribute:@"wins"];
        [self.mapping mapKeyPath:@"losses" toAttribute:@"losses"];
        [self.mapping mapKeyPath:@"players" toRelationship:@"players" withMapping:self.teamPlayerMapping];
        
    }
    return self;
}

- (int)count {
    return [self.teams count];
}

- (Team *)selectedTeam {
    return [self.teams objectAtIndex:self.selected];
}

- (Team *)teamAtIndex:(int)index {
    if(index >= 0 && index < [self count])
        return [self.teams objectAtIndex:index];
    else return nil;
}

- (Team *)teamWithIdentifier:(int)identifier {
    for(Team *t in _teams)
        if(t.identifier == identifier)
            return t;
    return nil;
}

- (void)loadTeams {
    
    // Authenticate & use mapping to load objects
    NSString *authedPath = [TeamDC authpath:
                            [NSString stringWithFormat:
                             @"%@/teams.json", [[SeasonDC sharedInstance] selectedSeason].path]];
    [[RKObjectManager sharedManager].mappingProvider setMapping:self.mapping forKeyPath:@""];
    [[RKObjectManager sharedManager] loadObjectsAtResourcePath:authedPath delegate:self];
}

#pragma mark - RKObjectLoader Delegate Methods

- (void)objectLoader:(RKObjectLoader *)objectLoader didLoadObjects:(NSArray *)objects {
    //RKLogInfo(@"Object loader succeeded with objects: %@", objects);
    
    // Populate the local array with the returned objects
    _teams = [[NSMutableArray alloc] init];
    for(Team *t in objects)
        [self.teams addObject:t];
    
    // Sort the teams by wins, then point percentage
    _teams = (NSMutableArray *)[_teams sortedArrayUsingSelector:@selector(compare:)];
    
    // Post a notification indicating Team load time is completed
    [[NSNotificationCenter defaultCenter] postNotificationName:@"TeamsLoaded" object:self];
}

- (void)objectLoader:(RKObjectLoader *)objectLoader didFailWithError:(NSError *)error {
    
    // Yell for attention!
    NSLog(@"ERROR! (In Teams object loader)");
    
}

@end
