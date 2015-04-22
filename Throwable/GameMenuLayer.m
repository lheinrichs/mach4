//
//  GameMenuLayer.m
//  Touchdown!
//
//  Created by Brendan Castro on 4/15/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "GameMenuLayer.h"
#import "Play.h"

@implementation GameMenuLayer

-(void) didLoadFromCCB
{
    NSLog(@"YAY! didLoadFromCCB: %@", self);
}

-(void) shouldPauseGame
{
    NSLog(@"BUTTON: should pause game");
    [_gameScene showPopoverNamed:@"UserInterface/Popovers/PauseMenuLayer"];

}
-(void) shouldResumeGame
{
    CCAnimationManager* am = self.animationManager;
    if ([am.runningSequenceName isEqualToString:@"resume game"] == NO)
    {
        [am runAnimationsForSequenceNamed:@"resume game"];
    }
}
-(void) resumeGameDidEnd
{
    [_gameScene removePopover];
}
-(void) shouldExitGame
{
    [[CCDirector sharedDirector] replaceScene: [CCBReader loadAsScene: @"MainScene"]];
}
-(void) shouldRestartGame
{
    [[CCDirector sharedDirector] replaceScene: [CCBReader loadAsScene: @"Gameplay"]];
}

@end
