//
//  EditorInputLayer.h
//  BlockDudeEvolved
//
//  Created by Billy Connolly on 12/23/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"

@interface EditorInputLayer : CCLayer{
    CGPoint previousDragLocation;
    CGPoint touchStartLocation;
}

@end
