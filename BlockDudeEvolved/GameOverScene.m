//
//  GameOverScene.m
//  BlockDudeEvolved
//
//  Created by Billy Connolly on 12/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "GameOverScene.h"
#import "MainMenuScene.h"

@implementation GameOverScene
@synthesize movesLabel;
@synthesize timeTakenLabel;
@synthesize menu;

- (id)initWithMoves:(int)moves timeTaken:(NSTimeInterval)time{
    self = [super init];
    if(self){
        self.movesLabel = [[CCLabelTTF alloc] initWithString:[NSString stringWithFormat:@"Moves taken: %i", moves] fontName:@"Krungthep" fontSize:24];
        [movesLabel setPosition: ccp(240, 223)];
        [self addChild: movesLabel];
        
        self.timeTakenLabel = [[CCLabelTTF alloc] initWithString:[NSString stringWithFormat:@"Time taken: %.2fs",time] fontName:@"Krungthep" fontSize:24];
        [timeTakenLabel setPosition: ccp(240, 183)];
        [self addChild: timeTakenLabel];
        
        CCSprite *menuSprite = [[CCSprite alloc] initWithFile:@"Gui.png" rect:CGRectMake(256, 128, 64, 64)];
        CCMenuItemSprite *menuItem = [CCMenuItemSprite itemFromNormalSprite:menuSprite selectedSprite:nil target:self selector:@selector(toMenu)];
        [menuItem setPosition: ccp(160, 64)];
                
        CCSprite *gcSprite = [[CCSprite alloc] initWithFile:@"Gui.png" rect:CGRectMake(320, 128, 64, 64)];
        CCMenuItemSprite *gcItem = [CCMenuItemSprite itemFromNormalSprite:gcSprite selectedSprite:nil target:self selector:@selector(toGameCenter)];
        [gcItem setPosition: ccp(320, 64)];
        
        self.menu = [CCMenu menuWithItems:menuItem, gcItem, nil];
        [menu setPosition: ccp(0.0f, 0.0f)];
        [self addChild: menu];
        
    }
    return self;
}

- (void)toMenu{
    MainMenuScene *mms = [[MainMenuScene alloc] init];
    [[CCDirector sharedDirector] replaceScene: [CCTransitionFade transitionWithDuration:0.5f scene:mms]];
    [mms release];
}

- (void)toGameCenter{
    
}

@end
