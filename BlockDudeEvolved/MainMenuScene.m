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
#import "LevelBrowserViewController.h"
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
        [selectLevelLabel setPosition: ccp(250, 200)];
        
        CCLabelTTF *editLevel = [[CCLabelTTF alloc] initWithString:@"Level Editor" fontName:@"Krungthep" fontSize:28];
        CCMenuItemLabel *editLevelLabel = [[CCMenuItemLabel alloc] initWithLabel:editLevel target:self selector:@selector(editLevel)];
        [editLevelLabel setPosition: ccp(250, 160)];
        
        CCLabelTTF *options = [[CCLabelTTF alloc] initWithString:@"Options" fontName:@"Krungthep" fontSize:28];
        CCMenuItemLabel *optionsLabel = [[CCMenuItemLabel alloc] initWithLabel:options target:self selector:@selector(options)];
        [optionsLabel setPosition: ccp(250, 120)];
        
        CCLabelTTF *levelBrowser = [[CCLabelTTF alloc] initWithString:@"Share Levels" fontName:@"Krungthep" fontSize:28];
        CCMenuItemLabel *levelBrowserLabel = [[CCMenuItemLabel alloc] initWithLabel:levelBrowser target:self selector:@selector(levelBrowser)];
        [levelBrowserLabel setPosition: ccp(250, 80)];
        
        CCLabelTTF *rate = [[CCLabelTTF alloc] initWithString:@"Rate on App Store" fontName:@"Krungthep" fontSize:28];
        CCMenuItemLabel *rateLabel = [[CCMenuItemLabel alloc] initWithLabel:rate target:self selector:@selector(rateOnStore)];
        [rateLabel setPosition: ccp(250, 40)];
        
        CCSprite *instructions = [[CCSprite alloc] initWithFile:@"Info.png"];
        CCMenuItemSprite *instructionsItem = [CCMenuItemSprite itemFromNormalSprite:instructions selectedSprite:nil target:self selector:@selector(instructions)];
        [instructionsItem setPosition: ccp(32, 32)];
        
        /*CCLabelTTF *instructions = [[CCLabelTTF alloc] initWithString:@"Instructions" fontName:@"Krungthep" fontSize:28];
        CCMenuItemLabel *instructionsLabel = [[CCMenuItemLabel alloc] initWithLabel:instructions target:self selector:@selector(instructions)];
        [instructionsLabel setPosition: ccp(250, 44)];*/
        
        /*CCSprite *leaderboardSprite = [[CCSprite alloc] initWithFile:@"Buttons.png" rect:CGRectMake(48, 0, 48, 48)];
        CCMenuItemSprite *leaderboardItem = [CCMenuItemSprite itemFromNormalSprite:leaderboardSprite selectedSprite:nil target:self selector:@selector(toLeaderboards)];
        [leaderboardItem setPosition: ccp(32, 192)];*/
        
        CCSprite *achievementSprite = [[CCSprite alloc] initWithFile:@"Buttons.png" rect:CGRectMake(96, 0, 48, 48)];
        CCMenuItemSprite *achievementItem = [CCMenuItemSprite itemFromNormalSprite:achievementSprite selectedSprite:nil target:self selector:@selector(toAchievements)];
        [achievementItem setPosition: ccp(32, 128)]; // 32, 128
                
        self.menu = [CCMenu menuWithItems:selectLevelLabel, optionsLabel, editLevelLabel, instructionsItem, rateLabel, levelBrowserLabel, achievementItem, nil];
        [menu setPosition: ccp(0, 0)];
        [self addChild: menu];
        [selectLevel release];
        [selectLevelLabel release];
        [editLevel release];
        [editLevelLabel release];
        [options release];
        [optionsLabel release];
        
        if(![[NSUserDefaults standardUserDefaults] boolForKey:@"FirstTimeHint"]){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"First Time" message:@"It looks like this is your first time playing Block Dude Evolved. It is highly recommended that you look at the instructions on how to play and use the new level editor." delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil];
            [alert show];
            [alert release];
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"FirstTimeHint"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
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

- (void)rateOnStore{
    NSURL *rateURL = [[NSURL alloc] initWithString:@"http://itunes.apple.com/us/app/block-dude-evolved/id378754363?mt=8"];
    [[UIApplication sharedApplication] openURL:rateURL];
    [rateURL release];
}

- (void)levelBrowser{
    AppDelegate *del = [[UIApplication sharedApplication] delegate];
    UINavigationController *navController = [del navController];
    [navController setDelegate: nil];
    
    LevelBrowserViewController *lbvc = [[LevelBrowserViewController alloc] initWithNibName:@"LevelBrowserViewController" bundle:nil];
    [navController pushViewController:lbvc animated:YES];
    [lbvc release];
    [navController setNavigationBarHidden:NO animated:YES];
}

- (void)instructions{
    CCScene *is = [InstructionsScene scene];
    [[CCDirector sharedDirector] pushScene: [CCTransitionFade transitionWithDuration:0.5f scene:is]];
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
