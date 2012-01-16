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
#import "LevelEditorScene.h"
#import "SaveLevelViewController.h"
#import "InstructionsScene.h"

@implementation MainMenuScene
@synthesize titleLabel;
@synthesize menu;

- (id)init{
    self = [super init];
    if(self){
        self.titleLabel = [[CCLabelTTF alloc] initWithString:@"Block Dude Evolved" fontName:@"Krungthep" fontSize:36];
        [titleLabel setPosition: ccp(240, 280)];
        [self addChild: titleLabel];
        
        CCLabelTTF *selectLevel = [[CCLabelTTF alloc] initWithString:@"Play Level" fontName:@"Krungthep" fontSize:28];
        CCMenuItemLabel *selectLevelLabel = [[CCMenuItemLabel alloc] initWithLabel:selectLevel target:self selector:@selector(selectLevel)];
        [selectLevelLabel setPosition: ccp(250, 188)];
        
        CCLabelTTF *options = [[CCLabelTTF alloc] initWithString:@"Options" fontName:@"Krungthep" fontSize:28];
        CCMenuItemLabel *optionsLabel = [[CCMenuItemLabel alloc] initWithLabel:options target:self selector:@selector(options)];
        [optionsLabel setPosition: ccp(250, 140)];
        
        CCLabelTTF *editLevel = [[CCLabelTTF alloc] initWithString:@"Level Editor" fontName:@"Krungthep" fontSize:28];
        CCMenuItemLabel *editLevelLabel = [[CCMenuItemLabel alloc] initWithLabel:editLevel target:self selector:@selector(editLevel)];
        [editLevelLabel setPosition: ccp(250, 92)];
        
        CCLabelTTF *instructions = [[CCLabelTTF alloc] initWithString:@"Instructions" fontName:@"Krungthep" fontSize:28];
        CCMenuItemLabel *instructionsLabel = [[CCMenuItemLabel alloc] initWithLabel:instructions target:self selector:@selector(instructions)];
        [instructionsLabel setPosition: ccp(250, 44)];
        
        /*CCSprite *leaderboardSprite = [[CCSprite alloc] initWithFile:@"Buttons.png" rect:CGRectMake(48, 0, 48, 48)];
        CCMenuItemSprite *leaderboardItem = [CCMenuItemSprite itemFromNormalSprite:leaderboardSprite selectedSprite:nil target:self selector:@selector(toLeaderboards)];
        [leaderboardItem setPosition: ccp(32, 192)];*/
        
        CCSprite *achievementSprite = [[CCSprite alloc] initWithFile:@"Buttons.png" rect:CGRectMake(96, 0, 48, 48)];
        CCMenuItemSprite *achievementItem = [CCMenuItemSprite itemFromNormalSprite:achievementSprite selectedSprite:nil target:self selector:@selector(toAchievements)];
        [achievementItem setPosition: ccp(32, 128)]; // 32, 128
                
        self.menu = [CCMenu menuWithItems:selectLevelLabel, optionsLabel, editLevelLabel, instructionsLabel, achievementItem, nil];
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

- (void)selectLevel{
    ChooseLevelScene *cls = [[ChooseLevelScene alloc] initWithLevelEditorMode: NO];
    [[CCDirector sharedDirector] pushScene: [CCTransitionFade transitionWithDuration:0.5f scene:cls]];
    [cls release];
}

- (void)editLevel{
    ChooseLevelScene *cls = [[ChooseLevelScene alloc] initWithLevelEditorMode: YES];
    [[CCDirector sharedDirector] pushScene: [CCTransitionFade transitionWithDuration:0.5f scene:cls]];
    [cls release];
}

- (void)options{
    OptionsScene *os = [[OptionsScene alloc] init];
    [[CCDirector sharedDirector] pushScene: [CCTransitionFade transitionWithDuration:0.5f scene:os]];
    [os release];
}

- (void)instructions{
    InstructionsScene *is = [[InstructionsScene alloc] init];
    [[CCDirector sharedDirector] pushScene: [CCTransitionFade transitionWithDuration:0.5f scene:is]];
    [is release];
}

- (void)toAchievements{
    AppDelegate *del = [[UIApplication sharedApplication] delegate];
    [[del gameCenterModel] openAchievementViewer];
}

- (void)toLeaderboards{
    AppDelegate *del = [[UIApplication sharedApplication] delegate];
    [[del gameCenterModel] openLeaderboardViewer];
}

/*
 NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
 NSArray *files = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:(NSString *)[paths objectAtIndex:0] error:nil];
 int numberOfCustoms = 0;
 
 for(int x = 0; x < [files count]; x++){
 NSString *file = [files objectAtIndex: x];
 if([file length] >= 5){
 NSString *sub = [file substringFromIndex: [file length] - 4];
 if([sub compare: @".txt"] == NSOrderedSame){
 numberOfCustoms++;
 }
 }
 }
 
 if(numberOfCustoms != 0){
 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Create New or Edit" message:@"" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Create New", @"Edit Existing", nil];
 [alert show];
 [alert release];
 }else{
 
 }
 */


@end
