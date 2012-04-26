//
//  TeamDC.h
//  MLP
//
//  Created by Nicholas Pachulski on 4/3/12.
//  Copyright (c) 2012 RPI. All rights reserved.
//

#import <Restkit/Restkit.h>
#import <Foundation/Foundation.h>

@class Team;
@interface TeamDC : NSObject <RKObjectLoaderDelegate>

// Properties
@property int selected;
@property(copy, nonatomic)NSMutableArray *teams;
@property(strong, nonatomic)RKObjectMapping *mapping;
@property(strong, nonatomic)RKObjectMapping *teamPlayerMapping;

// Class Methods
+ (TeamDC *)sharedInstance;
+ (NSString *)authpath:(NSString *)path;

// Instance Methods
- (int)count;
- (void)loadTeams;
- (Team *)selectedTeam;
- (Team *)teamAtIndex:(int)index;
- (Team *)teamWithIdentifier:(int)identifier;

@end
