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
@synthesize titleLabel;
@synthesize menu;

- (id)init{
    self = [super init];
    if(self){
        
        self.titleLabel = [[CCLabelTTF alloc] initWithString:@"Block Dude Evolved" fontName:@"Krungthep" fontSize:36];
        [titleLabel setPosition: ccp(240, 280)];
        [self addChild: titleLabel];
        
        CCLabelTTF *playGame = [[CCLabelTTF alloc] initWithString:@"Play" fontName:@"Krungthep" fontSize:28];
        CCMenuItemLabel *playGameLabel = [[CCMenuItemLabel alloc] initWithLabel:playGame target:self selector:@selector(playGame)];
        [playGameLabel setPosition: ccp(10, 0)];
        
        CCLabelTTF *options = [[CCLabelTTF alloc] initWithString:@"Options" fontName:@"Krungthep" fontSize:28];
        CCMenuItemLabel *optionsLabel = [[CCMenuItemLabel alloc] initWithLabel:options target:self selector:@selector(options)];
        [optionsLabel setPosition: ccp(10, -58)];
        
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
