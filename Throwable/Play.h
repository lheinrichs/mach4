//
//  Play.h
//  Touchdown!
//
//  Created by Mach 4 on 3/25/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "CCNode.h"


@interface play : CCNode <CCPhysicsCollisionDelegate>


-(void) showPopoverNamed:(NSString*)popoverName;
-(void) removePopover;
//-(void)didLoadFromCCB;
//-(void)touchBegan:(CCTouch *)touch withEvent:(CCTouchEvent *)event;
//-(void)launchBall;
//-(void)back;

@end