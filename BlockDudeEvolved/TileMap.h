//
//  TileMap.h
//  BlockDudeEvolved
//
//  Created by Billy Connolly on 12/6/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"

@class GameScene;

@interface TileMap : CCSpriteBatchNode{
    int mapWidth;
    int mapHeight;
}

@property int mapWidth;
@property int mapHeight;

- (id)initWithMap:(NSString *)map gameScene:(GameScene *)gs;

- (void)setOffsetToCenterOn:(CGPoint)centerOn;
- (void)setOffsetToCenterOn:(CGPoint)centerOn animated:(BOOL)animated;

- (void)setTileAtX:(int)x Y:(int)y value:(int)value;
- (int)tileAtX:(int)x Y:(int)y;

@end
