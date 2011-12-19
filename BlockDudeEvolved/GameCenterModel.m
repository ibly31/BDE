//
//  GameCenterModel.m
//  BlockDudeEvolved
//
//  Created by Billy Connolly on 12/18/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "GameCenterModel.h"
#import "AppDelegate.h"
#import "RootViewController.h"

@implementation GameCenterModel
@synthesize achievementsDict;

- (id)init{
    self = [super init];
    if(self){
        self.achievementsDict = [[NSMutableDictionary alloc] init];
        [self authenticatePlayer];
    }
    return self;
}

- (void)openAchievementViewer{
    AppDelegate *del = [[UIApplication sharedApplication] delegate];
    RootViewController *rvc = [del viewController];
    
    if([GKLocalPlayer localPlayer].isAuthenticated){
        GKAchievementViewController *achievementController = [[GKAchievementViewController alloc] init];    
        if(achievementController != nil){
            achievementController.achievementDelegate = self;
            [rvc presentModalViewController:achievementController animated:YES];
        }
    }else{
        [self authenticatePlayer];
    }
}

- (void)openLeaderboardViewer{
    AppDelegate *del = [[UIApplication sharedApplication] delegate];
    RootViewController *rvc = [del viewController];

    if([GKLocalPlayer localPlayer].isAuthenticated){
        GKLeaderboardViewController *leaderboardController = [[GKLeaderboardViewController alloc] init];
        if(leaderboardController != nil){
            leaderboardController.timeScope = GKLeaderboardTimeScopeAllTime;
            leaderboardController.leaderboardDelegate = self;
            [rvc presentModalViewController:leaderboardController animated:YES];
        }
    }else{
        [self authenticatePlayer];
    }
}

- (void)authenticatePlayer{
    GKLocalPlayer *localPlayer = [GKLocalPlayer localPlayer];
    [localPlayer authenticateWithCompletionHandler:^(NSError *error){
        if (localPlayer.isAuthenticated){
            NSLog(@"Successful Authentication");
        }
    }];
}

- (void)loadAchievements{
    [GKAchievement loadAchievementsWithCompletionHandler:^(NSArray *achievements, NSError *error){
         if (error == nil){
             for (GKAchievement* achievement in achievements)
                 [achievementsDict setObject: achievement forKey: achievement.identifier];
             
         }else{
             NSLog(@"Could not load any achievements");
         }
     }];
}

- (void)resetAchievements{
    achievementsDict = [[NSMutableDictionary alloc] init];
    [GKAchievement resetAchievementsWithCompletionHandler:^(NSError *error){
        if(error != nil){
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Could not reset your achievements, please log in to game center." delegate:self cancelButtonTitle:@"Okay" otherButtonTitles: nil];
            [alertView show];
            [alertView release];
            [self authenticatePlayer];
        }
    }];
}

- (void)reportAchievementIdentifier:(NSString*)identifier percentComplete:(float)percent{
    GKAchievement *achievement = [self getAchievementForIdentifier:identifier];
    if(achievement){
        achievement.percentComplete = percent;
        [achievement reportAchievementWithCompletionHandler:^(NSError *error){
             if(error != nil){
                 // Retain the achievement object and try again later (not shown).
             }
         }];
    }
}

- (BOOL)achievementExistsForIdentifier:(NSString *)identifier{
    GKAchievement *achievement = [achievementsDict objectForKey:identifier];
    if(achievement == nil)
        return NO;
    else
        return YES;
}

- (GKAchievement*)getAchievementForIdentifier: (NSString*) identifier{
    GKAchievement *achievement = [achievementsDict objectForKey:identifier];
    if(achievement == nil){
        achievement = [[[GKAchievement alloc] initWithIdentifier:identifier] autorelease];
        [achievementsDict setObject:achievement forKey:achievement.identifier];
    }
    return [[achievement retain] autorelease];
}

- (void)leaderboardViewControllerDidFinish:(GKLeaderboardViewController *)viewController{
    AppDelegate *del = [[UIApplication sharedApplication] delegate];
    RootViewController *rvc = [del viewController];
    [rvc dismissModalViewControllerAnimated:YES];
}

- (void)achievementViewControllerDidFinish:(GKAchievementViewController *)viewController{
    AppDelegate *del = [[UIApplication sharedApplication] delegate];
    RootViewController *rvc = [del viewController];
    [rvc dismissModalViewControllerAnimated:YES];
}

@end
