//
//  Season.h
//  MLP
//
//  Created by Nicholas Pachulski on 4/3/12.
//  Copyright (c) 2012 RPI. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Season : NSObject
@property int identifier;
@property(strong, nonatomic)NSString *name;
@property(strong, nonatomic)NSString *path;
- (NSString *)description;
@end
