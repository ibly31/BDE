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

@implementation ChooseLevelScene
@synthesize levelEditorMode;

- (id)initWithLevelEditorMode:(BOOL)lem{
    self = [super init];
    if(self){
        self.levelEditorMode = lem;
        
        AppDelegate *del = [[UIApplication sharedApplication] delegate];
        RootViewController *rvc = [del viewController];
        
        LevelSelectViewController *lsvc = [[LevelSelectViewController alloc] initWithRVC:rvc chooseLevelScene:self];
        [rvc presentViewController:lsvc animated:YES completion:^(void){
            //[[CCDirector sharedDirector] pause];
        }];
    }
    return self;
}

- (void)didSelectLevel:(int)level{
    if(levelEditorMode){
        if(level == 0){
            [self toMenu];
        }else{
            [self editLevel: level];
        }
    }else{
        if(level == 0){
            [self toMenu];
        }else{
            [self playLevel: level];
        }
    }
}

- (void)toMenu{
    [[CCDirector sharedDirector] popSceneWithTransition:[CCTransitionFade class] duration:0.5f];
}

- (void)playLevel:(int)level{
    GameScene *gs = [[GameScene alloc] initWithLevel: level];
    [[CCDirector sharedDirector] pushScene: [CCTransitionFade transitionWithDuration:0.5f scene:gs]];
    [gs release];
}

- (void)editLevel:(int)level{
    LevelEditorScene *les = [[LevelEditorScene alloc] initWithLevel: level];
    [[CCDirector sharedDirector] pushScene: [CCTransitionFade transitionWithDuration:0.5f scene:les]];
    [les release];
}

@end
