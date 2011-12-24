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
    BOOL levelEditorMode;
}

- (id)initWithLevelEditorMode:(BOOL)lem;

@property BOOL levelEditorMode;

- (void)didSelectLevel:(int)level;
- (void)toMenu;

- (void)playLevel:(int)level;
- (void)editLevel:(int)level;

@end
