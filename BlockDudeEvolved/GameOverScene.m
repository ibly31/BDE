//
//  GameOverScene.m
//  BlockDudeEvolved
//
//  Created by Billy Connolly on 12/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "GameOverScene.h"
#import "MainMenuScene.h"
#import "AppDelegate.h"
#import <GameKit/GameKit.h>
#import "RootViewController.h"

@implementation GameOverScene
@synthesize movesLabel;
@synthesize timeTakenLabel;
@synthesize menu;

- (id)initWithMoves:(int)moves timeTaken:(NSTimeInterval)time level:(NSString *)level{
    self = [super init];
    if(self){
        levelNumber = 0;

        AppDelegate *del = [[UIApplication sharedApplication] delegate];
        [[del gameCenterModel] reportAchievementIdentifier:[NSString stringWithFormat:@"Level%iComplete", level] percentComplete:100.0f];
        [[del gameCenterModel] reportLeaderboardCategory:[NSString stringWithFormat:@"BDEL%iTimes", level] score:time];
        
        int numberOriginalComplete = 0;
        for(int x = 1; x <= 11; x++){
            if([[del gameCenterModel] achievementExistsForIdentifier:[NSString stringWithFormat:@"Level%iComplete", level]]){
                if([[del gameCenterModel] getAchievementForIdentifier:[NSString stringWithFormat:@"Level%iComplete", level]].completed)
                    numberOriginalComplete++;
            }
        }
        
        if(numberOriginalComplete > 0){
            [[del gameCenterModel] reportAchievementIdentifier:@"OriginalLevelsComplete" percentComplete:100.0f * ((float)numberOriginalComplete / 11.0f)];
        }
        
        int numberTotalComplete = numberOriginalComplete;       // Save some time, don't recalc original.
        for(int x = 12; x <= 22; x++){
            if([[del gameCenterModel] achievementExistsForIdentifier:[NSString stringWithFormat:@"Level%iComplete"]]){
                if([[del gameCenterModel] getAchievementForIdentifier:[NSString stringWithFormat:@"Level%iComplete"]].completed)
                    numberTotalComplete++;
            }
        }
        
        if(numberTotalComplete > 0){
            [[del gameCenterModel] reportAchievementIdentifier:@"All22LevelsComplete" percentComplete:100.0f * ((float)numberTotalComplete / 22.0f)];
        }
        
        movesScore = moves;
        timeScore = time;
        
        self.movesLabel = [[CCLabelTTF alloc] initWithString:[NSString stringWithFormat:@"Moves: %i", moves] fontName:@"Krungthep" fontSize:24];
        [movesLabel setPosition: ccp(240, 223)];
        [self addChild: movesLabel];
        
        self.timeTakenLabel = [[CCLabelTTF alloc] initWithString:@"" fontName:@"Krungthep" fontSize:24];
        [timeTakenLabel setPosition: ccp(240, 183)];
        
        if(time >= 60.0f){
            int minutes;
            float seconds;
            minutes = time / 60.0f;
            seconds = time - (minutes * 60.0f);
            [timeTakenLabel setString:[NSString stringWithFormat:@"Time taken: %d:%05.2f", minutes, seconds]];
        }else{
            [timeTakenLabel setString:[NSString stringWithFormat:@"Time taken: %.2fs", time]];
        }
        [self addChild: timeTakenLabel];
        
        CCSprite *menuSprite = [[CCSprite alloc] initWithFile:@"Buttons.png" rect:CGRectMake(0, 0, 48, 48)];
        CCMenuItemSprite *menuItem = [CCMenuItemSprite itemFromNormalSprite:menuSprite selectedSprite:nil target:self selector:@selector(toMenu)];
        [menuItem setPosition: ccp(180, 64)];
                
        CCSprite *achieveSprite = [[CCSprite alloc] initWithFile:@"Buttons.png" rect:CGRectMake(96, 0, 48, 48)];
        CCMenuItemSprite *achieveItem = [CCMenuItemSprite itemFromNormalSprite:achieveSprite selectedSprite:nil target:self selector:@selector(toAchievements)];
        [achieveItem setPosition: ccp(240, 64)];
        
        CCSprite *leaderSprite = [[CCSprite alloc] initWithFile:@"Buttons.png" rect: CGRectMake(48, 0, 48, 48)];
        CCMenuItemSprite *leaderItem = [CCMenuItemSprite itemFromNormalSprite:leaderSprite selectedSprite:nil target:self selector:@selector(toLeaderboards)];
        [leaderItem setPosition: ccp(300, 64)];
        
        self.menu = [CCMenu menuWithItems:menuItem, achieveItem, leaderItem, nil];
        [menu setPosition: ccp(0.0f, 0.0f)];
        [self addChild: menu];
        
    }
    return self;
}

- (void)toMenu{
    MainMenuScene *mms = [[MainMenuScene alloc] init];
    [[CCDirector sharedDirector] replaceScene: [CCTransitionFade transitionWithDuration:0.5f scene:mms]];
    [mms release];
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
