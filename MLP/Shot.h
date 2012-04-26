//
//  Shot.h
//  MLP
//
//  Created by Nicholas Pachulski on 4/5/12.
//  Copyright (c) 2012 RPI. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Shot : NSObject
@property int leagueIdentifier;
@property int seasonIdentifier;
@property int teamIdentifier;
@property int playerIdentifier;
@property int shotNumberInRound;
@property int cup;
@end
