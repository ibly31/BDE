//
//  LevelEditorScene.m
//  BlockDudeEvolved
//
//  Created by Billy Connolly on 12/23/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "LevelEditorScene.h"

@implementation LevelEditorScene
@synthesize map;
@synthesize inputLayer;
@synthesize currentTile;

- (id)initWithLevel:(int)level{
    self = [super init];
    if(self){
        self.currentTile = 0;
        
        self.map = [[TileMap alloc] init];
        [self addChild: map];
        [map loadMap: level];
        
        CGSize mapSize = [map mapSize];
        centerOn = ccp(mapSize.width / 2.0f, mapSize.height / 2.0f);
        [map setOffsetToCenterOn:centerOn animated:NO];
        [map toggleOutlines];
        
        self.inputLayer = [[EditorInputLayer alloc] init];
        [self addChild: inputLayer];
    }
    return self;
}

- (void)didTapOnTile:(CGPoint)tile{
    [map setTileAtX:tile.x Y:tile.y value:currentTile];
}

- (void)addDifferenceToCenterOn:(CGPoint)difference{
    difference = ccpMult(difference, 1.0f/32.0f);
    difference.x = -difference.x;
    centerOn = ccpAdd(centerOn, difference);
    [map setOffsetToCenterOn: centerOn animated:NO];
}

@end
