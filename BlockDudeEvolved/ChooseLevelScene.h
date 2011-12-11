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

- (void)playLevel:(NSString *)level;
- (void)playLevel1;
- (void)playLevel2;
- (void)playLevel3;
- (void)playLevel4;
- (void)playLevel5;
- (void)playLevel6;


@end
