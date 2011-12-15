//
//  GameOverScene.h
//  BlockDudeEvolved
//
//  Created by Billy Connolly on 12/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"
#import <GameKit/GameKit.h>

@interface GameOverScene : CCScene <GKLeaderboardViewControllerDelegate, GKAchievementViewControllerDelegate>{
    CCLabelTTF *movesLabel;
    CCLabelTTF *timeTakenLabel;
    
    NSTimeInterval timeScore;
    int movesScore;
    
    CCMenu *menu;
}

@property (nonatomic, retain) CCLabelTTF *movesLabel;
@property (nonatomic, retain) CCLabelTTF *timeTakenLabel;

@property (nonatomic, retain) CCMenu *menu;

- (id)initWithMoves:(int)moves timeTaken:(NSTimeInterval)time levelNumber:(int)level;

- (void)toMenu;
- (void)toAchievements;
- (void)toLeaderboards;

@end