//
//  ChooseLevelScene.m
//  BlockDudeEvolved
//
//  Created by Billy Connolly on 12/10/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ChooseLevelScene.h"
#import "GameScene.h"
#import "AppDelegate.h"
#import "LevelSelectViewController.h"
#import "RootViewController.h"
#import "LevelEditorScene.h"
#import "SaveLevelViewController.h"

@implementation ChooseLevelScene
@synthesize levelEditorMode;
@synthesize nextPopWillNotBeMenu;

- (id)initWithLevelEditorMode:(BOOL)lem{
    self = [super init];
    if(self){
        self.levelEditorMode = lem;
        self.nextPopWillNotBeMenu = NO;
        
        CCLayerColor *lc = [[CCLayerColor alloc] initWithColor:ccc4(125, 125, 125, 255) width:480 height:320];
        [self addChild: lc];
        [lc release];
        
        AppDelegate *del = [[UIApplication sharedApplication] delegate];
        UINavigationController *navController = [del navController];
        [navController setDelegate: self];
        
        LevelSelectViewController *lsvc = [[LevelSelectViewController alloc] initWithChooseLevelScene:self];
        [navController pushViewController:lsvc animated:YES];
        [lsvc release];
    }
    return self;
}

- (void)didSelectLevel:(NSString *)level custom:(BOOL)custom{
    if(levelEditorMode){
        if([level compare:@"Level 0"] == NSOrderedSame){
            [self toMenu];
        }else{
            [self editLevel: level custom:custom];
        }
    }else{
        if([level compare:@"Level 0"] == NSOrderedSame){
            [self toMenu];
        }else{
            [self playLevel: level custom:custom];
        }
    }
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if([viewController class] == [RootViewController class]){
        if(nextPopWillNotBeMenu){
            nextPopWillNotBeMenu = NO;  // reset the flag or decrement
        }else{
            [self toMenu];
        }
        [navigationController setNavigationBarHidden:YES animated:YES];
    }
}

- (void)toMenu{    
    [[CCDirector sharedDirector] popSceneWithTransition:[CCTransitionFade class] duration:0.5f];
}

- (void)createWithWidth:(int)width height:(int)height{
    LevelEditorScene *les = [[LevelEditorScene alloc] initWithWidth:width height:height];
    [[CCDirector sharedDirector] pushScene: [CCTransitionFade transitionWithDuration:0.5f scene:les]];
    [les release];
    self.nextPopWillNotBeMenu = YES;
}

- (void)addNew{
    AppDelegate *del = [[UIApplication sharedApplication] delegate];
    UINavigationController *navController = [del navController];
    SaveLevelViewController *slvc = [[SaveLevelViewController alloc] initWithNibName:@"SaveLevelViewController" chooseLevelScene:self];
    [navController pushViewController:slvc animated:YES];
    [slvc release];
}

- (void)playLevel:(NSString *)level custom:(BOOL)custom{
    GameScene *gs = [[GameScene alloc] initWithLevel: level custom:custom testingLevel:NO];
    [[CCDirector sharedDirector] pushScene: gs];//[CCTransitionFade transitionWithDuration:0.5f scene:gs]];
    [gs release];
    self.nextPopWillNotBeMenu = YES;  // since there is no way to tell that the pop will be a "back" button (upper left
                                 // of the nav controller) I have to flag the ones that AREN'T menu pops.
}

- (void)editLevel:(NSString *)level custom:(BOOL)custom{
    LevelEditorScene *les = [[LevelEditorScene alloc] initWithLevel: level custom:custom];
    [[CCDirector sharedDirector] pushScene: [CCTransitionFade transitionWithDuration:0.5f scene:les]];
    [les release];
    self.nextPopWillNotBeMenu = YES;  // same thing for leveleditorscene too
}

@end
