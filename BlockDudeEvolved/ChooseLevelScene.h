//
//  ChooseLevelScene.h
//  BlockDudeEvolved
//
//  Created by Billy Connolly on 12/10/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"
#import <UIKit/UIKit.h>

@interface ChooseLevelScene : CCScene <UINavigationControllerDelegate>{
    BOOL levelEditorMode;
    
    BOOL nextPopWillNotBeMenu;
}

- (id)initWithLevelEditorMode:(BOOL)lem;

@property BOOL levelEditorMode;
@property BOOL nextPopWillNotBeMenu;

- (void)didSelectLevel:(NSString *)level custom:(BOOL)custom;
- (void)toMenu;

- (void)playLevel:(NSString *)level custom:(BOOL)custom;
- (void)editLevel:(NSString *)level custom:(BOOL)custom;
- (void)addNew;
- (void)createWithWidth:(int)width height:(int)height;

@end
