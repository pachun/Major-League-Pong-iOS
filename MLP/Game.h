//
//  Game.h
//  MLP
//
//  Created by Nicholas Pachulski on 4/3/12.
//  Copyright (c) 2012 RPI. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Team;
@interface Game : NSObject
@property int identifier;
@property int league_identifier;
@property int season_identifier;
@property int rounds_count;
@property(strong, nonatomic)NSString *path;
@property(strong, nonatomic)NSString *date;
@property(strong, nonatomic)NSString *time;
@property(strong, nonatomic)Team *home_team;
@property(strong, nonatomic)Team *away_team;
@property(copy, nonatomic)NSNumber *winner_id;
- (NSString *)description;
@end
