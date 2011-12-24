//
//  EditorInputLayer.m
//  BlockDudeEvolved
//
//  Created by Billy Connolly on 12/23/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "EditorInputLayer.h"
#import "LevelEditorScene.h"

@implementation EditorInputLayer

- (id)init{
    self = [super init];
    if(self){
        self.isTouchEnabled = YES;
        previousDragLocation = ccp(0,0);
        touchStartLocation = ccp(0,0);
    }
    return self;
}

- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint location = [[CCDirector sharedDirector] convertToGL: [touch locationInView: touch.view]];
    previousDragLocation = location;
    touchStartLocation = location;
}

- (void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint location = [[CCDirector sharedDirector] convertToGL: [touch locationInView: touch.view]];
    
    if(ccpDistance(location, touchStartLocation) >= 32.0f){
        CGPoint difference = ccp(location.x - previousDragLocation.x, location.y - previousDragLocation.y);
        [(LevelEditorScene *)parent_ addDifferenceToCenterOn: difference];
    }
    previousDragLocation = location;

}

- (void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint location = [[CCDirector sharedDirector] convertToGL: [touch locationInView: touch.view]];
    
    if(ccpDistance(location, touchStartLocation) < 32.0f){
        
    }
}

@end
