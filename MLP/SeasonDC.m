//
//  SeasonDC.m
//  MLP
//
//  Created by Nicholas Pachulski on 4/3/12.
//  Copyright (c) 2012 RPI. All rights reserved.
//

#import "Season.h"
#import "League.h"
#import "LeagueDC.h"

#import "SeasonDC.h"

@implementation SeasonDC

#pragma mark - Accessor Synthesizers

@synthesize seasons = _seasons;
@synthesize selected = _selected;
@synthesize mapping = _mapping;

#pragma mark - Class Methods

static SeasonDC *sharedInstance;
+ (SeasonDC *)sharedInstance {
    if(sharedInstance == nil)
        sharedInstance = [[SeasonDC alloc] init];
    return sharedInstance;
}

+ (NSString *)authpath:(NSString *)path {
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    return [NSString stringWithFormat:@"%@?auth_token=%@", path, [prefs valueForKey:@"token"]];
}

#pragma mark - Instance Methods

- (int)count {
    return [self.seasons count];
}

- (Season *)selectedSeason {
    return [self.seasons objectAtIndex:self.selected];
}

- (Season *)seasonAtIndex:(int)index {
    if(index >= 0 && index < [self count])
        return [self.seasons objectAtIndex:index];
    else return nil;
}

- (void)loadSeasons {
    
    // Set up the object mapping
    self.mapping = [RKObjectMapping mappingForClass:[Season class]];
    [self.mapping mapKeyPath:@"id" toAttribute:@"identifier"];
    [self.mapping mapKeyPath:@"name" toAttribute:@"name"];
    [self.mapping mapKeyPath:@"url" toAttribute:@"path"];
    
    // Authenticate & use mapping to load objects
    NSString *authedPath = [SeasonDC authpath:
                            [NSString stringWithFormat:
                             @"%@.json", [[LeagueDC sharedInstance] selectedLeague].path]];
    [[RKObjectManager sharedManager].mappingProvider setMapping:self.mapping forKeyPath:@"seasons"];
    [[RKObjectManager sharedManager] loadObjectsAtResourcePath:authedPath delegate:self];
}

#pragma mark - RKObjectLoader Delegate Methods

- (void)objectLoader:(RKObjectLoader *)objectLoader didLoadObjects:(NSArray *)objects {
    
    // Populate the local array with the returned objects
    _seasons = [[NSMutableArray alloc] init];
    for(Season *s in objects)
        [self.seasons addObject:s];
    
    // Remove the 0th (league) index as metadata
    [self.seasons removeObjectAtIndex:0];
    
    // Post a notification indicating Season load time is completed
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SeasonsLoaded" object:self];
}

- (void)objectLoader:(RKObjectLoader *)objectLoader didFailWithError:(NSError *)error {
    
    // Yell for attention!
    NSLog(@"ERROR! (In Seasons object loader)");
    
}

@end
