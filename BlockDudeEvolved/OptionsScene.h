//
//  OptionsScene.h
//  BlockDudeEvolved
//
//  Created by Billy Connolly on 12/17/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"

@interface OptionsScene : CCScene <UIAlertViewDelegate>{
    CCLabelTTF *optionsLabel;
    
    CCSprite *csDpadSprite;
    CCSprite *csButton1Sprite;
    CCSprite *csButton2Sprite;
    
    CCSprite *speedModeSprite;
    
    CCMenu *controlSchemeMenu;
}

- (id)init;

@property (nonatomic, retain) CCLabelTTF *optionsLabel;
@property (nonatomic, retain) CCMenu *controlSchemeMenu;

- (void)csDpad;
- (void)csButtons1;
- (void)csButtons2;

- (void)toMenu;
- (void)resetAchievements;
- (void)speedModeToggle;

@end
