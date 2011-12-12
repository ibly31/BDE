//
//  GameScene.h
//  BlockDudeEvolved
//
//  Created by Billy Connolly on 12/6/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"
#import "TileMap.h"
#import "InputLayer.h"

@interface GameScene : CCScene{
    TileMap *map;
    InputLayer *inputLayer;
    
    int moves;
    NSTimeInterval startInterval;
    
    CCSprite *player;
    CCSprite *carryingBlock;
    
    NSString *currentLevel;
    
    BOOL facingLeft;
    
    int fallAttempts;
    CGPoint currentBlockFall;

    int playerX,playerY;
}

- (id)initWithLevel:(NSString *)level;

@property (nonatomic, retain) TileMap *map;
@property (nonatomic, retain) InputLayer *inputLayer;

@property (nonatomic, retain) CCSprite *player;
@property (nonatomic, retain) CCSprite *carryingBlock;
@property (nonatomic, retain) NSString *currentLevel;
@property int playerX,playerY;

- (void)winGame;

- (void)moveInDirection:(int)direction;

- (void)fall;
- (void)attemptFall;

- (void)blockFall:(CGPoint)block;
- (void)blockAttemptFall;

@end
