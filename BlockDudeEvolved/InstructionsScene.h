//
//  InstructionsScene.h
//  BlockDudeEvolved
//
//  Created by Billy Connolly on 1/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"

@interface InstructionsScene : CCScene{
    CCMenu *menu;
}

- (void)toMenu;
- (void)instructGame;
- (void)instructEditor;

@property (nonatomic, retain) CCMenu *menu;

@end
