//
//  ChooseLevelScene.h
//  BlockDudeEvolved
//
//  Created by Billy Connolly on 12/10/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"
#import <UIKit/UIKit.h>

@interface ChooseLevelScene : CCScene{
    
    CCLabelTTF *chooseLevel;
    
    CCMenu *menu;
}

@property (nonatomic, retain) CCLabelTTF *chooseLevel;
@property (nonatomic, retain) CCMenu *menu;

- (void)toMenu;
- (void)playLevel:(int)level;
- (void)playLevel1;
- (void)playLevel2;
- (void)playLevel3;
- (void)playLevel4;
- (void)playLevel5;
- (void)playLevel6;
- (void)playLevel7;
- (void)playLevel8;
- (void)playLevel9;
- (void)playLevel10;
- (void)playLevel11;
- (void)playLevel12;
- (void)playLevel13;
- (void)playLevel14;
- (void)playLevel15;
- (void)playLevel16;
- (void)playLevel17;
- (void)playLevel18;
- (void)playLevel19;
- (void)playLevel20;
- (void)playLevel21;
- (void)playLevel22;


@end
