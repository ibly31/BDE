//
//  MainMenuScene.m
//  BlockDudeEvolved
//
//  Created by Billy Connolly on 12/10/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "MainMenuScene.h"
#import "ChooseLevelScene.h"
#import "OptionsScene.h"
#import "RootViewController.h"
#import "AppDelegate.h"

@implementation MainMenuScene
@synthesize titleLabel;
@synthesize menu;

- (id)init{
    self = [super init];
    if(self){
        self.titleLabel = [[CCLabelTTF alloc] initWithString:@"Block Dude Evolved" fontName:@"Krungthep" fontSize:36];
        [titleLabel setPosition: ccp(240, 280)];
        [self addChild: titleLabel];
        
        CCLabelTTF *selectLevel = [[CCLabelTTF alloc] initWithString:@"Select Level" fontName:@"Krungthep" fontSize:28];
        CCMenuItemLabel *selectLevelLabel = [[CCMenuItemLabel alloc] initWithLabel:selectLevel target:self selector:@selector(selectLevel)];
        [selectLevelLabel setPosition: ccp(250, 160)];
        
        CCLabelTTF *options = [[CCLabelTTF alloc] initWithString:@"Options" fontName:@"Krungthep" fontSize:28];
        CCMenuItemLabel *optionsLabel = [[CCMenuItemLabel alloc] initWithLabel:options target:self selector:@selector(options)];
        [optionsLabel setPosition: ccp(250, 102)];
        
        CCLabelTTF *editLevel = [[CCLabelTTF alloc] initWithString:@"Level Editor" fontName:@"Krungthep" fontSize:28];
        CCMenuItemLabel *editLevelLabel = [[CCMenuItemLabel alloc] initWithLabel:editLevel target:self selector:@selector(editLevel)];
        [editLevelLabel setPosition: ccp(250, 44)];
        
        CCSprite *leaderboardSprite = [[CCSprite alloc] initWithFile:@"Buttons.png" rect:CGRectMake(48, 0, 48, 48)];
        CCMenuItemSprite *leaderboardItem = [CCMenuItemSprite itemFromNormalSprite:leaderboardSprite selectedSprite:nil target:self selector:@selector(toLeaderboards)];
        [leaderboardItem setPosition: ccp(32, 192)];
        
        CCSprite *achievementSprite = [[CCSprite alloc] initWithFile:@"Buttons.png" rect:CGRectMake(96, 0, 48, 48)];
        CCMenuItemSprite *achievementItem = [CCMenuItemSprite itemFromNormalSprite:achievementSprite selectedSprite:nil target:self selector:@selector(toAchievements)];
        [achievementItem setPosition: ccp(32, 128)];
                
        self.menu = [CCMenu menuWithItems:selectLevelLabel, optionsLabel, editLevelLabel, leaderboardItem, achievementItem, nil];
        [menu setPosition: ccp(0, 0)];
        [self addChild: menu];
        [selectLevel release];
        [selectLevelLabel release];
        [editLevel release];
        [editLevelLabel release];
        [options release];
        [optionsLabel release];
    }
    return self;
}

- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex{
    if(buttonIndex == 1){
        
    }else{
        ChooseLevelScene *cls = [[ChooseLevelScene alloc] initWithLevelEditorMode: YES];
        [[CCDirector sharedDirector] pushScene: [CCTransitionFade transitionWithDuration:0.5f scene:cls]];
        [cls release];
    }
}

- (void)selectLevel{
    ChooseLevelScene *cls = [[ChooseLevelScene alloc] initWithLevelEditorMode: NO];
    [[CCDirector sharedDirector] pushScene: [CCTransitionFade transitionWithDuration:0.5f scene:cls]];
    [cls release];
}

- (void)editLevel{
    if([[NSUserDefaults standardUserDefaults] objectForKey:@"FirstEdit"] == nil){
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"FirstEdit"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Create New or Edit" message:@"" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Create New", @"Edit Existing", nil];
        [alert show];
        [alert release];
    }
}

- (void)options{
    OptionsScene *os = [[OptionsScene alloc] init];
    [[CCDirector sharedDirector] pushScene: [CCTransitionFade transitionWithDuration:0.5f scene:os]];
    [os release];
}

- (void)toAchievements{
    AppDelegate *del = [[UIApplication sharedApplication] delegate];
    [[del gameCenterModel] openAchievementViewer];
}

- (void)toLeaderboards{
    AppDelegate *del = [[UIApplication sharedApplication] delegate];
    [[del gameCenterModel] openLeaderboardViewer];
}
@end
