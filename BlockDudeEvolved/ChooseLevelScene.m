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
        
        CCLabelTTF *lev1 = [[CCLabelTTF alloc] initWithString:@"Level 1" fontName:@"Krungthep" fontSize:20];
        CCMenuItemLabel *lev1L = [[CCMenuItemLabel alloc] initWithLabel:lev1 target:self selector:@selector(playLevel1)];
        [lev1L setAnchorPoint: ccp(0.0f, 0.5f)];
        [lev1L setPosition: ccp(32, 233)];
        
        CCLabelTTF *lev2 = [[CCLabelTTF alloc] initWithString:@"Level 2" fontName:@"Krungthep" fontSize:20];
        CCMenuItemLabel *lev2L = [[CCMenuItemLabel alloc] initWithLabel:lev2 target:self selector:@selector(playLevel2)];
        [lev2L setAnchorPoint: ccp(0.0f, 0.5f)];
        [lev2L setPosition: ccp(32, 193)];
        
        CCLabelTTF *lev3 = [[CCLabelTTF alloc] initWithString:@"Level 3" fontName:@"Krungthep" fontSize:20];
        CCMenuItemLabel *lev3L = [[CCMenuItemLabel alloc] initWithLabel:lev3 target:self selector:@selector(playLevel3)];
        [lev3L setAnchorPoint: ccp(0.0f, 0.5f)];
        [lev3L setPosition: ccp(32, 153)];
        
        CCLabelTTF *lev4 = [[CCLabelTTF alloc] initWithString:@"Level 4" fontName:@"Krungthep" fontSize:20];
        CCMenuItemLabel *lev4L = [[CCMenuItemLabel alloc] initWithLabel:lev4 target:self selector:@selector(playLevel4)];
        [lev4L setAnchorPoint: ccp(0.0f, 0.5f)];
        [lev4L setPosition: ccp(32, 113)];
        
        CCLabelTTF *lev5 = [[CCLabelTTF alloc] initWithString:@"Level 5" fontName:@"Krungthep" fontSize:20];
        CCMenuItemLabel *lev5L = [[CCMenuItemLabel alloc] initWithLabel:lev5 target:self selector:@selector(playLevel5)];
        [lev5L setAnchorPoint: ccp(0.0f, 0.5f)];
        [lev5L setPosition: ccp(32, 73)];
        
        CCLabelTTF *lev6 = [[CCLabelTTF alloc] initWithString:@"Level 6" fontName:@"Krungthep" fontSize:20];
        CCMenuItemLabel *lev6L = [[CCMenuItemLabel alloc] initWithLabel:lev6 target:self selector:@selector(playLevel6)];
        [lev6L setAnchorPoint: ccp(0.0f, 0.5f)];
        [lev6L setPosition: ccp(32, 33)];
        
        CCLabelTTF *lev7 = [[CCLabelTTF alloc] initWithString:@"Level 7" fontName:@"Krungthep" fontSize:20];
        CCMenuItemLabel *lev7L = [[CCMenuItemLabel alloc] initWithLabel:lev7 target:self selector:@selector(playLevel7)];
        [lev7L setAnchorPoint: ccp(0.0f, 0.5f)];
        [lev7L setPosition: ccp(140, 233)];
        
        CCLabelTTF *lev8 = [[CCLabelTTF alloc] initWithString:@"Level 8" fontName:@"Krungthep" fontSize:20];
        CCMenuItemLabel *lev8L = [[CCMenuItemLabel alloc] initWithLabel:lev8 target:self selector:@selector(playLevel8)];
        [lev8L setAnchorPoint: ccp(0.0f, 0.5f)];
        [lev8L setPosition: ccp(140, 193)];
        
        CCLabelTTF *lev9 = [[CCLabelTTF alloc] initWithString:@"Level 9" fontName:@"Krungthep" fontSize:20];
        CCMenuItemLabel *lev9L = [[CCMenuItemLabel alloc] initWithLabel:lev9 target:self selector:@selector(playLevel9)];
        [lev9L setAnchorPoint: ccp(0.0f, 0.5f)];
        [lev9L setPosition: ccp(140, 153)];
        
        CCLabelTTF *lev10 = [[CCLabelTTF alloc] initWithString:@"Level 10" fontName:@"Krungthep" fontSize:20];
        CCMenuItemLabel *lev10L = [[CCMenuItemLabel alloc] initWithLabel:lev10 target:self selector:@selector(playLevel10)];
        [lev10L setAnchorPoint: ccp(0.0f, 0.5f)];
        [lev10L setPosition: ccp(140, 113)];
        
        CCLabelTTF *lev11 = [[CCLabelTTF alloc] initWithString:@"Level 11" fontName:@"Krungthep" fontSize:20];
        CCMenuItemLabel *lev11L = [[CCMenuItemLabel alloc] initWithLabel:lev11 target:self selector:@selector(playLevel11)];
        [lev11L setAnchorPoint: ccp(0.0f, 0.5f)];
        [lev11L setPosition: ccp(140, 73)];
        
        CCLabelTTF *lev12 = [[CCLabelTTF alloc] initWithString:@"Level 12" fontName:@"Krungthep" fontSize:20];
        CCMenuItemLabel *lev12L = [[CCMenuItemLabel alloc] initWithLabel:lev12 target:self selector:@selector(playLevel12)];
        [lev12L setAnchorPoint: ccp(0.0f, 0.5f)];
        [lev12L setPosition: ccp(140, 33)];
        
        CCLabelTTF *lev13 = [[CCLabelTTF alloc] initWithString:@"Level 13" fontName:@"Krungthep" fontSize:20];
        CCMenuItemLabel *lev13L = [[CCMenuItemLabel alloc] initWithLabel:lev13 target:self selector:@selector(playLevel13)];
        [lev13L setAnchorPoint: ccp(0.0f, 0.5f)];
        [lev13L setPosition: ccp(248, 233)];
        
        CCLabelTTF *lev14 = [[CCLabelTTF alloc] initWithString:@"Level 14" fontName:@"Krungthep" fontSize:20];
        CCMenuItemLabel *lev14L = [[CCMenuItemLabel alloc] initWithLabel:lev14 target:self selector:@selector(playLevel14)];
        [lev14L setAnchorPoint: ccp(0.0f, 0.5f)];
        [lev14L setPosition: ccp(248, 193)];
        
        CCLabelTTF *lev15 = [[CCLabelTTF alloc] initWithString:@"Level 15" fontName:@"Krungthep" fontSize:20];
        CCMenuItemLabel *lev15L = [[CCMenuItemLabel alloc] initWithLabel:lev15 target:self selector:@selector(playLevel15)];
        [lev15L setAnchorPoint: ccp(0.0f, 0.5f)];
        [lev15L setPosition: ccp(248, 153)];
        
        CCLabelTTF *lev16 = [[CCLabelTTF alloc] initWithString:@"Level 16" fontName:@"Krungthep" fontSize:20];
        CCMenuItemLabel *lev16L = [[CCMenuItemLabel alloc] initWithLabel:lev16 target:self selector:@selector(playLevel16)];
        [lev16L setAnchorPoint: ccp(0.0f, 0.5f)];
        [lev16L setPosition: ccp(248, 113)];
        
        CCLabelTTF *lev17 = [[CCLabelTTF alloc] initWithString:@"Level 17" fontName:@"Krungthep" fontSize:20];
        CCMenuItemLabel *lev17L = [[CCMenuItemLabel alloc] initWithLabel:lev17 target:self selector:@selector(playLevel17)];
        [lev17L setAnchorPoint: ccp(0.0f, 0.5f)];
        [lev17L setPosition: ccp(248, 73)];
        
        CCLabelTTF *lev18 = [[CCLabelTTF alloc] initWithString:@"Level 18" fontName:@"Krungthep" fontSize:20];
        CCMenuItemLabel *lev18L = [[CCMenuItemLabel alloc] initWithLabel:lev18 target:self selector:@selector(playLevel18)];
        [lev18L setAnchorPoint: ccp(0.0f, 0.5f)];
        [lev18L setPosition: ccp(248, 33)];
        
        CCLabelTTF *lev19 = [[CCLabelTTF alloc] initWithString:@"Level 19" fontName:@"Krungthep" fontSize:20];
        CCMenuItemLabel *lev19L = [[CCMenuItemLabel alloc] initWithLabel:lev19 target:self selector:@selector(playLevel19)];
        [lev19L setAnchorPoint: ccp(0.0f, 0.5f)];
        [lev19L setPosition: ccp(356, 233)];
        
        CCLabelTTF *lev20 = [[CCLabelTTF alloc] initWithString:@"Level 20" fontName:@"Krungthep" fontSize:20];
        CCMenuItemLabel *lev20L = [[CCMenuItemLabel alloc] initWithLabel:lev20 target:self selector:@selector(playLevel20)];
        [lev20L setAnchorPoint: ccp(0.0f, 0.5f)];
        [lev20L setPosition: ccp(356, 193)];
        
        CCLabelTTF *lev21 = [[CCLabelTTF alloc] initWithString:@"Level 21" fontName:@"Krungthep" fontSize:20];
        CCMenuItemLabel *lev21L = [[CCMenuItemLabel alloc] initWithLabel:lev21 target:self selector:@selector(playLevel21)];
        [lev21L setAnchorPoint: ccp(0.0f, 0.5f)];
        [lev21L setPosition: ccp(356, 153)];
        
        CCLabelTTF *lev22 = [[CCLabelTTF alloc] initWithString:@"Level 22" fontName:@"Krungthep" fontSize:20];
        CCMenuItemLabel *lev22L = [[CCMenuItemLabel alloc] initWithLabel:lev22 target:self selector:@selector(playLevel22)];
        [lev22L setAnchorPoint: ccp(0.0f, 0.5f)];
        [lev22L setPosition: ccp(356, 113)];
        
        self.menu = [CCMenu menuWithItems: lev1L, lev2L, lev3L, lev4L, lev5L, lev6L, lev7L, lev8L, lev9L, lev10L, lev11L, lev12L, lev13L, lev14L, lev15L, lev16L, lev17L, lev18L, lev19L, lev20L, lev21L, lev22L, nil];
        [menu setPosition: ccp(0.0f, 0.0f)];
        [self addChild: menu];
        
        [lev1 release];
        [lev1L release];
        [lev2 release];
        [lev2L release];
        [lev3 release];
        [lev3L release];
        [lev4 release];
        [lev4L release];
        [lev5 release];
        [lev5L release];
        [lev6 release];
        [lev6L release];
        [lev7 release];
        [lev7L release];
        [lev8 release];
        [lev8L release];
        [lev9 release];
        [lev9L release];
        [lev10 release];
        [lev10L release];
        [lev11 release];
        [lev11L release];
        [lev12 release];
        [lev12L release];
        [lev13 release];
        [lev13L release];
        [lev14 release];
        [lev14L release];
        [lev15 release];
        [lev15L release];
        [lev16 release];
        [lev16L release];
        [lev17 release];
        [lev17L release];
        [lev18 release];
        [lev18L release];
        [lev19 release];
        [lev19L release];
        [lev20 release];
        [lev20L release];
        [lev21 release];
        [lev21L release];
        [lev22 release];
        [lev22L release];
    }
    return self;
}

- (void)playLevel:(int)level{
    GameScene *gs = [[GameScene alloc] initWithLevel: level];
    [[CCDirector sharedDirector] pushScene: [CCTransitionFade transitionWithDuration:0.5f scene:gs]];
    [gs release];
}

- (void)playLevel1{
    [self playLevel: 1];
}

- (void)playLevel2{
    [self playLevel: 2];
}

- (void)playLevel3{
    [self playLevel: 3];
}

- (void)playLevel4{
    [self playLevel: 4];
}

- (void)playLevel5{
    [self playLevel: 5];
}

- (void)playLevel6{
    [self playLevel: 6];
}

- (void)playLevel7{
    [self playLevel: 7];
}

- (void)playLevel8{
    [self playLevel: 8];
}

- (void)playLevel9{
    [self playLevel: 9];
}

- (void)playLevel10{
    [self playLevel: 10];
}

- (void)playLevel11{
    [self playLevel: 11];
}

- (void)playLevel12{
    [self playLevel: 12];
}

- (void)playLevel13{
    [self playLevel: 13];
}

- (void)playLevel14{
    [self playLevel: 14];
}

- (void)playLevel15{
    [self playLevel: 15];
}

- (void)playLevel16{
    [self playLevel: 16];
}

- (void)playLevel17{
    [self playLevel: 17];
}

- (void)playLevel18{
    [self playLevel: 18];
}

- (void)playLevel19{
    [self playLevel: 19];
}

- (void)playLevel20{
    [self playLevel: 20];
}

- (void)playLevel21{
    [self playLevel: 21];
}

- (void)playLevel22{
    [self playLevel: 22];
}

@end
