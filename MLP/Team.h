//
//  Team.h
//  MLP
//
//  Created by Nicholas Pachulski on 4/3/12.
//  Copyright (c) 2012 RPI. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Team : NSObject <NSCopying>
@property int identifier;
@property(strong, nonatomic)NSString *name;
@property(strong, nonatomic)NSString *path;
@property(copy, nonatomic)NSMutableArray *players;
@property double pointPercentage;
@property double hitPercentage;
@property int shotCount;
@property int hitCount;
@property int wins;
@property int losses;
- (NSString*)description;
@end
