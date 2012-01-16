//
//  SaveLevelViewController.h
//  BlockDudeEvolved
//
//  Created by Billy Connolly on 12/24/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LevelEditorScene;
@class LevelSelectViewController;
@class ChooseLevelScene;

@interface SaveLevelViewController : UIViewController <UITextFieldDelegate>{
    UILabel *titleLabel;
    UILabel *levelNameLabel;
    UILabel *levelWidthLabel;
    UILabel *levelHeightLabel;
    UILabel *mapSizeHintLabel;
    UILabel *saveOverHintLabel;
    
    UIButton *saveButton;
    UIButton *backButton;
    
    UITextField *levelName;
    UITextField *levelWidth;
    UITextField *levelHeight;
    
    NSString *fileNameSuggest;
    CGSize sizeSuggest;
    
    int mode;
    
    LevelSelectViewController *lsvc;
    LevelEditorScene *les;
    ChooseLevelScene *cls;
}

- (id)initWithNibName:(NSString *)nibNameOrNil chooseLevelScene:(ChooseLevelScene *)chooseLevelScene;
- (id)initWithNibName:(NSString *)nibNameOrNil levelEditorScene:(LevelEditorScene *)levelEditorScene;
- (id)initWithNibName:(NSString *)nibNameOrNil levelSelectViewController:(LevelSelectViewController *)levelSelectViewController;

@property (nonatomic, retain) IBOutlet UILabel *titleLabel;
@property (nonatomic, retain) IBOutlet UILabel *levelNameLabel;
@property (nonatomic, retain) IBOutlet UILabel *levelWidthLabel;
@property (nonatomic, retain) IBOutlet UILabel *levelHeightLabel;
@property (nonatomic, retain) IBOutlet UILabel *mapSizeHintLabel;
@property (nonatomic, retain) IBOutlet UILabel *saveOverHintLabel;

@property (nonatomic, retain) IBOutlet UIButton *saveButton;
@property (nonatomic, retain) IBOutlet UIButton *backButton;

@property (nonatomic, retain) IBOutlet UITextField *levelName;
@property (nonatomic, retain) IBOutlet UITextField *levelWidth;
@property (nonatomic, retain) IBOutlet UITextField *levelHeight;

@property (nonatomic, retain) NSString *fileNameSuggest;
@property CGSize sizeSuggest;

@property (nonatomic, retain) LevelSelectViewController *lsvc;
@property (nonatomic, retain) LevelEditorScene *les;
@property (nonatomic, retain) ChooseLevelScene *cls;

- (IBAction)goBack:(id)sender;
- (IBAction)saveLevel:(id)sender;

@end
