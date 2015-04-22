//
//  GameOver.m
//  Touchdown!
//
//  Created by Brendan Castro on 4/14/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "GameOver.h"

@implementation GameOver
-(void)back{
    CCLOG(@"back button pressed");
    CCNode * back = [CCBReader loadAsScene:@"MainScene"];
    [self addChild:back];
}

-(void)retry{
    CCLOG(@"retry button pressed");
    [[CCDirector sharedDirector] replaceScene: [CCBReader loadAsScene: @"Gameplay"]];
}

@end
