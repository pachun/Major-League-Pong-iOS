//
//  GameScore.m
//  MLP
//
//  Created by Nicholas Pachulski on 4/5/12.
//  Copyright (c) 2012 RPI. All rights reserved.
//

#import "Shot.h"
#import "Round.h"

#import "GameScore.h"

@implementation GameScore

# pragma mark - Accessor Synthesizers

@synthesize timeString = _timeString;
@synthesize dateString = _dateString;
@synthesize homeTeamIdentifier = _homeTeamIdentifier;
@synthesize awayTeamIdentifier = _awayTeamIdentifier;
@synthesize homeTeamPlayerIdentifiers = _homeTeamPlayerIdentifiers;
@synthesize awayTeamPlayerIdentifiers = _awayTeamPlayerIdentifiers;
@synthesize roundsAttributes = _roundsAttributes;

@synthesize gameMapping = _gameMapping;
@synthesize roundMapping = _roundMapping;
@synthesize shotMapping = _shotMapping;

@synthesize gameSerialization = _gameSerialization;
@synthesize roundSerialization = _roundSerialization;
@synthesize shotSerialization = _shotSerialization;


# pragma mark - Accessor Overrides

- (void)setHomeTeamPlayerIdentifiers:(NSMutableArray *)homeTeamPlayerIdentifiers {
    if(_homeTeamPlayerIdentifiers != homeTeamPlayerIdentifiers)
        _homeTeamPlayerIdentifiers = [homeTeamPlayerIdentifiers mutableCopy];
}

- (void)setAwayTeamPlayerIdentifiers:(NSMutableArray *)awayTeamPlayerIdentifiers {
    if(_awayTeamPlayerIdentifiers != awayTeamPlayerIdentifiers)
        _awayTeamPlayerIdentifiers = [awayTeamPlayerIdentifiers mutableCopy];
}

- (void)setRoundsAttributes:(NSMutableArray *)roundsAttributes {
    if(_roundsAttributes != roundsAttributes)
        _roundsAttributes = [roundsAttributes mutableCopy];
}

#pragma mark - Instance Methods

- (void)addRound {
    Round *nextRound = [Round new];
    nextRound.index = [_roundsAttributes count];
    [_roundsAttributes addObject:nextRound];
}

// If 3 most recent shot cups are not "0", then return true
- (BOOL)bringBacks {
    
    // if there are 0 rounds return false
    if([_roundsAttributes count]==0) return false;
    
    // If there is only 1 round, with less than 3 shots, return false
    if([_roundsAttributes count]==1 && [((Round *)[_roundsAttributes objectAtIndex:0]).shots count] < 3)
        return false;
    
    Round *round = (Round *)[_roundsAttributes lastObject];
    
    // If the current round's shot count is not divisible by 3, return false
    if([round.shots count] % 3 != 0)
        return false;
    
    // Check if the last 3 shots were all not misses - if any of them were: fail
    if([round.shots count]==6) {
        
        if( ((Shot *)[round.shots objectAtIndex:3]).cup==0 || 
            ((Shot *)[round.shots objectAtIndex:4]).cup==0 ||
            ((Shot *)[round.shots objectAtIndex:5]).cup==0)
            return false;
        
    } else {
        
        if( ((Shot *)[round.shots objectAtIndex:0]).cup==0 || 
            ((Shot *)[round.shots objectAtIndex:1]).cup==0 ||
            ((Shot *)[round.shots objectAtIndex:2]).cup==0)
            return false;
        
    }
    
    
    // Still around? Last 3 shots were cup hits!
    return true;
}

- (id)init {
    if(self = [super init]) {
        
        // Initialize the shot mapping
        _shotMapping = [RKObjectMapping mappingForClass:[Shot class]];
        [_shotMapping mapKeyPath:@"league_id" toAttribute:@"leagueIdentifier"];
        [_shotMapping mapKeyPath:@"season_id" toAttribute:@"seasonIdentifier"];
        [_shotMapping mapKeyPath:@"team_id" toAttribute:@"teamIdentifier"];
        [_shotMapping mapKeyPath:@"player_id" toAttribute:@"playerIdentifier"];
        [_shotMapping mapKeyPath:@"number" toAttribute:@"shotNumberInRound"];
        [_shotMapping mapKeyPath:@"cup" toAttribute:@"cup"];
        
        // Create shot serialization
        _shotSerialization = [_shotMapping inverseMapping];
        [[RKObjectManager sharedManager].mappingProvider setSerializationMapping:_shotSerialization forClass:[Shot class]];
        
        // Initialize the round mapping
        _roundMapping = [RKObjectMapping mappingForClass:[Round class]];
        [_roundMapping mapKeyPath:@"number" toAttribute:@"index"];
        [_roundMapping mapKeyPath:@"shots_attributes" toRelationship:@"shots" withMapping:_shotMapping];
        
        // Create round serialization
        _roundSerialization = [_roundMapping inverseMapping];
        [[RKObjectManager sharedManager].mappingProvider setSerializationMapping:_roundSerialization forClass:[Round class]];
        
        // Initialize game scoring mapping
        _gameMapping = [RKObjectMapping mappingForClass:[GameScore class]];
        [_gameMapping mapKeyPath:@"time_string" toAttribute:@"timeString"];
        [_gameMapping mapKeyPath:@"date_string" toAttribute:@"dateString"];
        [_gameMapping mapKeyPath:@"home_team_id" toAttribute:@"homeTeamIdentifier"];
        [_gameMapping mapKeyPath:@"away_team_id" toAttribute:@"awayTeamIdentifier"];
        [_gameMapping mapKeyPath:@"home_team_player_ids" toAttribute:@"homeTeamPlayerIdentifiers"];
        [_gameMapping mapKeyPath:@"away_team_player_ids" toAttribute:@"awayTeamPlayerIdentifiers"];
        [_gameMapping mapKeyPath:@"rounds_attributes" toRelationship:@"roundsAttributes" withMapping:_roundMapping];
        
        // Create game serialization
        _gameSerialization = [_gameMapping inverseMapping];
        [[RKObjectManager sharedManager].mappingProvider setSerializationMapping:_gameSerialization forClass:[GameScore class]];
        
        // Initialize member arrays
        _roundsAttributes = [NSMutableArray new];
        _homeTeamPlayerIdentifiers = [NSMutableArray new];
        _awayTeamPlayerIdentifiers = [NSMutableArray new];
    }
    return self;
}

# pragma mark - NSCopying Protocol Methods

- (id)copyWithZone:(NSZone *)zone {
    GameScore *copied = [[[self class] allocWithZone:zone] init];
    copied.homeTeamIdentifier = _homeTeamIdentifier;
    copied.awayTeamIdentifier = _awayTeamIdentifier;
    copied.dateString = _dateString;
    copied.timeString = _timeString;
    copied.homeTeamPlayerIdentifiers = _homeTeamPlayerIdentifiers;
    copied.awayTeamPlayerIdentifiers = _awayTeamPlayerIdentifiers;
    copied.roundsAttributes = _roundsAttributes;
    copied.gameMapping = _gameMapping;
    copied.roundMapping = _roundMapping;
    copied.shotMapping = _shotMapping;
    return copied;
}

@end
