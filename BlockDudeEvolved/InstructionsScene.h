//
//  InstructionsScene.h
//  BlockDudeEvolved
//
//  Created by Billy Connolly on 1/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"

@interface InstructionsScene : CCLayer{
    CCMenu *menu;
    
    CCLabelTTF *instructionLabel;
    CCSprite *instructionBackground;
    
    NSArray *slideTexts;
    int currentSlide;
    
    CCSprite *blockDude;
    CCSprite *controls;
    CCSprite *door;
    CCSprite *brick;
    CCSprite *block;
    CCSprite *blank;
    CCSprite *editorBackground;
    
    CCSprite *panOrDraw;
}

+ (id)scene;

@property (nonatomic, retain) CCMenu *menu;
@property (nonatomic, retain) CCSprite *instructionBackground;
@property (nonatomic, retain) CCLabelTTF *instructionLabel;
@property (nonatomic, retain) NSArray *slideTexts;

- (void)toMenu;
- (void)advanceSlide;

@end
