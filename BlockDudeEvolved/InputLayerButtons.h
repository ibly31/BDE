//
//  InputLayerButtons.h
//  BlockDudeEvolved
//
//  Created by Billy Connolly on 12/17/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"

@interface InputLayerButtons : CCLayer{
    CCSprite *pauseButton;
    BOOL acceptInput;
    CCSprite *up,*right,*down,*left;
    
    int orientation;
    
    float waitTime;
    float firstWaitTime;
    int didFirstWaits;
}

- (id)init;

@property (nonatomic, retain) CCSprite *pauseButton;
@property (nonatomic, retain) CCSprite *up;
@property (nonatomic, retain) CCSprite *right;
@property (nonatomic, retain) CCSprite *down;
@property (nonatomic, retain) CCSprite *left;

@property BOOL acceptInput;

- (void)stickDown:(int)orient;
- (void)repeat;

@end
