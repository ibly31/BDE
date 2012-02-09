//
//  LevelBrowserTableViewCell.m
//  BlockDudeEvolved
//
//  Created by Billy Connolly on 2/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LevelBrowserTableViewCell.h"

@implementation LevelBrowserTableViewCell
@synthesize levelNameLabel;
@synthesize levelDifficultyLabel;
@synthesize levelDLCountLabel;
@synthesize loadingIndicator;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.levelNameLabel = [[UILabel alloc] initWithFrame: CGRectMake(15, 8, 200, 20)];
        [levelNameLabel setText: @"Level Name"];
        [levelNameLabel setTextColor: [UIColor whiteColor]];
        [levelNameLabel setBackgroundColor: [UIColor clearColor]];
        [levelNameLabel setFont: [UIFont fontWithName:@"Krungthep" size:16.0f]];
        [self addSubview: levelNameLabel];
        
        self.backgroundColor = [UIColor blackColor];
        self.selectionStyle = UITableViewCellSelectionStyleGray;
        
        self.levelDifficultyLabel = [[UILabel alloc] initWithFrame:CGRectMake(165, 3, 100, 20)];
        [levelDifficultyLabel setText:@"HARD"];
        [levelDifficultyLabel setTextColor: [UIColor redColor]];
        [levelDifficultyLabel setTextAlignment: UITextAlignmentRight];
        [levelDifficultyLabel setFont: [UIFont systemFontOfSize: 13.0f]];
        [levelDifficultyLabel setBackgroundColor: [UIColor clearColor]];
        [self addSubview: levelDifficultyLabel];
        
        /*self.starRatingView = [[StarRatingView alloc] initWithFrame: CGRectMake(196, 24, 70, 14)];
        [self addSubview: starRatingView];*/
        
        self.levelDLCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(65, 23, 200, 20)];
        [levelDLCountLabel setText:@"Downloads: 0"];
        [levelDLCountLabel setTextColor: [UIColor whiteColor]];
        [levelDLCountLabel setTextAlignment: UITextAlignmentRight];
        [levelDLCountLabel setFont: [UIFont systemFontOfSize: 12.0f]];
        [levelDLCountLabel setBackgroundColor: [UIColor clearColor]];
        [self addSubview: levelDLCountLabel];
        
        self.loadingIndicator = [[UIActivityIndicatorView alloc] initWithFrame: CGRectMake(200, 12, 21, 21)];
        [loadingIndicator setHidesWhenStopped:YES];
        [loadingIndicator stopAnimating];
        [self addSubview: loadingIndicator];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated{
    [super setSelected:selected animated:animated];
}

@end
