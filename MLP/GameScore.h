//
//  GameScore.h
//  MLP
//
//  Created by Nicholas Pachulski on 4/5/12.
//  Copyright (c) 2012 RPI. All rights reserved.
//

#import <RestKit/RestKit.h>
#import <Foundation/Foundation.h>

@interface GameScore : NSObject <NSCopying>
@property int homeTeamIdentifier;
@property int awayTeamIdentifier;
@property(copy, nonatomic)NSString *dateString;
@property(copy, nonatomic)NSString *timeString;
@property(copy, nonatomic)NSMutableArray *homeTeamPlayerIdentifiers;
@property(copy, nonatomic)NSMutableArray *awayTeamPlayerIdentifiers;
@property(copy, nonatomic)NSMutableArray *roundsAttributes;

@property(strong, nonatomic)RKObjectMapping *gameMapping;
@property(strong, nonatomic)RKObjectMapping *roundMapping;
@property(strong, nonatomic)RKObjectMapping *shotMapping;

@property(strong, nonatomic)RKObjectMapping *gameSerialization;
@property(strong, nonatomic)RKObjectMapping *roundSerialization;
@property(strong, nonatomic)RKObjectMapping *shotSerialization;

- (void)addRound;
@end
