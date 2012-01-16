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
    
    CGPoint currentPlayerPosition;
    CGPoint currentExitPosition;
    NSString *currentMap;
    
    int currentTile;
    CGPoint centerOn;
}

- (id)initWithLevel:(NSString *)level custom:(BOOL)custom;
- (id)initWithWidth:(int)width height:(int)height;

@property (nonatomic, retain) TileMap *map;
@property (nonatomic, retain) EditorInputLayer *inputLayer;
@property (nonatomic, retain) NSString *currentMap;
@property CGPoint currentPlayerPosition;
@property CGPoint currentExitPosition;
@property int currentTile;

- (void)didTapOnTile:(CGPoint)tile;
- (void)addDifferenceToCenterOn:(CGPoint)difference;
- (void)centerMap;

- (void)promptSave;
- (void)saveWithFileName:(NSString *)fileName;

@end
