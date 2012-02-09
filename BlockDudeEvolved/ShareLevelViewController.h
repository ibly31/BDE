//
//  ShareLevelViewController.h
//  BlockDudeEvolved
//
//  Created by Billy Connolly on 1/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShareLevelViewController : UIViewController <UIAlertViewDelegate, UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource> {
    UIPickerView *difficultyPicker;
    
    UIActivityIndicatorView *sendingView;
    UILabel *sendingLabel;
    
    UILabel *nameLabel;
    UILabel *sizeLabel;
    
    UITableView *levelView;
        
    NSMutableArray *customLevelArray;
    
    NSString *currentlySelectedLevel;
    NSString *currentPlayerID;
    NSString *currentLevelData;
}

@property (nonatomic, retain) IBOutlet UIPickerView *difficultyPicker;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *sendingView;
@property (nonatomic, retain) IBOutlet UILabel *sendingLabel;
@property (nonatomic, retain) IBOutlet UILabel *nameLabel;
@property (nonatomic, retain) IBOutlet UILabel *sizeLabel;
@property (nonatomic, retain) IBOutlet UITableView *levelView;
@property (nonatomic, retain) NSMutableArray *customLevelArray;
@property (nonatomic, retain) NSString *currentlySelectedLevel;

- (IBAction)upload:(id)sender;
- (void)selectLevel:(NSString *)level;

@end
