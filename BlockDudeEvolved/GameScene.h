//
//  GameScene.h
//  BlockDudeEvolved
//
//  Created by Billy Connolly on 12/6/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"
#import "TileMap.h"

@interface GameScene : CCScene{
    TileMap *map;
    CCLayer *inputLayer;
    
    int moves;
    NSTimeInterval startInterval;
    NSTimeInterval discountInterval;
    
    CCLabelAtlas *timeLabel;
    
    CCSprite *player;
    CCSprite *carryingBlock;
    
    NSString *currentLevel;
    BOOL currentCustom;
    
    BOOL facingLeft;
    
    int fallAttempts;
    CGPoint currentBlockFall;

    int playerX,playerY;
    
    BOOL testingLevel;
}

- (id)initWithLevel:(NSString *)level custom:(BOOL)custom testingLevel:(BOOL)testing;

@property (nonatomic, retain) TileMap *map;
@property (nonatomic, retain) CCLayer *inputLayer;

@property (nonatomic, retain) CCLabelAtlas *timeLabel;

@property (nonatomic, retain) CCSprite *player;
@property (nonatomic, retain) CCSprite *carryingBlock;
@property (nonatomic, retain) NSString *currentLevel;
@property BOOL currentCustom;
@property BOOL testingLevel;
@property int playerX,playerY;

- (void)updateTimeLabel;
- (void)updateMoveLabel;

- (void)winGame;

- (void)moveInDirection:(int)direction;

- (void)fall;
- (BOOL)attemptFall;

- (void)blockFall:(CGPoint)block;
- (BOOL)blockAttemptFall;

@end
