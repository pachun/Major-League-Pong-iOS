//
//  PlayerDC.h
//  MLP
//
//  Created by Nicholas Pachulski on 4/3/12.
//  Copyright (c) 2012 RPI. All rights reserved.
//

#import <Restkit/Restkit.h>
#import <Foundation/Foundation.h>

@class Player;
@interface PlayerDC : NSObject <RKObjectLoaderDelegate>

// Properties
@property int selected;
@property int gravatarsGrabbed;
@property(copy, nonatomic)NSMutableArray *players;
@property(strong, nonatomic)RKObjectMapping *mapping;

// Class Methods
+ (PlayerDC *)sharedInstance;
+ (NSString *)authpath:(NSString *)path;

// Instance Methods
- (int)count;
- (void)loadPlayers;
- (Player *)selectedPlayer;
- (Player *)playerAtIndex:(int)index;
- (Player *)playerWithIdentifier:(int)identifier;
- (int)indexOfPlayerWithIdentifier:(int)identifier;

@end
