//
//  SeasonDC.h
//  MLP
//
//  Created by Nicholas Pachulski on 4/3/12.
//  Copyright (c) 2012 RPI. All rights reserved.
//

#import <Restkit/Restkit.h>
#import <Foundation/Foundation.h>

@class Season;
@interface SeasonDC : NSObject <RKObjectLoaderDelegate>

// Properties
@property int selected;
@property(copy, nonatomic)NSMutableArray *seasons;
@property(strong, nonatomic)RKObjectMapping *mapping;

// Class Methods
+ (SeasonDC *)sharedInstance;
+ (NSString *)authpath:(NSString *)path;

// Instance Methods
- (int)count;
- (void)loadSeasons;
- (Season *)selectedSeason;
- (Season *)seasonAtIndex:(int)index;

@end
