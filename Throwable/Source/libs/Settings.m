//
//  settings.m
//  menu
//
//  Created by Mach 4 on 3/18/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "settings.h"

@implementation settings
-(void)back{
        CCLOG(@"back button pressed");
        CCNode * back = [CCBReader loadAsScene:@"MainScene"];
        [self addChild:back];
}
@end
