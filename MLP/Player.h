//
//  Player.h
//  MLP
//
//  Created by Nicholas Pachulski on 4/3/12.
//  Copyright (c) 2012 RPI. All rights reserved.
//

#import "RestKit/RestKit.h"
#import <Foundation/Foundation.h>

@interface Player : NSObject <RKRequestDelegate>
@property int identifier;
@property(strong, nonatomic)NSString *name;
@property(strong, nonatomic)NSString *story;
@property(strong, nonatomic)NSString *emailHash;
@property(strong, nonatomic)NSData *gravatar;
@property double pointPercentage;
@property double hitPercentage;
@property int lastCups;
@property int shotCount;
@property int hitCount;
@property int wins;
@property int losses;

- (void)getGravatar;
- (NSString *)description;
- (NSComparisonResult)compare:(Player *)p;
@end
