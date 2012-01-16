//
//  EditorInputLayer.m
//  BlockDudeEvolved
//
//  Created by Billy Connolly on 12/23/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "EditorInputLayer.h"
#import "LevelEditorScene.h"
#import "LevelMenuScene.h"

@implementation EditorInputLayer
@synthesize chooseTileMenu;
@synthesize panOrDraw;

- (id)init{
    self = [super init];
    if(self){
        self.isTouchEnabled = YES;
        previousDragLocation = ccp(0,0);
        touchStartLocation = ccp(0,0);
        
        CCSprite *menuButton = [[CCSprite alloc] initWithFile:@"Gui.png" rect:CGRectMake(320, 192, 64, 32)];
        [menuButton setPosition: ccp(240, 304)];
        [self addChild: menuButton];
        
        CCSprite *selectorBackground = [[CCSprite alloc] initWithFile:@"Gui.png" rect:CGRectMake(0, 256, 288, 44)];
        [selectorBackground setPosition: ccp(240, 32)];
        [self addChild: selectorBackground];
        
        CCSprite *blank = [[CCSprite alloc] initWithFile:@"Original.png" rect:CGRectMake(0, 0, 32, 32)];
        CCMenuItemSprite *blankItem = [CCMenuItemSprite itemFromNormalSprite:blank selectedSprite:nil block:^(id sender){
            [(LevelEditorScene *)parent_ setCurrentTile: 0];
        }];
        [blankItem setPosition: ccp(160, 32)];
        
        CCSprite *brick = [[CCSprite alloc] initWithFile:@"Original.png" rect:CGRectMake(32, 0, 32, 32)];
        CCMenuItemSprite *brickItem = [CCMenuItemSprite itemFromNormalSprite:brick selectedSprite:nil block:^(id sender){
            [(LevelEditorScene *)parent_ setCurrentTile: 1];
        }];
        [brickItem setPosition: ccp(200, 32)];
        
        CCSprite *block = [[CCSprite alloc] initWithFile:@"Original.png" rect:CGRectMake(64, 0, 32, 32)];
        CCMenuItemSprite *blockItem = [CCMenuItemSprite itemFromNormalSprite:block selectedSprite:nil block:^(id sender){
            [(LevelEditorScene *)parent_ setCurrentTile: 2];
        }];
        [blockItem setPosition: ccp(240, 32)];
        
        CCSprite *player = [[CCSprite alloc] initWithFile:@"Original.png" rect:CGRectMake(96, 0, 32, 32)];
        CCMenuItemSprite *playerItem = [CCMenuItemSprite itemFromNormalSprite:player selectedSprite:nil block:^(id sender){
            [(LevelEditorScene *)parent_ setCurrentTile: 3];
        }];
        [playerItem setPosition: ccp(280, 32)];
        
        CCSprite *door = [[CCSprite alloc] initWithFile:@"Original.png" rect:CGRectMake(128, 0, 32, 32)];
        CCMenuItemSprite *doorItem = [CCMenuItemSprite itemFromNormalSprite:door selectedSprite:nil block:^(id sender){
            [(LevelEditorScene *)parent_ setCurrentTile: 4];
        }];
        [doorItem setPosition: ccp(320, 32)];
        
        panMode = YES;
        
        self.panOrDraw = [[CCSprite alloc] initWithFile:@"Gui.png" rect:CGRectMake(288, 256, 32, 32)];
        CCMenuItemSprite *panOrDrawItem = [CCMenuItemSprite itemFromNormalSprite:panOrDraw selectedSprite:nil block:^(id sender){
            if(panMode){
                panMode = NO;
                [panOrDraw setDisplayFrame: [CCSpriteFrame frameWithTexture:[panOrDraw texture] rect:CGRectMake(320, 256, 32, 32)]];
            }else{
                panMode = YES;
                [panOrDraw setDisplayFrame: [CCSpriteFrame frameWithTexture:[panOrDraw texture] rect:CGRectMake(288, 256, 32, 32)]];
            }
        }];
        [panOrDrawItem setPosition: ccp(118,32)];
        
        CCSprite *centerView = [[CCSprite alloc] initWithFile:@"Gui.png" rect:CGRectMake(352, 256, 32, 32)];
        CCMenuItemSprite *centerViewItem = [CCMenuItemSprite itemFromNormalSprite:centerView selectedSprite:nil block:^(id sender){
            [(LevelEditorScene *)parent_ centerMap];
        }];
        [centerViewItem setPosition: ccp(362, 32)];
        
        self.chooseTileMenu = [CCMenu menuWithItems:blankItem, brickItem, blockItem, playerItem, doorItem, panOrDrawItem, centerViewItem, nil];
        [chooseTileMenu setPosition: ccp(0,0)];
        [self addChild: chooseTileMenu];
    }
    return self;
}

- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint location = [[CCDirector sharedDirector] convertToGL: [touch locationInView: touch.view]];
    
    if(fabsf(location.x - 240) < 40 && fabsf(location.y - 298) < 20){
        LevelMenuScene *lms = [[LevelMenuScene alloc] initWithLevelEditorScene: (LevelEditorScene *)parent_];
        [[CCDirector sharedDirector] pushScene: [CCTransitionFade transitionWithDuration:0.5f scene:lms]];
        [lms release];
    }else{
        if(panMode){
            previousDragLocation = location;
            touchStartLocation = location;
        }else{
            CGPoint touchEndTile = [[(LevelEditorScene *)parent_ map] whichTile: location];
            if(touchEndTile.x != -1 && touchEndTile.y != -1){
                [(LevelEditorScene *)parent_ didTapOnTile: touchEndTile];
            }
        }
    }
    
}

- (void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint location = [[CCDirector sharedDirector] convertToGL: [touch locationInView: touch.view]];
    
    if(panMode){
        if(ccpDistance(location, touchStartLocation) >= 8.0f){
            CGPoint difference = ccp(location.x - previousDragLocation.x, location.y - previousDragLocation.y);
            [(LevelEditorScene *)parent_ addDifferenceToCenterOn: difference];
        }
        previousDragLocation = location;
    }else{
        CGPoint touchEndTile = [[(LevelEditorScene *)parent_ map] whichTile: location];
        if(touchEndTile.x != -1 && touchEndTile.y != -1){
            [(LevelEditorScene *)parent_ didTapOnTile: touchEndTile];
        }
    }

}

- (void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint location = [[CCDirector sharedDirector] convertToGL: [touch locationInView: touch.view]];
    
    if(panMode){
        if(ccpDistance(location, touchStartLocation) < 8.0f){
            CGPoint touchEndTile = [[(LevelEditorScene *)parent_ map] whichTile: location];
            if(touchEndTile.x != -1 && touchEndTile.y != -1){
                [(LevelEditorScene *)parent_ didTapOnTile: touchEndTile];
            }
        }
    }
}

@end
