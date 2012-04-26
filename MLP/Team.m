//
//  Team.m
//  MLP
//
//  Created by Nicholas Pachulski on 4/3/12.
//  Copyright (c) 2012 RPI. All rights reserved.
//

#import "Team.h"

@implementation Team
@synthesize identifier = _identifier;
@synthesize name = _name;
@synthesize path = _path;
@synthesize players = _players;
@synthesize pointPercentage = _pointPercentage;
@synthesize hitPercentage = _hitPercentage;
@synthesize shotCount = _shotCount;
@synthesize hitCount = _hitCount;
@synthesize wins = _wins;
@synthesize losses = _losses;

- (NSString *)description {
    return [NSString stringWithFormat:@"{Team: [id=%i, name=%@, path=%@, players: [%@, %@, %@]]}", _identifier, _name, _path, [_players objectAtIndex:0], [_players objectAtIndex:1], [_players objectAtIndex:2]];
}

- (void)setPlayers:(NSMutableArray *)old {
    if(self.players != old)
        _players = [old mutableCopy];
}

- (NSComparisonResult)compare:(Team *)t {
    if( (int)[NSNumber numberWithDouble:t.wins] - (int)[NSNumber numberWithDouble:self.wins] != 0)
        return [[NSNumber numberWithInt:t.wins]
                compare:[NSNumber numberWithInt:self.wins]];
    else
        return [[NSNumber numberWithDouble:t.pointPercentage]
                compare:[NSNumber numberWithDouble:self.pointPercentage]];
}

- (id)copyWithZone:(NSZone *)zone {
    Team *copied = [[[self class] allocWithZone:zone] init];
    [copied setIdentifier:_identifier];
    [copied setName:_name];
    [copied setPath:_path];
    [copied setPlayers:_players];
    [copied setPointPercentage:_pointPercentage];
    [copied setHitPercentage:_hitPercentage];
    [copied setShotCount:_shotCount];
    [copied setHitCount:_hitCount];
    [copied setWins:_wins];
    [copied setLosses:_losses];
    return copied;
}

@end
