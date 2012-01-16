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
    
    BOOL animate;
}

@property int mapWidth;
@property int mapHeight;

- (id)init;
- (void)loadMapWithString:(NSString *)mapName custom:(BOOL)custom;
- (void)createMapWithWidth:(int)width height:(int)height;

- (NSString *)dataString;

- (void)toggleOutlines;
- (void)levelEditAnimation:(BOOL)which;

- (void)setOffsetToCenterOn:(CGPoint)centerOn;
- (void)setOffsetToCenterOn:(CGPoint)centerOn animated:(BOOL)animated;

- (void)setTileAtX:(int)x Y:(int)y value:(int)value;
- (int)tileAtX:(int)x Y:(int)y;
- (CGPoint)whichTile:(CGPoint)touchLocation;
- (CGPoint)countPlayerAndExits;

- (CGSize)mapSize;

@end
