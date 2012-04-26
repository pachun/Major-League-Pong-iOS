//
//  GameDC.h
//  MLP
//
//  Created by Nicholas Pachulski on 4/3/12.
//  Copyright (c) 2012 RPI. All rights reserved.
//

#import <Restkit/Restkit.h>
#import <Foundation/Foundation.h>

@class Game;
@interface GameDC : NSObject <RKObjectLoaderDelegate>

// Properties
@property int selected;
@property(copy, nonatomic)NSMutableArray *games;
@property(strong, nonatomic)RKObjectMapping *mapping;

// Class Methods
+ (GameDC *)sharedInstance;
+ (NSString *)authpath:(NSString *)path;

// Instance Methods
- (int)count;
- (void)sort;
- (void)loadGames;
- (Game *)selectedGame;
- (Game *)gameAtIndex:(int)index;

@end
