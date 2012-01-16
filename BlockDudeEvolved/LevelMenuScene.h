//
//  LevelMenuScene.h
//  BlockDudeEvolved
//
//  Created by Billy Connolly on 12/24/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"

@class LevelEditorScene;

@interface LevelMenuScene : CCScene{
    CCLabelTTF *pauseLabel;
    CCMenu *menu;

    LevelEditorScene *lesUpper;

}

- (id)initWithLevelEditorScene:(LevelEditorScene *)les;

@property (nonatomic, retain) CCLabelTTF *pauseLabel;
@property (nonatomic, retain) CCMenu *menu;
@property (nonatomic, retain) LevelEditorScene *lesUpper;

- (void)returnToEditor;
- (void)saveLevel;
- (void)exitGame;

@end
