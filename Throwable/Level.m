//
//  Level.m
//  Touchdown!
//
//  Created by Mach 4 on 3/24/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Level.h"

@implementation level
-(void)back{
    CCLOG(@"back button pressed");
    CCNode * back = [CCBReader loadAsScene:@"MainScene"];
    [self addChild:back];
}
@end
