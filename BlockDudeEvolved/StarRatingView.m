//
//  StarRatingView.m
//  BlockDudeEvolved
//
//  Created by Billy Connolly on 2/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "StarRatingView.h"

@implementation StarRatingView

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        UIImage *bothStarsImage = [UIImage imageNamed:@"Star.png"];
        CGImageRef bothStars = [bothStarsImage CGImage];
        if(self.contentScaleFactor != 1.0){
            fullStar = CGImageCreateWithImageInRect(bothStars, CGRectMake(0, 0, 28, 28));
            halfStar = CGImageCreateWithImageInRect(bothStars, CGRectMake(28, 0, 28, 28));
        }else{
            fullStar = CGImageCreateWithImageInRect(bothStars, CGRectMake(0, 0, 14, 14));
            halfStar = CGImageCreateWithImageInRect(bothStars, CGRectMake(14, 0, 14, 14));
        }
    }
    return self;
}

- (void)setRating:(float)r{
    rating = r;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0, 14);
    CGContextScaleCTM(context, 1.0f, -1.0f);
    
    int doubleRating = rating * 2;
    if(doubleRating != 0){
        if(doubleRating == 2 || doubleRating == 4 || doubleRating == 6 || doubleRating == 8 || doubleRating == 10){
            for(int x = 0; x < 5; x++){
                if(doubleRating / 2 > x){
                    CGContextDrawImage(context, CGRectMake(x * 14 , 0, 14, 14), fullStar);
                }
            }
        }else{
            switch(doubleRating){
                case 1:
                    CGContextDrawImage(context, CGRectMake(0 , 0, 14, 14), halfStar);
                    break;
                case 3:
                    CGContextDrawImage(context, CGRectMake(0, 0, 14, 14), fullStar);
                    CGContextDrawImage(context, CGRectMake(14, 0, 14, 14), halfStar);
                    break;
                case 5:
                    CGContextDrawImage(context, CGRectMake(0 , 0, 14, 14), fullStar);
                    CGContextDrawImage(context, CGRectMake(14, 0, 14, 14), fullStar);
                    CGContextDrawImage(context, CGRectMake(28, 0, 14, 14), halfStar);
                    break;
                case 7:
                    CGContextDrawImage(context, CGRectMake(0 , 0, 14, 14), fullStar);
                    CGContextDrawImage(context, CGRectMake(14, 0, 14, 14), fullStar);
                    CGContextDrawImage(context, CGRectMake(28, 0, 14, 14), fullStar);
                    CGContextDrawImage(context, CGRectMake(42, 0, 14, 14), halfStar);
                    break;
                case 9:
                    CGContextDrawImage(context, CGRectMake(0 , 0, 14, 14), fullStar);
                    CGContextDrawImage(context, CGRectMake(14, 0, 14, 14), fullStar);
                    CGContextDrawImage(context, CGRectMake(28, 0, 14, 14), fullStar);
                    CGContextDrawImage(context, CGRectMake(42, 0, 14, 14), fullStar);
                    CGContextDrawImage(context, CGRectMake(56, 0, 14, 14), halfStar);
                    break;
                default:
                    break;
            }
        }
    }
}

@end
