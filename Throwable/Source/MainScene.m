#import "MainScene.h"

@implementation MainScene
- (void)play{
    //CCLOG(@"start button pressed");
   // CCNode * play = [CCBReader loadAsScene: @"Gameplay"];
    //[self addChild:play];
    [[CCDirector sharedDirector] replaceScene: [CCBReader loadAsScene: @"Gameplay"]];
}
- (void)settings{
    //CCLOG(@"settings button pressed");
    //CCNode * settings = [CCBReader loadAsScene:@"Settings"];
    //[self addChild:settings];
    [[CCDirector sharedDirector] replaceScene: [CCBReader loadAsScene: @"Settings"]];
}

-(void) level{
    //CCNode * level = [CCBReader loadAsScene: @"Level"];
    //[self addChild:level];
    [[CCDirector sharedDirector] replaceScene: [CCBReader loadAsScene: @"Level"]];
}

-(void) about{
//    CCNode * about = [CCBReader loadAsScene: @"About"];
  //  [self addChild:about];
    [[CCDirector sharedDirector] replaceScene: [CCBReader loadAsScene: @"About"]];
}

-(void) character{
//    CCNode * character = [CCBReader loadAsScene: @"Character"];
  //  [self addChild: character];
    [[CCDirector sharedDirector] replaceScene: [CCBReader loadAsScene: @"Character"]];
}
@end
