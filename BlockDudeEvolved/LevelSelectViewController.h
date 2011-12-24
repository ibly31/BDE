//
//  LevelSelectViewController.h
//  BlockDudeEvolved
//
//  Created by Billy Connolly on 12/23/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootViewController.h"

@class ChooseLevelScene;

@interface LevelSelectViewController : UITableViewController{
    RootViewController *rvc;
    ChooseLevelScene *cls;
}

- (id)initWithRVC:(RootViewController *)rootViewController chooseLevelScene:(ChooseLevelScene *)chooseLevelScene;

@property (nonatomic, retain) RootViewController *rvc;
@property (nonatomic, retain) ChooseLevelScene *cls;

- (void)editLevel;

@end
