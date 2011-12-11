//
//  PauseScene.m
//  BlockDudeEvolved
//
//  Created by Billy Connolly on 12/10/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "PauseScene.h"
#import "MainMenuScene.h"

@implementation PauseScene
@synthesize pauseLabel;
@synthesize menu;

- (id)init{
    self = [super init];
    if(self){
        self.pauseLabel = [[CCLabelTTF alloc] initWithString:@"Pause" fontName:@"Krungthep" fontSize:36.0f];
        [pauseLabel setPosition: ccp(240, 260)];
        [self addChild: pauseLabel];
        
        CCLabelTTF *returnToGame = [[CCLabelTTF alloc] initWithString:@"Return to Game" fontName:@"Krungthep" fontSize:36.0f];
        CCMenuItemLabel *returnToGameLabel = [[CCMenuItemLabel alloc] initWithLabel:returnToGame target:self selector:@selector(returnToGame)];
        
        CCLabelTTF *options = [[CCLabelTTF alloc] initWithString:@"Options" fontName:@"Krungthep" fontSize:36.0f];
        CCMenuItemLabel *optionsLabel = [[CCMenuItemLabel alloc] initWithLabel:options target:self selector:@selector(options)];
        [optionsLabel setPosition: ccp(0, -50)];
        
        CCLabelTTF *exitGame = [[CCLabelTTF alloc] initWithString:@"Exit Game" fontName:@"Krungthep" fontSize:36.0f];
        CCMenuItemLabel *exitGameLabel = [[CCMenuItemLabel alloc] initWithLabel:exitGame target:self selector:@selector(exitGame)];
        [exitGameLabel setPosition: ccp(0, -100)];
        
        self.menu = [CCMenu menuWithItems:returnToGameLabel, optionsLabel, exitGameLabel, nil];
        [self addChild: menu];
        
        [returnToGame release];
        [returnToGameLabel release];
        [options release];
        [optionsLabel release];
        [exitGame release];
        [exitGameLabel release];
    }
    return self;
}

- (void)returnToGame{
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
    [[CCDirector sharedDirector] popSceneWithTransition:[CCTransitionFade class] duration:0.5f];
}

- (void)options{
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
    NSLog(@"Options");
}

- (void)exitGame{
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
    [[CCDirector sharedDirector] popScene];
    CCScene *mms = [[MainMenuScene alloc] init];
    [[CCDirector sharedDirector] replaceScene: [CCTransitionFade transitionWithDuration:0.5f scene:mms]];
}

@end