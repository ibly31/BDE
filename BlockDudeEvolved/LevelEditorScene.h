//
//  LevelEditorScene.h
//  BlockDudeEvolved
//
//  Created by Billy Connolly on 12/23/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "CCScene.h"
#import "TileMap.h"
#import "EditorInputLayer.h"

@interface LevelEditorScene : CCScene{
    TileMap *map;
    EditorInputLayer *inputLayer;
    
    int currentTile;
    CGPoint centerOn;
}

- (id)initWithLevel:(int)level;

@property (nonatomic, retain) TileMap *map;
@property (nonatomic, retain) EditorInputLayer *inputLayer;
@property int currentTile;

- (void)didTapOnTile:(CGPoint)tile;

- (void)addDifferenceToCenterOn:(CGPoint)difference;

@end
