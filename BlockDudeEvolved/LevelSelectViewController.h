//
//  LevelSelectViewController.h
//  BlockDudeEvolved
//
//  Created by Billy Connolly on 12/23/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ChooseLevelScene;

@interface LevelSelectViewController : UITableViewController{
    ChooseLevelScene *cls;
    NSMutableArray *customLevelArray;
    
    NSIndexPath *fileToChange;
}

- (id)initWithChooseLevelScene:(ChooseLevelScene *)chooseLevelScene;

@property (nonatomic, retain) ChooseLevelScene *cls;
@property (nonatomic, retain) NSMutableArray *customLevelArray;
@property (nonatomic, retain) NSIndexPath *fileToChange;

- (void)deleteCustomLevel:(NSString *)customLevel;
- (void)renameCustomLevel:(NSString *)newName;

- (void)toggleEditing;

@end
