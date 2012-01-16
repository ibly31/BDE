//
//  MainMenuScene.h
//  BlockDudeEvolved
//
//  Created by Billy Connolly on 12/10/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"
#import <GameKit/GameKit.h>

@interface MainMenuScene : CCScene{
    CCLabelTTF *titleLabel;
    CCMenu *menu;
}

@property (nonatomic, retain) CCLabelTTF *titleLabel;
@property (nonatomic, retain) CCMenu *menu;

- (void)selectLevel;
- (void)editLevel;
- (void)options;
- (void)toLeaderboards;
- (void)toAchievements;

@end
