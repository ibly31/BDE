//
//  SaveLevelViewController.h
//  BlockDudeEvolved
//
//  Created by Billy Connolly on 12/24/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootViewController.h"

@class LevelEditorScene;
@class LevelSelectViewController;

@interface SaveLevelViewController : UIViewController <UITextFieldDelegate>{
    UILabel *saveLevelLabel;
    UITextField *fileName;
    NSString *fileNameSuggest;
    
    BOOL change;
    
    RootViewController *rvc;
    LevelSelectViewController *lsvc;
    LevelEditorScene *les;
}

- (id)initWithNibName:(NSString *)nibNameOrNil rootViewController:(RootViewController *)rootViewController levelEditorScene:(LevelEditorScene *)levelEditorScene;
- (id)initWithNibName:(NSString *)nibNameOrNil levelSelectViewController:(LevelSelectViewController *)levelSelectViewController;

@property (nonatomic, retain) IBOutlet UILabel *saveLevelLabel;
@property (nonatomic, retain) IBOutlet UITextField *fileName;
@property (nonatomic, retain) NSString *fileNameSuggest;

@property (nonatomic, retain) RootViewController *rvc;
@property (nonatomic, retain) LevelSelectViewController *lsvc;
@property (nonatomic, retain) LevelEditorScene *les;

- (IBAction)goBack:(id)sender;
- (IBAction)saveLevel:(id)sender;

@end
