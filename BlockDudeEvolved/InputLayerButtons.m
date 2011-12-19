//
//  InputLayerButtons.m
//  BlockDudeEvolved
//
//  Created by Billy Connolly on 12/17/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "InputLayerButtons.h"
#import "GameScene.h"
#import "PauseScene.h"

enum {
    O_NONE=0,
    O_UP,
    O_RIGHT,
    O_DOWN,
    O_LEFT
};

@implementation InputLayerButtons
@synthesize pauseButton;
@synthesize up;
@synthesize right;
@synthesize down;
@synthesize left;
@synthesize acceptInput;

- (id)init{
    self = [super init];
    if(self){
        self.isTouchEnabled = YES;
        self.acceptInput = YES;
        
        BOOL speedMode = [[NSUserDefaults standardUserDefaults] boolForKey:@"SpeedMode"];
        if(speedMode){
            waitTime = 0.07f;
            firstWaitTime = 0.15f;
            didFirstWaits = 0;
        }else{
            waitTime = 0.1f;
            firstWaitTime = 0.3f;
            didFirstWaits = 0;
        }
        
        orientation = O_NONE;
        
        self.up = [[CCSprite alloc] initWithFile: @"Buttons.png" rect: CGRectMake(144, 0, 48, 48)];
        self.right = [[CCSprite alloc] initWithTexture:[up texture] rect: CGRectMake(192, 0, 48, 48)];
        self.down = [[CCSprite alloc] initWithTexture:[up texture] rect: CGRectMake(240, 0, 48, 48)];
        self.left = [[CCSprite alloc] initWithTexture:[up texture] rect: CGRectMake(288, 0, 48, 48)];
        
        int controlScheme = [[NSUserDefaults standardUserDefaults] integerForKey:@"ControlScheme"];
        if(controlScheme == 2){
            [up setPosition: ccp(48, 96)];
            [down setPosition: ccp(48, 32)];
            
            [right setPosition: ccp(432, 64)];
            [left setPosition: ccp(368, 64)];
        }else if(controlScheme == 3){
            [up setPosition: ccp(112, 64)];
            [down setPosition: ccp(368, 64)];
            
            [right setPosition: ccp(432, 64)];
            [left setPosition: ccp(48, 64)];
        }
        
        [self addChild: up];
        [self addChild: right];
        [self addChild: down];
        [self addChild: left];
        
        self.pauseButton = [[CCSprite alloc] initWithFile:@"Gui.png" rect: CGRectMake(320, 224, 64, 32)];
        [pauseButton setPosition: ccp(240, 304)];
        [pauseButton setOpacity: 220];
        [self addChild: pauseButton];
        
    }
    return self;
}

- (void)repeat{
    if(self.acceptInput){
        if(orientation != O_NONE){
            [(GameScene *)parent_ moveInDirection: orientation];
            if(didFirstWaits == 1){                                     // dfw = 2 is before first repeat, dfw = 1 is after big wait
                [self unschedule: @selector(repeat)];                   // dfw = 0 is after big wait, normal repeat
                [self schedule: @selector(repeat) interval:waitTime];
                didFirstWaits = 0;
            }else if(didFirstWaits == 2){
                didFirstWaits = 1;
            }
        }
    }
}

- (void)stickDown:(int)orient{
    switch(orient){
        case O_NONE:
            [up setColor: ccc3(255, 255, 255)];
            [right setColor: ccc3(255, 255, 255)];
            [down setColor: ccc3(255, 255, 255)];
            [left setColor: ccc3(255, 255, 255)];
            break;
        case O_UP:
            [up setColor: ccc3(128, 128, 128)];
            [right setColor: ccc3(255, 255, 255)];
            [down setColor: ccc3(255, 255, 255)];
            [left setColor: ccc3(255, 255, 255)];
            break;
        case O_RIGHT:
            [up setColor: ccc3(255, 255, 255)];
            [right setColor: ccc3(128, 128, 128)];
            [down setColor: ccc3(255, 255, 255)];
            [left setColor: ccc3(255, 255, 255)];
            break;
        case O_DOWN:
            [up setColor: ccc3(255, 255, 255)];
            [right setColor: ccc3(255, 255, 255)];
            [down setColor: ccc3(128, 128, 128)];
            [left setColor: ccc3(255, 255, 255)];
            break;
        case O_LEFT:
            [up setColor: ccc3(255, 255, 255)];
            [right setColor: ccc3(255, 255, 255)];
            [down setColor: ccc3(255, 255, 255)];
            [left setColor: ccc3(128, 128, 128)];
            break;
    }
}

- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    UITouch *touch = [touches anyObject];
    CGPoint location = [[CCDirector sharedDirector] convertToGL: [touch locationInView: touch.view]];
    
    CGPoint locationRelativeUp = ccp(fabsf(location.x - [up position].x), fabsf(location.y - [up position].y));
    CGPoint locationRelativeRight = ccp(fabsf(location.x - [right position].x), fabsf(location.y - [right position].y));
    CGPoint locationRelativeDown = ccp(fabsf(location.x - [down position].x), fabsf(location.y - [down position].y));
    CGPoint locationRelativeLeft = ccp(fabsf(location.x - [left position].x), fabsf(location.y - [left position].y));
        
    if(location.x >= [pauseButton position].x - 40 && location.x <= [pauseButton position].x + 40 && location.y <= [pauseButton position].y + 24 && location.y >= [pauseButton position].y - 24){
        PauseScene *ps = [[PauseScene alloc] initWithGameScene: (GameScene *)parent_];
        [[CCDirector sharedDirector] pushScene: [CCTransitionFade transitionWithDuration:0.5f scene:ps]];
        [ps release];
        return;
    }
    
    if(locationRelativeUp.x <= 32 && locationRelativeUp.y <= 32){
        [self stickDown: O_UP];
        orientation = O_UP;
        didFirstWaits = 2;
        [self repeat];
        [self schedule:@selector(repeat) interval:firstWaitTime];
    }else if(locationRelativeRight.x <= 32 && locationRelativeRight.y <= 32){
        [self stickDown: O_RIGHT];
        orientation = O_RIGHT;
        didFirstWaits = 2;
        [self repeat];
        [self schedule:@selector(repeat) interval:firstWaitTime];
    }else if(locationRelativeDown.x <= 32 && locationRelativeDown.y <= 32){
        [self stickDown: O_DOWN];
        orientation = O_DOWN;
        didFirstWaits = 2;
        [self repeat];
        [self schedule:@selector(repeat) interval:firstWaitTime];
    }else if(locationRelativeLeft.x <= 32 && locationRelativeLeft.y <= 32){
        [self stickDown: O_LEFT];
        orientation = O_LEFT;
        didFirstWaits = 2;
        [self repeat];
        [self schedule:@selector(repeat) interval:firstWaitTime];
    }
    
}

- (void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    if(orientation != O_NONE){
        [self stickDown: O_NONE];
        orientation = O_NONE;
        [self unschedule: @selector(repeat)];
    }
}


@end
