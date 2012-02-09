//
//  LevelBrowserViewController.h
//  BlockDudeEvolved
//
//  Created by Billy Connolly on 1/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MapPreviewView.h"

@interface LevelBrowserViewController : UIViewController <UIAlertViewDelegate, UITableViewDelegate, UITableViewDataSource>{
    UITableView *browserView;
    UILabel *nameLabel;
    UILabel *playCountLabel;
    
    NSMutableArray *levels;
    
    MapPreviewView *mapPreviewView;
    
    UISegmentedControl *filterSelector;
    NSInteger currentlySelectedLevel;
    
    BOOL nextRefreshIsFetching;
    
    UIButton *saveLevelButton;
}

@property (nonatomic, retain) IBOutlet UITableView *browserView;
@property (nonatomic, retain) IBOutlet UILabel *nameLabel;
@property (nonatomic, retain) IBOutlet UILabel *playCountLabel;
@property (nonatomic, retain) IBOutlet UISegmentedControl *filterSelector;
@property (nonatomic, retain) IBOutlet UIButton *saveLevelButton;
@property (nonatomic, retain) NSMutableArray *levels;
@property (nonatomic, retain) MapPreviewView *mapPreviewView;
@property NSInteger currentlySelectedLevel;

- (IBAction)saveLevel:(id)sender;
- (IBAction)changeFilter:(id)sender;
- (void)changeSelectedLevel:(int)level;
- (void)shareLevel;
- (void)toggleEdit;

- (void)populateLevelList;

@end
