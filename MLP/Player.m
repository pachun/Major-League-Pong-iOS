//
//  Player.m
//  MLP
//
//  Created by Nicholas Pachulski on 4/3/12.
//  Copyright (c) 2012 RPI. All rights reserved.
//

#import "Player.h"

@implementation Player

# pragma mark - Accessor Synthesizers

@synthesize identifier = _identifier;
@synthesize name = _name;
@synthesize story = _story;
@synthesize emailHash = _emailHash;
@synthesize pointPercentage = _pointPercentage;
@synthesize hitPercentage = _hitPercentage;
@synthesize lastCups = _lastCups;
@synthesize shotCount = _shotCount;
@synthesize hitCount = _hitCount;
@synthesize wins = _wins;
@synthesize losses = _losses;
@synthesize gravatar = _gravatar;

# pragma mark - Instance Methods

- (void)getGravatar {
    NSString *path = [self gravatarLink];
    [[RKClient sharedClient] get:path delegate:self];
}

- (NSString *)description {
    return [NSString stringWithFormat:@"{Player: [id=%i, name=%@]}", _identifier, _name, _story];
}

- (NSComparisonResult)compare:(Player *)p {
    return [[NSNumber numberWithDouble:p.pointPercentage]
            compare:[NSNumber numberWithDouble:self.pointPercentage]];
}

# pragma mark - RKRequest Delegate Methods

- (void)request:(RKRequest *)request didLoadResponse:(RKResponse *)response {
    self.gravatar = response.body;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"GravatarLoaded" object:self];
}

# pragma mark - Private Methods

- (NSString *)gravatarLink {
    NSString  *path;
    path = [NSString stringWithFormat:@"/avatar/%@?d=monsterid&r=x", _emailHash];
    if([[UIScreen mainScreen] respondsToSelector:@selector(scale)] && [[UIScreen mainScreen] scale]==2)
        return [path stringByAppendingString:@"&s=200"];
    else
        return [path stringByAppendingString:@"&s=100"];
}

@end
