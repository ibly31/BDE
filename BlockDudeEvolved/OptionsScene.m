//
//  OptionsScene.m
//  BlockDudeEvolved
//
//  Created by Billy Connolly on 12/17/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "OptionsScene.h"
#import "AppDelegate.h"

@implementation OptionsScene
@synthesize optionsLabel;
@synthesize controlSchemeMenu;

- (id)init{
    self = [super init];
    if(self){
        self.optionsLabel = [[CCLabelTTF alloc] initWithString:@"Options" fontName:@"Krungthep" fontSize:36.0f];
        [optionsLabel setPosition: ccp(240, 280)];
        [self addChild: optionsLabel];
        
        CCLabelTTF *controlSchemeLabel = [[CCLabelTTF alloc] initWithString:@"Control Scheme:" fontName:@"Krungthep" fontSize:20];
        [controlSchemeLabel setPosition: ccp(110, 200)];
        [self addChild: controlSchemeLabel];
        
        int controlScheme = [[NSUserDefaults standardUserDefaults] integerForKey:@"ControlScheme"];
        
        csDpadSprite = [[CCSprite alloc] initWithFile:@"Gui.png" rect:CGRectMake(256, 127, 64, 64)];
        CCMenuItemSprite *csDpadItem = [CCMenuItemSprite itemFromNormalSprite:csDpadSprite selectedSprite:nil target:self selector:@selector(csDpad)];
        [csDpadItem setPosition: ccp(240, 200)];
        
        csButton1Sprite = [[CCSprite alloc] initWithFile:@"Gui.png" rect:CGRectMake(320, 127, 64, 64)];
        CCMenuItemSprite *csButton1Item = [CCMenuItemSprite itemFromNormalSprite:csButton1Sprite selectedSprite:nil target:self selector:@selector(csButtons1)];
        [csButton1Item setPosition: ccp(320, 200)];
        
        csButton2Sprite = [[CCSprite alloc] initWithFile:@"Gui.png" rect:CGRectMake(256, 192, 64, 64)];
        CCMenuItemSprite *csButton2Item = [CCMenuItemSprite itemFromNormalSprite:csButton2Sprite selectedSprite:nil target:self selector:@selector(csButtons2)];
        [csButton2Item setPosition: ccp(400, 200)];
        
        CCSprite *menuSprite = [[CCSprite alloc] initWithFile:@"Buttons.png" rect:CGRectMake(0, 0, 48, 48)];
        CCMenuItemSprite *menuItem = [CCMenuItemSprite itemFromNormalSprite:menuSprite selectedSprite:nil target:self selector:@selector(toMenu)];
        [menuItem setPosition: ccp(48, 48)];
        
        if(controlScheme == 1){
            [csDpadSprite setColor: ccc3(255, 255, 255)];
            [csButton1Sprite setColor: ccc3(128, 128, 128)];
            [csButton2Sprite setColor: ccc3(128, 128, 128)];
        }else if(controlScheme == 2){
            [csDpadSprite setColor: ccc3(128, 128, 128)];
            [csButton1Sprite setColor: ccc3(255, 255, 255)];
            [csButton2Sprite setColor: ccc3(128, 128, 128)];
        }else if(controlScheme == 3){
            [csDpadSprite setColor: ccc3(128, 128, 128)];
            [csButton1Sprite setColor: ccc3(128, 128, 128)];
            [csButton2Sprite setColor: ccc3(255, 255, 255)];
        }
        
        self.controlSchemeMenu = [CCMenu menuWithItems:csDpadItem, csButton1Item, csButton2Item, menuItem, nil];
        [controlSchemeMenu setPosition: ccp(0,0)];
        [self addChild: controlSchemeMenu];
    }
    return self;
}

- (void)csDpad{
    [[NSUserDefaults standardUserDefaults] setInteger:1 forKey:@"ControlScheme"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [csDpadSprite setColor: ccc3(255, 255, 255)];
    [csButton1Sprite setColor: ccc3(128, 128, 128)];
    [csButton2Sprite setColor: ccc3(128, 128, 128)];
}

- (void)csButtons1{
    [[NSUserDefaults standardUserDefaults] setInteger:2 forKey:@"ControlScheme"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [csDpadSprite setColor: ccc3(128, 128, 128)];
    [csButton1Sprite setColor: ccc3(255, 255, 255)];
    [csButton2Sprite setColor: ccc3(128, 128, 128)];
}

- (void)csButtons2{
    [[NSUserDefaults standardUserDefaults] setInteger:3 forKey:@"ControlScheme"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [csDpadSprite setColor: ccc3(128, 128, 128)];
    [csButton1Sprite setColor: ccc3(128, 128, 128)];
    [csButton2Sprite setColor: ccc3(255, 255, 255)];
}

- (void)toMenu{
    [[CCDirector sharedDirector] popSceneWithTransition:[CCTransitionFade class] duration:0.5f];
}

@end
