//
//  TeamPlayer.m
//  MLP
//
//  Created by Nicholas Pachulski on 4/3/12.
//  Copyright (c) 2012 RPI. All rights reserved.
//

#import "TeamPlayer.h"

@implementation TeamPlayer
@synthesize identifier = _identifier;
@synthesize name = _name;

- (NSString *)description {
    return [NSString stringWithFormat:@"{player: [id=%i, name=%@]}",_identifier,_name];
}
@end
