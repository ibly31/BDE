//
//  LevelEditorScene.m
//  BlockDudeEvolved
//
//  Created by Billy Connolly on 12/23/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "LevelEditorScene.h"
#import "SaveLevelViewController.h"
#import "AppDelegate.h"
#import "RootViewController.h"

@implementation LevelEditorScene
@synthesize map;
@synthesize inputLayer;
@synthesize currentPlayerPosition;
@synthesize currentMap;
@synthesize currentExitPosition;
@synthesize currentTile;

- (id)initWithLevel:(NSString *)level custom:(BOOL)custom{
    self = [super init];
    if(self){
        self.currentTile = 0;
        self.currentMap = level;
        
        CCLayerColor *backgroundColor = [[CCLayerColor alloc] initWithColor:ccc4(153, 153, 153, 255) width:480 height:320];
        [self addChild: backgroundColor];
        
        self.map = [[TileMap alloc] init];
        [self addChild: map];
        [map loadMapWithString:level custom:custom];
        
        CGSize mapSize = [map mapSize];
        centerOn = ccp(mapSize.width / 2.0f, mapSize.height / 2.0f);
        [map setOffsetToCenterOn:centerOn animated:NO];
        [map toggleOutlines];
        
        self.inputLayer = [[EditorInputLayer alloc] init];
        [self addChild: inputLayer];
    }
    return self;
}

- (id)initWithWidth:(int)width height:(int)height{
    self = [super init];
    if(self){
        self.currentTile = 0;
        self.currentMap = @"";
        
        CCLayerColor *backgroundColor = [[CCLayerColor alloc] initWithColor:ccc4(153, 153, 153, 255) width:480 height:320];
        [self addChild: backgroundColor];
        
        self.map = [[TileMap alloc] init];
        [self addChild: map];
        [map createMapWithWidth:width height:height];
        
        CGSize mapSize = CGSizeMake(width, height);
        centerOn = ccp(mapSize.width / 2.0f, mapSize.height / 2.0f);
        [map setOffsetToCenterOn:centerOn animated:NO];
        [map toggleOutlines];
        
        self.inputLayer = [[EditorInputLayer alloc] init];
        [self addChild: inputLayer];
    }
    return self;
}

- (void)saveWithFileName:(NSString *)fileName{
    NSLog(@"File name: %@", fileName);
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [NSString stringWithFormat:@"%@/%@", (NSString *)[paths objectAtIndex:0], fileName];
    NSString *data = [map dataString];
    [data writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:nil];
}

- (void)promptSave{
    CGPoint count = [map countPlayerAndExits];
    if(count.x != 1){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"You have not placed a player spawn location." delegate:self cancelButtonTitle:@"Okay" otherButtonTitles: nil];
        [alert show];
        [alert release];
    }else if(count.y != 1){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"You have not placed an exit." delegate:self cancelButtonTitle:@"Okay" otherButtonTitles: nil];
        [alert show];
        [alert release];
    }else{
        AppDelegate *del = [[UIApplication sharedApplication] delegate];
        RootViewController *rvc = [del viewController];
        SaveLevelViewController *slvc = [[SaveLevelViewController alloc] initWithNibName:@"SaveLevelViewController" rootViewController:rvc levelEditorScene:self];
        slvc.fileNameSuggest = currentMap;      
        [rvc presentViewController:slvc animated:YES completion:^(void){}];
    }
}

- (void)didTapOnTile:(CGPoint)tile{
    if(currentTile == 3){
        if([map tileAtX:currentPlayerPosition.x Y:currentPlayerPosition.y] == 3)
            [map setTileAtX:currentPlayerPosition.x Y:currentPlayerPosition.y value:0];
        [map setTileAtX:tile.x Y:tile.y value:3];
        currentPlayerPosition = tile;
    }else if(currentTile == 4){
        if([map tileAtX:currentPlayerPosition.x Y:currentPlayerPosition.y] == 4)
            [map setTileAtX:currentExitPosition.x Y:currentExitPosition.y value:0];
        [map setTileAtX:tile.x Y:tile.y value:4];
        currentExitPosition = tile;
    }else{
        [map setTileAtX:tile.x Y:tile.y value:currentTile];
    }
}

- (void)addDifferenceToCenterOn:(CGPoint)difference{
    difference = ccpMult(difference, 1.0f/32.0f);
    difference.x = -difference.x;
    centerOn = ccpAdd(centerOn, difference);
    [map setOffsetToCenterOn: centerOn animated:NO];
}

@end
