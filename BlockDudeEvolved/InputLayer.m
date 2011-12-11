//
//  InputLayer.m
//  BlockDudeEvolved
//
//  Created by Billy Connolly on 12/7/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "InputLayer.h"
#import "GameScene.h"
#import "PauseScene.h"

enum {
    O_NONE=0,
    O_UP,
    O_RIGHT,
    O_DOWN,
    O_LEFT
};

@implementation InputLayer
@synthesize pauseButton;
@synthesize directionalStick;
@synthesize acceptInput;

- (id)init{
    self = [super init];
    if(self){
        self.isTouchEnabled = YES;
        self.acceptInput = YES;
        
        orientation = O_NONE;
        self.directionalStick = [[CCSprite alloc] initWithFile: @"Gui.png" rect: CGRectMake(0, 0, 128, 128)];
        [directionalStick setPosition: ccp(480 - 64 - 16, 64 + 16)];
        [self addChild: directionalStick];
        
        self.pauseButton = [[CCSprite alloc] initWithTexture: [directionalStick texture] rect: CGRectMake(320, 224, 64, 32)];
        [pauseButton setPosition: ccp(240, 304)];
        [self addChild: pauseButton];
        
    }
    return self;
}

- (void)repeat{
    if(self.acceptInput){
        if(orientation != O_NONE){
            [(GameScene *)parent_ moveInDirection: orientation];
        }
    }
}

- (void)stickDown:(int)orient{
    switch(orient){
        case O_NONE:
            [directionalStick setDisplayFrame: [CCSpriteFrame frameWithTexture:[directionalStick texture] rect:CGRectMake(0, 0, 128, 128)]];
            break;
        case O_UP:
            [directionalStick setDisplayFrame: [CCSpriteFrame frameWithTexture:[directionalStick texture] rect:CGRectMake(128, 0, 128, 128)]];
            break;
        case O_RIGHT:
            [directionalStick setDisplayFrame: [CCSpriteFrame frameWithTexture:[directionalStick texture] rect:CGRectMake(256, 0, 128, 128)]];
            break;
        case O_DOWN:
            [directionalStick setDisplayFrame: [CCSpriteFrame frameWithTexture:[directionalStick texture] rect:CGRectMake(0, 128, 128, 128)]];
            break;
        case O_LEFT:
            [directionalStick setDisplayFrame: [CCSpriteFrame frameWithTexture:[directionalStick texture] rect:CGRectMake(128, 128, 128, 128)]];
            break;
    }
}

- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    UITouch *touch = [touches anyObject];
    CGPoint location = [[CCDirector sharedDirector] convertToGL: [touch locationInView: touch.view]];

    CGPoint locationRelative = ccp(location.x - directionalStick.position.x, location.y - directionalStick.position.y);
    if(locationRelative.x <= 64 && locationRelative.x >= -64 && locationRelative.y <= 64 && locationRelative.y >= -64){
        if(orientation == O_NONE){
            if(locationRelative.y >= 22){
                [self stickDown: O_UP];
                orientation = O_UP;
                [self repeat];
                [self schedule:@selector(repeat) interval:0.15f];
            }else if(locationRelative.y <= -22){
                [self stickDown: O_DOWN];
                orientation = O_DOWN;
                [self repeat];
                [self schedule:@selector(repeat) interval:0.15f];
            }else if(locationRelative.x >= 22){
                [self stickDown: O_RIGHT];
                orientation = O_RIGHT;
                [self repeat];
                [self schedule:@selector(repeat) interval:0.15f];
            }else if(locationRelative.x <= -22){
                [self stickDown: O_LEFT];
                orientation = O_LEFT;
                [self repeat];
                [self schedule:@selector(repeat) interval:0.15f];
            }
        }
    }else{
        if(location.x >= [pauseButton position].x - 40 && location.x <= [pauseButton position].x + 40 && location.y <= [pauseButton position].y + 24 && location.y >= [pauseButton position].y - 24){
            PauseScene *ps = [[PauseScene alloc] init];
            [[CCDirector sharedDirector] pushScene: [CCTransitionFade transitionWithDuration:0.5f scene:ps]];
            [ps release];
            [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];
        }
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
