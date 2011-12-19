//
//  AppDelegate.h
//  BlockDudeEvolved
//
//  Created by Billy Connolly on 12/6/11.
//  Copyright __MyCompanyName__ 2011. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GameCenterModel.h"

@class RootViewController;

@interface AppDelegate : NSObject <UIApplicationDelegate> {
	UIWindow			*window;
	RootViewController	*viewController;
    GameCenterModel *gameCenterModel;
}

@property (nonatomic, retain) UIWindow *window;
@property (nonatomic, retain) RootViewController *viewController;
@property (nonatomic, retain) GameCenterModel *gameCenterModel;

@end
