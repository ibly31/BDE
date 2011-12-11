//
//  MainMenuScene.m
//  BlockDudeEvolved
//
//  Created by Billy Connolly on 12/10/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "MainMenuScene.h"
#import "ChooseLevelScene.h"

@implementation MainMenuScene
@synthesize menu;

- (id)init{
    self = [super init];
    if(self){
        CCLabelTTF *playGame = [[CCLabelTTF alloc] initWithString:@"Play" fontName:@"Krungthep" fontSize:24.0f];
        CCMenuItemLabel *playGameLabel = [[CCMenuItemLabel alloc] initWithLabel:playGame target:self selector:@selector(playGame)];
        [playGameLabel setPosition: ccp(10, 35)];
        
        CCLabelTTF *options = [[CCLabelTTF alloc] initWithString:@"Options" fontName:@"Krungthep" fontSize:24.0f];
        CCMenuItemLabel *optionsLabel = [[CCMenuItemLabel alloc] initWithLabel:options target:self selector:@selector(options)];
        [optionsLabel setPosition: ccp(10, -38)];
        
        //10,-113
        
        self.menu = [CCMenu menuWithItems:playGameLabel, optionsLabel, nil];
        [self addChild: menu];
        [playGame release];
        [playGameLabel release];
        [options release];
        [optionsLabel release];
    }
    return self;
}

- (void)playGame{
    ChooseLevelScene *cls = [[ChooseLevelScene alloc] init];
    [[CCDirector sharedDirector] pushScene: [CCTransitionFade transitionWithDuration:0.5f scene:cls]];
    [cls release];
}

- (void)options{
    
}

@end
