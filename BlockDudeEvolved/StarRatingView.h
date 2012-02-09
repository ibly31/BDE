//
//  StarRatingView.h
//  BlockDudeEvolved
//
//  Created by Billy Connolly on 2/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StarRatingView : UIView{
    CGImageRef fullStar;
    CGImageRef halfStar;
    
    float rating;
}

- (void)setRating:(float)r;

@end
