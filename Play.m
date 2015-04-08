//
//  Play.m
//  Touchdown!
//
//  Created by Mach 4on 3/25/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Play.h"

@implementation play
-(void)back{
    CCLOG(@"back button pressed");
    CCNode * back = [CCBReader loadAsScene:@"MainScene"];
    [self addChild:back];
}
@end