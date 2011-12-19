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

- (id)initWithMoves:(int)moves timeTaken:(NSTimeInterval)time levelNumber:(int)level{
    self = [super init];
    if(self){
        AppDelegate *del = [[UIApplication sharedApplication] delegate];
        [[del gameCenterModel] reportAchievementIdentifier:[NSString stringWithFormat:@"Level%iComplete", level] percentComplete:100.0f];
        
        levelNumber = level;
        
        int numberOriginalComplete = 0;
        for(int x = 1; x <= 11; x++){
            if([[del gameCenterModel] achievementExistsForIdentifier:[NSString stringWithFormat:@"Level%iComplete"]])
                numberOriginalComplete++;
        }
        
        if(numberOriginalComplete > 0){
            [[del gameCenterModel] reportAchievementIdentifier:@"OriginalLevelsComplete" percentComplete:(float)numberOriginalComplete / 11.0f];
        }
        
        movesScore = moves;
        timeScore = time;
        
        self.movesLabel = [[CCLabelTTF alloc] initWithString:[NSString stringWithFormat:@"Moves: %i", moves] fontName:@"Krungthep" fontSize:24];
        [movesLabel setPosition: ccp(240, 223)];
        [self addChild: movesLabel];
        
        self.timeTakenLabel = [[CCLabelTTF alloc] initWithString:[NSString stringWithFormat:@"Time taken: %.2fs",time] fontName:@"Krungthep" fontSize:24];
        [timeTakenLabel setPosition: ccp(240, 183)];
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
    
    /*GKScore *movesReporter = [[[GKScore alloc] initWithCategory:@"BDEL1Moves"] autorelease];
    movesReporter.value = movesScore;
    
    [movesReporter reportScoreWithCompletionHandler:^(NSError *error) {
        if (error != nil){
            NSLog(@"Could not report move score");
        }
    }];*/
    
    GKScore *timeReporter = [[[GKScore alloc] initWithCategory:[NSString stringWithFormat:@"BDEL%iTimes", levelNumber]] autorelease];
    timeReporter.value = timeScore;
    
    [timeReporter reportScoreWithCompletionHandler:^(NSError *error) {
        if (error != nil)
        {
            NSLog(@"Could not report time score");
        }
    }];
        
    [[del gameCenterModel] openLeaderboardViewer];
}

@end
