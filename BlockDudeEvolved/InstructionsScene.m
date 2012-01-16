//
//  InstructionsScene.m
//  BlockDudeEvolved
//
//  Created by Billy Connolly on 1/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "InstructionsScene.h"

@implementation InstructionsScene
@synthesize menu;

- (id)init{
    self = [super init];
    if(self){
        CCSprite *menuSprite = [[CCSprite alloc] initWithFile:@"Buttons.png" rect:CGRectMake(0, 0, 48, 48)];
        CCMenuItemSprite *menuItem = [CCMenuItemSprite itemFromNormalSprite:menuSprite selectedSprite:nil target:self selector:@selector(toMenu)];
        [menuItem setPosition: ccp(48, 48)];
        
        CCLabelTTF *instructGame = [[CCLabelTTF alloc] initWithString:@"Instructions: Game" fontName:@"Krungthep" fontSize:28];
        CCMenuItemLabel *instructGameLabel = [[CCMenuItemLabel alloc] initWithLabel:instructGame target:self selector:@selector(instructGame)];
        [instructGameLabel setPosition: ccp(240, 189)];
        
        CCLabelTTF *instructEditor = [[CCLabelTTF alloc] initWithString:@"Instructions: Editor" fontName:@"Krungthep" fontSize:28];
        CCMenuItemLabel *instructEditorLabel = [[CCMenuItemLabel alloc] initWithLabel:instructEditor target:self selector:@selector(instructEditor)];
        [instructEditorLabel setPosition: ccp(240, 131)];
        
        self.menu = [CCMenu menuWithItems:menuItem, instructGameLabel, instructEditorLabel, nil];
        [menu setPosition: ccp(0,0)];
        [self addChild:menu];
        
    }
    return self;
}

- (void)toMenu{
    [[CCDirector sharedDirector] popSceneWithTransition:[CCTransitionFade class] duration:0.5f];
}

- (void)instructGame{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Game" message:@"The object of the game is to get to the door. Pick up and put down blocks using the down button and move left and right using the buttons." delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil];
    [alert show];
    [alert release];
}

- (void)instructEditor{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Level Editor" message:@"To choose a different tile to draw, tap it in the tray below. Tap the hand/pencil icon to toggle between pan and draw mode. In pan mode you may tap to draw, and drag to pan the map." delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil];
    [alert show];
    [alert release];
}

@end
