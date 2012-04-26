//
//  Season.m
//  MLP
//
//  Created by Nicholas Pachulski on 4/3/12.
//  Copyright (c) 2012 RPI. All rights reserved.
//

#import "Season.h"

@implementation Season

@synthesize identifier = _identifier;
@synthesize name = _name;
@synthesize path = _path;

- (NSString *)description {
    return [NSString stringWithFormat:@"{Season: [id=%i, name=%@, path=%@ ]}", _identifier, _name, _path];
}

@end
