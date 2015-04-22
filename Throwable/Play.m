//
//  Play.m
//  Touchdown!
//
//  Created by Mach 4on 3/25/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Play.h"
#import "Ball.h"
#import "CCPhysics+ObjectiveChipmunk.h"
#import "GameMenuLayer.h"

@class play;
@implementation play {
    
    CCDrawNode *_ShotAngle;
    CCPhysicsNode *_physicsNode;
    CCPhysicsNode *_pullbackNode;
    CCNode *_mouseJointNode;
    CCNode *_mouseJointNode2;
    CCNode *_mouseJointNode3;
    CCPhysicsJoint *_mouseJoint;
    CCNode *_arm;
    CCNode *_contentNode;
    CCNode *_levelNode;
    CCNode *_currentBall;
    CCNode *_GameOver;
    CCPhysicsJoint *_ballCatapultJoint;
    int attempts;
    __weak GameMenuLayer* _gameMenuLayer;
    __weak GameMenuLayer* _popoverMenuLayer;
    BOOL firstClick;
}

static const float MIN_SPEED = 5.f;
static const float ENERGY_SPEED = 5000.f;

#pragma mark - Init

-(void)didLoadFromCCB{
    _gameMenuLayer.gameScene = self;
    self.userInteractionEnabled = YES; //tells the screen to accept touches
    _pullbackNode.physicsBody.collisionMask = @[]; //nothing will collide with our invisible nodes
    _mouseJointNode.physicsBody.collisionMask = @[]; //deactivates collisions for the invisible node
   _physicsNode.collisionDelegate = self;
   // _physicsNode.debugDraw = TRUE;
    CCNode *level1 = [CCBReader load: @"Levels/Level1"];
    [_levelNode addChild: level1];
    self.physicsBody.collisionType = @"Can";
    attempts = 0;
    [self schedule:@selector(everySecond:) interval:1.0];
}

-(void) everySecond:(CCTime)delta{
    if(CGRectContainsPoint(_levelNode.boundingBox, _currentBall.position) || _currentBall == nil){
        //do nothing
        NSLog(@"Current velocity:   %f", _currentBall.physicsBody.velocity.x );
        if(_currentBall.physicsBody.velocity.x < 5.0 ||_currentBall.physicsBody.velocity.x == -0.0){
           // if(_currentBall != nil){
               // [_physicsNode removeChild:_currentBall cleanup:YES];
               // NSLog(@"Post removal");
           // }
            CCActionFollow *reset = [CCActionFollow actionWithTarget:_arm worldBoundary:_levelNode.boundingBox];
            [_contentNode runAction:reset];
            //[self loadBall];
            self.userInteractionEnabled = YES;
        }
    }
    
    else{
        //if(_currentBall != nil){
            //[_physicsNode removeChild:_currentBall cleanup:YES];
            //NSLog(@"Post removal");
        //}
        CCActionFollow *reset = [CCActionFollow actionWithTarget:_arm worldBoundary:_levelNode.boundingBox];
        [_contentNode runAction:reset];
        //[self loadBall];
        self.userInteractionEnabled = YES;
    }
}

-(void) loadBall {
    _currentBall = [CCBReader load:@"Ball"];//Load Ball
    CGPoint ballPosition = [_arm convertToWorldSpace:ccp(50, 50)];// Where the ball spawns on the arm
    
    // transform the world position to the node space to which the ball will be added
    _currentBall.position = [_physicsNode convertToNodeSpace:ballPosition];
    [_physicsNode addChild:_currentBall];//add physics
    _currentBall.physicsBody.allowsRotation = FALSE;//No rotation
    // create a joint to keep the ball fixed until the arm is released
    _ballCatapultJoint = [CCPhysicsJoint connectedPivotJointWithBodyA:_currentBall.physicsBody bodyB:_arm.physicsBody anchorA:_currentBall.anchorPointInPoints];
}

-(void) touchBegan:(CCTouch *)touch withEvent:(CCTouchEvent *)event
    {
        
        CGPoint touchLocation = [touch locationInNode:_contentNode];
        
        // start catapult dragging when a touch inside of the catapult arm occurs
        if (CGRectContainsPoint([_levelNode boundingBox], touchLocation))
        {
            _mouseJointNode.position = touchLocation;// move the mouseJointNode to the touch position
            [self loadBall];
            firstClick = YES;
            
        }
     
        
    }

-(void)launchBall {
    int mouseInitialx = _mouseJointNode.position.x;
    int mouseInitialy = _mouseJointNode.position.y;
    int mouseMovedx = _mouseJointNode2.position.x;
    int mouseMovedy = _mouseJointNode2.position.y;
    int mouseSlopex = (mouseInitialx - mouseMovedx)/10;
    int mouseSlopey = (mouseInitialy - mouseMovedy)/10;
    int mouseDiff = (mouseInitialx - mouseMovedx)*2;
    if (mouseDiff < 200){
        mouseDiff = 200;
    }
    if (mouseDiff > 700){
        mouseDiff = 700;
    }
    NSLog(@"\nValue of mouseInitialx = %i\n", mouseInitialx);
    NSLog(@"\nValue of mouseInitialy = %i\n", mouseInitialy);
    NSLog(@"\nValue of mouseMovedx = %i\n", mouseMovedx);
    NSLog(@"\nValue of mouseMovedy = %i\n", mouseMovedy);
    NSLog(@"\nValue of mouseSlopex = %i\n", mouseSlopex);
    NSLog(@"\nValue of mouseSlopey = %i\n", mouseSlopey);
    NSLog(@"\nValue of mouseDiff = %i\n", mouseDiff);
    CGPoint launchDirection = ccp((mouseSlopex) , (mouseSlopey));
    NSLog(@"\nValue of launchDirection = %f,%f\n", launchDirection.x,launchDirection.y);
    CGPoint force = ccpMult(launchDirection, mouseDiff);
    [_ballCatapultJoint invalidate];
    _ballCatapultJoint = nil;
    [_currentBall.physicsBody applyForce:force];
    CCActionFollow *follow = [CCActionFollow actionWithTarget:_currentBall worldBoundary:_levelNode.boundingBox];
    [_contentNode runAction:follow];
    mouseInitialx = 0;
    mouseInitialy = 0;
    mouseMovedx = 0;
    mouseMovedy = 0;
    mouseSlopex = 0;
    mouseSlopey = 0;
    mouseDiff = 0;
    attempts += 1;
    if (attempts == 5){
        [self showPopoverNamed:@"UserInterface/Popovers/gameover"];
        attempts = 0;
    }
    self.userInteractionEnabled = NO;
}


- (void)touchMoved:(CCTouch *)touch withEvent:(CCTouchEvent *)event
{
    // whenever touches move, update the position of the mouseJointNode to the touch position
    CGPoint touchLocation = [touch locationInNode:_contentNode];
    _mouseJointNode2.position = touchLocation; //update the second touch value
    _ShotAngle = [CCDrawNode node];
    if(_ShotAngle != nil && firstClick == YES){
        //[self removeChild:_ShotAngle cleanup:YES];
    }
    [_ShotAngle drawSegmentFrom:ccp(_mouseJointNode.position.x, _mouseJointNode.position.y) to:ccp(_mouseJointNode2.position.x, _mouseJointNode2.position.y) radius:1.f color:[CCColor redColor]];
    //[self addChild:_ShotAngle];
}


-(void) touchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
    // when touches end, meaning the user releases their finger, release the catapult
    [self launchBall];
    firstClick = NO;
}

-(void) touchCancelled:(UITouch *)touch withEvent:(UIEvent *)event
{
    // when touches are cancelled, meaning the user drags their finger off the screen or onto something else, release the catapult
    firstClick = NO;
    
}

-(void)ccPhysicsCollisionPostSolve:(CCPhysicsCollisionPair *)pair Can:(CCNode *)nodeA wildcard:(CCNode *)nodeB
{
    float energy = [pair totalKineticEnergy];
    // if energy is large enough, remove the can
    if (energy > ENERGY_SPEED) {
        [[_physicsNode space] addPostStepBlock:^{
            [self canRemoved:nodeA];
        } key:nodeA];
    }
}
- (void)canRemoved:(CCNode *)Can {
    //load blow up effect
    CCParticleSystem *explosion = (CCParticleSystem *)[CCBReader load:@"Blowup"];
    //clean up particles once can has blown up
    explosion.autoRemoveOnFinish = TRUE;
    //places the blow up on can
    explosion.position = Can.position;
    //add blow up to the same node the can was on
    [Can.parent addChild:explosion];
    //remove destroyed can
    [Can removeFromParent];
    
    
}


-(void) showPopoverNamed:(NSString*)name
{
    if (_popoverMenuLayer == nil)
    {
        GameMenuLayer* newMenuLayer = (GameMenuLayer*)[CCBReader load:name];
        [self addChild:newMenuLayer];
        _popoverMenuLayer = newMenuLayer;
        _popoverMenuLayer.gameScene = self;
        _gameMenuLayer.visible = NO;
        _levelNode.paused = YES;
    }
}

-(void) removePopover
{
    if (_popoverMenuLayer)
    {
        [_popoverMenuLayer removeFromParent];
        _popoverMenuLayer = nil;
        _gameMenuLayer.visible = YES;
        _levelNode.paused = NO;
    }
}

@end
