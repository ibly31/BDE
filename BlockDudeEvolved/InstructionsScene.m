//
//  InstructionsScene.m
//  BlockDudeEvolved
//
//  Created by Billy Connolly on 1/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "InstructionsScene.h"

@implementation InstructionsScene
@synthesize menu;
@synthesize instructionBackground;
@synthesize instructionLabel;
@synthesize slideTexts;

+(id) scene{
    CCScene *scene = [CCScene node];
    InstructionsScene *layer = [InstructionsScene node];
    [scene addChild: layer];
    return scene;
}

- (id)init{
    self = [super init];
    if(self){
        CCLayerColor *background = [[CCLayerColor alloc] initWithColor:ccc4(255, 255, 255, 255) width:480 height:320];
        [self addChild: background];
        
        currentSlide = 0;
        
        self.instructionBackground = [[CCSprite alloc] initWithFile:@"Gui.png" rect:CGRectMake(0, 300, 256, 64)];
        [instructionBackground setPosition: ccp(240, 240)];
        [self addChild: instructionBackground];
        
        self.instructionLabel = [[CCLabelTTF alloc] initWithString:@"The direction of your finger\nrelative to the center of the stick\nis the direction you move." dimensions:CGSizeMake(256.0f, 60.0f)alignment:UITextAlignmentCenter fontName:@"Arial" fontSize:16.0f];
        [instructionLabel setAnchorPoint:ccp(0.5f, 1.0f)];
        [instructionLabel setPosition: ccp(240, 270)];
        [self addChild: instructionLabel];
        
        CCSprite *advance = [[CCSprite alloc] initWithFile:@"Buttons.png" rect:CGRectMake(192, 0, 48, 48)];
        CCMenuItemSprite *advanceItem = [CCMenuItemSprite itemFromNormalSprite:advance selectedSprite:nil target:self selector:@selector(advanceSlide)];
        [advanceItem setPosition: ccp(432, 48)];
        
        CCSprite *menuButton = [[CCSprite alloc] initWithFile:@"Gui.png" rect:CGRectMake(320, 192, 64, 32)];
        CCMenuItemSprite *menuItem = [CCMenuItemSprite itemFromNormalSprite:menuButton selectedSprite:nil target:self selector:@selector(toMenu)];
        [menuItem setPosition: ccp(240, 304)];
        
        editorBackground = [[CCSprite alloc] initWithFile:@"Gui.png" rect:CGRectMake(0, 256, 288, 44)];
        [editorBackground setOpacity: 0];
        [editorBackground setPosition: ccp(240, 32)];
        [self addChild: editorBackground];
        
        blockDude = [[CCSprite alloc] initWithFile:@"Original.png" rect:CGRectMake(96, 0, 32, 32)];
        [blockDude setOpacity:0];
        [blockDude setPosition: ccp(240, 140)];
        [self addChild: blockDude];
        
        controls = [[CCSprite alloc] initWithFile:@"Gui.png" rect:CGRectMake(0, 0, 128, 128)];
        [controls setOpacity: 0];
        [controls setPosition: ccp(330, 70)];
        [self addChild: controls];
        
        door = [[CCSprite alloc] initWithFile:@"Original.png" rect:CGRectMake(128, 0, 32, 32)];
        [door setOpacity: 0];
        [door setPosition: ccp(176, 140)];
        [self addChild: door];
        
        block = [[CCSprite alloc] initWithFile:@"Original.png" rect:CGRectMake(64, 0, 32, 32)];
        [block setOpacity: 0];
        [block setPosition: ccp(208, 140)];
        [self addChild: block];
        
        brick = [[CCSprite alloc] initWithFile:@"Original.png" rect:CGRectMake(32, 0, 32, 32)];
        [brick setOpacity: 0];
        [brick setPosition: ccp(240, 108)];
        [self addChild: brick];
        
        blank = [[CCSprite alloc] initWithFile:@"Original.png" rect:CGRectMake(0, 0, 32, 32)];
        [blank setOpacity: 0];
        [blank setPosition: ccp(160, 32)];
        [self addChild: blank];
        
        panOrDraw = [[CCSprite alloc] initWithFile:@"Gui.png" rect:CGRectMake(320, 256, 32, 32)];
        [panOrDraw setOpacity: 0];
        [panOrDraw setPosition: ccp(117, 32)];
        [self addChild: panOrDraw];
        
        self.menu = [CCMenu menuWithItems:advanceItem, menuItem, nil];
        [menu setPosition: ccp(0,0)];
        [self addChild: menu];
                            // PenisPenisPenisPenisPenisPenis\nPenisPenisPenisPenisPenisPenis\nPenisPenisPenisPenisPenisPenis
        NSString *string00 = @"Welcome to the tutorial.\nTap the right arrow button to\nadvance to the next slide.";
        NSString *string01 = @"This is Block Dude. Control\nhim using the left and right\nbuttons.";
        NSString *string02 = @"Control scheme may vary.\nChange the current control\nscheme in the options menu.";
        NSString *string03 = @"The goal of the game is to\nget Block Dude to the exit\nlike this one.";
        NSString *string04 = @"Sounds simple? Well, you can\nalso manipulate blocks to get\nto the goal.";
        NSString *string05 = @"Blocks look like this.\nTap the down button to pick up\nthe block.";
        NSString *string06 = @"Tap the down button to drop\na block when you are ready\nto place it.";
        NSString *string07 = @"This is a brick. You can not\npick up or move bricks. Use\nthem to your advantage.";
        NSString *string08 = @"Tap the up button to climb.\nBlock Dude can only climb a\nheight of one block.";
        NSString *string09 = @"Combine all these abilities\nto make it to the exit. Beating\na level gets an achievement.";
        NSString *string10 = @"Using the editor is simple.\nChoose which tile to draw\nfrom the tray below.";
        NSString *string11 = @"Select whether you are panning\nor drawing with the hand\nor pencil button.";
        NSString *string12 = @"Panning lets you drag your\nfinger to move the map, and tap\nto change level tiles.";
        NSString *string13 = @"Drawing lets you drag your\nfinger to draw on the map\n";
        
        self.slideTexts = [[NSArray alloc] initWithObjects:string00, string01, string02, string03, string04, string05, string06, string07, string08, string09, string10, string11, string12, string13, nil];
        [self advanceSlide];
    }
    return self;
}

- (void)advanceSlide{    
    [instructionLabel setString:[slideTexts objectAtIndex:currentSlide]];
    
    switch(currentSlide){
        case 1:
            [blockDude runAction: [CCFadeTo actionWithDuration:0.25f opacity:255]];
            [controls runAction: [CCFadeTo actionWithDuration:0.25f opacity:255]];
            break;
        case 3:
            [door runAction: [CCFadeTo actionWithDuration:0.25f opacity:255]];
            break;
        case 4:
            [block runAction: [CCFadeTo actionWithDuration:0.25f opacity:255]];
            break;
        case 5:
            [block runAction: [CCMoveTo actionWithDuration:0.1f position:ccp(240, 172)]];
            break;
        case 6:
            [block runAction: [CCMoveTo actionWithDuration:0.1f position:ccp(208, 140)]];
            break;
        case 7:
            [brick runAction: [CCFadeTo actionWithDuration:0.25f opacity:255]];
            break;
        case 8:
            [blockDude runAction: [CCMoveTo actionWithDuration:0.1f position:ccp(208, 172)]];
            break;
        case 10:
            [controls runAction: [CCFadeTo actionWithDuration:0.25f opacity:0]];
            [editorBackground runAction: [CCFadeTo actionWithDuration:0.25f opacity:255]];
            [brick runAction: [CCMoveTo actionWithDuration:0.25f position:ccp(200, 32)]];
            [block runAction: [CCMoveTo actionWithDuration:0.25f position:ccp(240, 32)]];
            [blockDude runAction: [CCMoveTo actionWithDuration:0.25f position:ccp(280, 32)]];
            [door runAction: [CCMoveTo actionWithDuration:0.25f position:ccp(320, 32)]];
            [blank runAction: [CCFadeTo actionWithDuration:0.25f opacity:255]];
            break;
        case 11:
            [panOrDraw runAction: [CCFadeTo actionWithDuration:0.25f opacity:255]];
            break;
        case 13:
            [panOrDraw setDisplayFrame: [CCSpriteFrame frameWithTexture:[panOrDraw texture] rect:CGRectMake(288, 256, 32, 32)]];
            break;
        default:
            break;
    }
    if(currentSlide < 13)
        currentSlide++;
}

- (void)toMenu{
    [[CCDirector sharedDirector] popSceneWithTransition:[CCTransitionFade class] duration:0.5f];
}

/*
- (void)instructGame{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Game" message:@"The object of the game is to get to the door. Pick up and put down blocks using the down button and move left and right using the buttons." delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil];
    [alert show];
    [alert release];
}

- (void)instructEditor{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Level Editor" message:@"To choose a different tile to draw, tap it in the tray below. Tap the hand/pencil icon to toggle between pan and draw mode. In pan mode you may tap to draw, and drag to pan the map." delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil];
    [alert show];
    [alert release];
}*/

@end
