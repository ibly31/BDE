//
//  LevelBrowserTableViewCell.h
//  BlockDudeEvolved
//
//  Created by Billy Connolly on 2/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StarRatingView.h"

@interface LevelBrowserTableViewCell : UITableViewCell{
    UILabel *levelNameLabel;
    UILabel *levelDifficultyLabel;
    //StarRatingView *starRatingView;
    UILabel *levelDLCountLabel;
    
    UIActivityIndicatorView *loadingIndicator;
}

@property (nonatomic, retain) UILabel *levelNameLabel;
@property (nonatomic, retain) UILabel *levelDifficultyLabel;
@property (nonatomic, retain) UILabel *levelDLCountLabel;
//@property (nonatomic, retain) StarRatingView *starRatingView;
@property (nonatomic, retain) UIActivityIndicatorView *loadingIndicator;

@end
