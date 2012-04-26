//
//  Game.m
//  MLP
//
//  Created by Nicholas Pachulski on 4/3/12.
//  Copyright (c) 2012 RPI. All rights reserved.
//

#import "Game.h"

@implementation Game
@synthesize identifier = _identifier;
@synthesize league_identifier = _league_identifier;
@synthesize season_identifier = _season_identifier;
@synthesize rounds_count = _rounds_count;
@synthesize winner_id = _winner_id;
@synthesize home_team = _home_team;
@synthesize away_team = _away_team;
@synthesize path = _path;
@synthesize date = _date;
@synthesize time = _time;

- (NSString *)description {
    return [NSString stringWithFormat:@"{Game: [id=%i, home_team=%@, away_team=%@]}", _identifier, _home_team, _away_team];
}

@end
