//
//  ChooseLevelScene.m
//  BlockDudeEvolved
//
//  Created by Billy Connolly on 12/10/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ChooseLevelScene.h"
#import "GameScene.h"

@implementation ChooseLevelScene
@synthesize chooseLevel;
@synthesize menu;

- (id)init{
    self = [super init];
    if(self){
        
        self.chooseLevel = [[CCLabelTTF alloc] initWithString:@"Choose Level" fontName:@"Krungthep" fontSize:36];
        [chooseLevel setPosition: ccp(240, 280)];
        [self addChild: chooseLevel];
        
        CCLabelTTF *lev1 = [[CCLabelTTF alloc] initWithString:@"Level 1" fontName:@"Krungthep" fontSize:32];
        CCMenuItemLabel *lev1L = [[CCMenuItemLabel alloc] initWithLabel:lev1 target:self selector:@selector(playLevel1)];
        [lev1L setPosition: ccp(100, 223)];
        
        CCLabelTTF *lev2 = [[CCLabelTTF alloc] initWithString:@"Level 2" fontName:@"Krungthep" fontSize:32];
        CCMenuItemLabel *lev2L = [[CCMenuItemLabel alloc] initWithLabel:lev2 target:self selector:@selector(playLevel2)];
        [lev2L setPosition: ccp(100, 183)];
        
        CCLabelTTF *lev3 = [[CCLabelTTF alloc] initWithString:@"Level 3" fontName:@"Krungthep" fontSize:32];
        CCMenuItemLabel *lev3L = [[CCMenuItemLabel alloc] initWithLabel:lev3 target:self selector:@selector(playLevel3)];
        [lev3L setPosition: ccp(100, 143)];
        
        CCLabelTTF *lev4 = [[CCLabelTTF alloc] initWithString:@"Level 4" fontName:@"Krungthep" fontSize:32];
        CCMenuItemLabel *lev4L = [[CCMenuItemLabel alloc] initWithLabel:lev4 target:self selector:@selector(playLevel4)];
        [lev4L setPosition: ccp(100, 103)];
        
        CCLabelTTF *lev5 = [[CCLabelTTF alloc] initWithString:@"Level 5" fontName:@"Krungthep" fontSize:32];
        CCMenuItemLabel *lev5L = [[CCMenuItemLabel alloc] initWithLabel:lev5 target:self selector:@selector(playLevel5)];
        [lev5L setPosition: ccp(100, 63)];
        
        self.menu = [CCMenu menuWithItems:lev1L,lev2L, lev3L, lev4L, lev5L, nil];
        [menu setPosition: ccp(0.0f, 0.0f)];
        [self addChild: menu];

    }
    return self;
}

- (void)playLevel:(NSString *)level{
    GameScene *gs = [[GameScene alloc] initWithLevel: level];
    [[CCDirector sharedDirector] pushScene: [CCTransitionFade transitionWithDuration:0.5f scene:gs]];
    [gs release];
}

- (void)playLevel1{
    [self playLevel: @"Level1"];
}

- (void)playLevel2{
    [self playLevel: @"Level2"];
}

- (void)playLevel3{
    [self playLevel: @"Level3"];
}

- (void)playLevel4{
    [self playLevel: @"Level4"];
}

- (void)playLevel5{
    [self playLevel: @"Level5"];
}

- (void)playLevel6{
    [self playLevel: @"Level6"];
}


@end
