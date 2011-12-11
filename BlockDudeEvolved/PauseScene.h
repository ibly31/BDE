//
//  PauseScene.h
//  BlockDudeEvolved
//
//  Created by Billy Connolly on 12/10/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"

@interface PauseScene : CCScene{
    CCLabelTTF *pauseLabel;
    CCMenu *menu;
}

- (void)returnToGame;
- (void)options;
- (void)exitGame;

@property (nonatomic, retain) CCLabelTTF *pauseLabel;
@property (nonatomic, retain) CCMenu *menu;

@end
