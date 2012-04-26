//
//  LeagueDC.h
//  MLP
//
//  Created by Nicholas Pachulski on 4/3/12.
//  Copyright (c) 2012 RPI. All rights reserved.
//

#import <Restkit/Restkit.h>
#import <Foundation/Foundation.h>

@class League;
@interface LeagueDC : NSObject <RKObjectLoaderDelegate>

// Properties
@property int selected;
@property(copy, nonatomic)NSMutableArray *leagues;
@property(strong, nonatomic)RKObjectMapping *mapping;

// Class Methods
+ (LeagueDC *)sharedInstance;
+ (NSString *)authpath:(NSString *)path;

// Instance Methods
- (int)count;
- (void)loadLeagues;
- (League *)selectedLeague;
- (League *)leagueAtIndex:(int)index;

@end
