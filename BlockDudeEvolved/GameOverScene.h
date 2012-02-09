//
//  GameOverScene.h
//  BlockDudeEvolved
//
//  Created by Billy Connolly on 12/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"
#import <GameKit/GameKit.h>

@interface GameOverScene : CCScene{
    CCLabelTTF *movesLabel;
    CCLabelTTF *timeTakenLabel;
    
    NSTimeInterval timeScore;
    NSString *levelString;
    int movesScore;
    BOOL levelCustom;
    
    CCMenu *menu;
}

@property (nonatomic, retain) CCLabelTTF *movesLabel;
@property (nonatomic, retain) CCLabelTTF *timeTakenLabel;

@property (nonatomic, retain) CCMenu *menu;

- (id)initWithMoves:(int)moves timeTaken:(NSTimeInterval)time level:(NSString *)level custom:(BOOL)custom;

- (void)toMenu;
- (void)toReplay;
- (void)toAchievements;
- (void)toLeaderboards;

@end