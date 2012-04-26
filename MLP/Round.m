//
//  Round.m
//  MLP
//
//  Created by Nicholas Pachulski on 4/5/12.
//  Copyright (c) 2012 RPI. All rights reserved.
//

#import "Round.h"

@implementation Round
@synthesize index = _index;
@synthesize shots = _shots;

- (id)init {
    if(self = [super init])
        _shots = [NSMutableArray new];
    return self;
}

@end
