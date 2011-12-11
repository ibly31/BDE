//
//  MainMenuScene.h
//  BlockDudeEvolved
//
//  Created by Billy Connolly on 12/10/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"

@interface MainMenuScene : CCScene{
    CCMenu *menu;
}

@property (nonatomic, retain) CCMenu *menu;

- (void)playGame;
- (void)options;

@end
