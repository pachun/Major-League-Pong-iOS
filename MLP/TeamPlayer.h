//
//  TeamPlayer.h
//  MLP
//
//  Created by Nicholas Pachulski on 4/3/12.
//  Copyright (c) 2012 RPI. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TeamPlayer : NSObject
@property int identifier;
@property(strong, nonatomic)NSString *name;
- (NSString *)description;
@end
