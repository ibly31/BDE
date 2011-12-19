//
//  AppDelegate.m
//  BlockDudeEvolved
//
//  Created by Billy Connolly on 12/6/11.
//  Copyright __MyCompanyName__ 2011. All rights reserved.
//

#import "cocos2d.h"

#import "AppDelegate.h"
#import "GameConfig.h"
#import "MainMenuScene.h"
#import "RootViewController.h"
#import <GameKit/GameKit.h>

@implementation AppDelegate
@synthesize window;
@synthesize viewController;
@synthesize gameCenterModel;

- (void) applicationDidFinishLaunching:(UIApplication*)application{
	window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    self.gameCenterModel = [[GameCenterModel alloc] init];
    
    if([[NSUserDefaults standardUserDefaults] integerForKey: @"ControlScheme"] == 0){
        [[NSUserDefaults standardUserDefaults] setInteger:1 forKey:@"ControlScheme"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    if([[NSUserDefaults standardUserDefaults] objectForKey: @"SpeedMode"] == nil){
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"SpeedMode"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
	if(![CCDirector setDirectorType:kCCDirectorTypeDisplayLink])
		[CCDirector setDirectorType:kCCDirectorTypeDefault];
	
	
	CCDirector *director = [CCDirector sharedDirector];
	
	self.viewController = [[RootViewController alloc] initWithNibName:nil bundle:nil];
	viewController.wantsFullScreenLayout = YES;
	
	EAGLView *glView = [EAGLView viewWithFrame:[window bounds]
								   pixelFormat:kEAGLColorFormatRGB565	// kEAGLColorFormatRGBA8
								   depthFormat:0						// GL_DEPTH_COMPONENT16_OES
						];
	
	// attach the openglView to the director
	[director setOpenGLView:glView];
	
	// Enables High Res mode (Retina Display) on iPhone 4 and maintains low res on all other devices
	if( ! [director enableRetinaDisplay:YES] )
		CCLOG(@"Retina Display Not supported");
	
	[director setDeviceOrientation:kCCDeviceOrientationPortrait];
	
	[director setAnimationInterval:1.0/60];
	[director setDisplayFPS:YES];
	
    [viewController setView:glView];
	
	[window addSubview: viewController.view];
	[window makeKeyAndVisible];
	[CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_RGBA8888];
	
    MainMenuScene *mms = [[MainMenuScene alloc] init];
	[[CCDirector sharedDirector] runWithScene: mms];
    [mms release];
}

- (void)applicationWillResignActive:(UIApplication *)application {
	[[CCDirector sharedDirector] pause];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
	[[CCDirector sharedDirector] resume];
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
	[[CCDirector sharedDirector] purgeCachedData];
}

-(void) applicationDidEnterBackground:(UIApplication*)application {
	[[CCDirector sharedDirector] stopAnimation];
}

-(void) applicationWillEnterForeground:(UIApplication*)application {
	[[CCDirector sharedDirector] startAnimation];
}

- (void)applicationWillTerminate:(UIApplication *)application {
	CCDirector *director = [CCDirector sharedDirector];
	
	[[director openGLView] removeFromSuperview];
	
	[viewController release];
	
	[window release];
	
	[director end];	
}

- (void)applicationSignificantTimeChange:(UIApplication *)application {
	[[CCDirector sharedDirector] setNextDeltaTimeZero:YES];
}

- (void)dealloc {
	[[CCDirector sharedDirector] release];
	[window release];
	[super dealloc];
}

@end
