//
//  LeagueDC.m
//  MLP
//
//  Created by Nicholas Pachulski on 4/3/12.
//  Copyright (c) 2012 RPI. All rights reserved.
//

#import "League.h"

#import "LeagueDC.h"

@implementation LeagueDC

#pragma mark - Accessor Synthesizers

@synthesize leagues = _leagues;
@synthesize selected = _selected;
@synthesize mapping = _mapping;

#pragma mark - Class Methods

static LeagueDC *sharedInstance;
+ (LeagueDC *)sharedInstance {
    if(sharedInstance == nil)
        sharedInstance = [[LeagueDC alloc] init];
    return sharedInstance;
}

+ (NSString *)authpath:(NSString *)path {
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    return [NSString stringWithFormat:@"%@?auth_token=%@", path, [prefs valueForKey:@"token"]];
}

#pragma mark - Instance Methods

- (int)count {
    return [self.leagues count];
}

- (League *)selectedLeague {
    return [self.leagues objectAtIndex:self.selected];
}

- (League *)leagueAtIndex:(int)index {
    if(index >= 0 && index < [self count])
        return [self.leagues objectAtIndex:index];
    else return nil;
}

- (void)loadLeagues {
    
    // Set up the object mapping
    self.mapping = [RKObjectMapping mappingForClass:[League class]];
    [self.mapping mapKeyPath:@"id" toAttribute:@"identifier"];
    [self.mapping mapKeyPath:@"name" toAttribute:@"name"];
    [self.mapping mapKeyPath:@"url" toAttribute:@"path"];
    
    // Authenticate & use mapping to load objects
    NSString *authedPath = [LeagueDC authpath:@"/leagues.json"];
    [[RKObjectManager sharedManager].mappingProvider setMapping:self.mapping forKeyPath:@""];
    [[RKObjectManager sharedManager] loadObjectsAtResourcePath:authedPath delegate:self];
}

#pragma mark - RKObjectLoader Delegate Methods

- (void)objectLoader:(RKObjectLoader *)objectLoader didLoadObjects:(NSArray *)objects {
    
    // Populate the local array with the returned objects
    _leagues = [[NSMutableArray alloc] init];
    for(League *l in objects)
        [self.leagues addObject:l];
    
    // Post a notification indicating league load time is completed
    [[NSNotificationCenter defaultCenter] postNotificationName:@"LeaguesLoaded" object:self];
}

- (void)objectLoader:(RKObjectLoader *)objectLoader didFailWithError:(NSError *)error {
    
    // Yell for attention!
    NSLog(@"ERROR! (In leagues object loader)");
    
}

@end
