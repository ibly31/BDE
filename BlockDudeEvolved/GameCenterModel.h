//
//  GameCenterModel.h
//  BlockDudeEvolved
//
//  Created by Billy Connolly on 12/18/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <GameKit/GameKit.h>

@interface GameCenterModel : NSObject <GKLeaderboardViewControllerDelegate, GKAchievementViewControllerDelegate>{
    NSMutableDictionary *achievementsDict;
}

@property (nonatomic, retain) NSMutableDictionary *achievementsDict;

- (void)authenticatePlayer;
- (void)resetAchievements;
- (GKAchievement*) getAchievementForIdentifier:(NSString*)identifier;
- (BOOL)achievementExistsForIdentifier:(NSString *)identifier;
- (void)reportAchievementIdentifier:(NSString*)identifier percentComplete:(float)percent;

- (void)openAchievementViewer;
- (void)openLeaderboardViewer;

@end
