#import "MainScene.h"

@implementation MainScene
- (void)play{
    //CCLOG(@"start button pressed");
    CCNode * play = [CCBReader loadAsScene: @"Gameplay"];
    [self addChild:play];
}
- (void)settings{
    //CCLOG(@"settings button pressed");
    CCNode * settings = [CCBReader loadAsScene:@"Settings"];
    [self addChild:settings];
}

-(void) level{
    CCNode * level = [CCBReader loadAsScene: @"Level"];
    [self addChild:level];
}

-(void) about{
    CCNode * about = [CCBReader loadAsScene: @"About"];
    [self addChild:about];
}

-(void) character{
    CCNode * character = [CCBReader loadAsScene: @"Character"];
    [self addChild: character];
}
@end
