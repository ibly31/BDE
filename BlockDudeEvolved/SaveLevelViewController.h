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
@class MainMenuScene;

@interface SaveLevelViewController : UIViewController <UITextFieldDelegate>{
    UILabel *titleLabel;
    UILabel *levelNameLabel;
    UILabel *levelWidthLabel;
    UILabel *levelHeightLabel;
    UILabel *mapSizeHintLabel;
    
    UIButton *saveButton;
    UIButton *backButton;
    
    UITextField *levelName;
    UITextField *levelWidth;
    UITextField *levelHeight;
    
    NSString *fileNameSuggest;
    CGSize sizeSuggest;
    
    int mode;
    
    RootViewController *rvc;
    LevelSelectViewController *lsvc;
    LevelEditorScene *les;
    MainMenuScene *mms;
}

- (id)initWithNibName:(NSString *)nibNameOrNil rootViewController:(RootViewController *)rootViewController mainMenuScene:(MainMenuScene *)mainMenuScene;
- (id)initWithNibName:(NSString *)nibNameOrNil rootViewController:(RootViewController *)rootViewController levelEditorScene:(LevelEditorScene *)levelEditorScene;
- (id)initWithNibName:(NSString *)nibNameOrNil levelSelectViewController:(LevelSelectViewController *)levelSelectViewController;

@property (nonatomic, retain) IBOutlet UILabel *titleLabel;
@property (nonatomic, retain) IBOutlet UILabel *levelNameLabel;
@property (nonatomic, retain) IBOutlet UILabel *levelWidthLabel;
@property (nonatomic, retain) IBOutlet UILabel *levelHeightLabel;
@property (nonatomic, retain) IBOutlet UILabel *mapSizeHintLabel;

@property (nonatomic, retain) IBOutlet UIButton *saveButton;
@property (nonatomic, retain) IBOutlet UIButton *backButton;

@property (nonatomic, retain) IBOutlet UITextField *levelName;
@property (nonatomic, retain) IBOutlet UITextField *levelWidth;
@property (nonatomic, retain) IBOutlet UITextField *levelHeight;

@property (nonatomic, retain) NSString *fileNameSuggest;
@property CGSize sizeSuggest;

@property (nonatomic, retain) RootViewController *rvc;
@property (nonatomic, retain) LevelSelectViewController *lsvc;
@property (nonatomic, retain) LevelEditorScene *les;
@property (nonatomic, retain) MainMenuScene *mms;

- (IBAction)goBack:(id)sender;
- (IBAction)saveLevel:(id)sender;

@end
