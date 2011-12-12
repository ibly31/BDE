//
//  InputLayer.h
//  BlockDudeEvolved
//
//  Created by Billy Connolly on 12/7/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"

@interface InputLayer : CCLayer{
    
    CCSprite *pauseButton;
    
    CCSprite *directionalStick;
    int orientation;
    
    BOOL acceptInput;
    
    
    float waitTime;
    float firstWaitTime;
    int didFirstWaits;
}

- (id)init;

@property (nonatomic, retain) CCSprite *pauseButton;
@property (nonatomic, retain) CCSprite *directionalStick;
@property BOOL acceptInput;

- (void)stickDown:(int)orient;
- (void)repeat;


@end
