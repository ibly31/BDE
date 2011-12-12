//
//  PauseScene.h
//  BlockDudeEvolved
//
//  Created by Billy Connolly on 12/10/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"

@class GameScene;

@interface PauseScene : CCScene{
    CCLabelTTF *pauseLabel;
    CCMenu *menu;
    
    GameScene *gsUpper;
}

- (id)initWithGameScene:(GameScene *)gs;

@property (nonatomic, retain) CCLabelTTF *pauseLabel;
@property (nonatomic, retain) CCMenu *menu;
@property (nonatomic, retain) GameScene *gsUpper;

- (void)returnToGame;
- (void)restartLevel;
- (void)options;
- (void)exitGame;

@end
