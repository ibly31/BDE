//
//  SaveLevelViewController.m
//  BlockDudeEvolved
//
//  Created by Billy Connolly on 12/24/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "SaveLevelViewController.h"
#import "LevelSelectViewController.h"
#import "LevelEditorScene.h"
#import "MainMenuScene.h"

@implementation SaveLevelViewController
@synthesize titleLabel;
@synthesize levelNameLabel;
@synthesize levelWidthLabel;
@synthesize levelHeightLabel;
@synthesize mapSizeHintLabel;

@synthesize saveButton;
@synthesize backButton;

@synthesize levelName;
@synthesize levelWidth;
@synthesize levelHeight;

@synthesize fileNameSuggest;
@synthesize sizeSuggest;

@synthesize rvc;
@synthesize lsvc;
@synthesize les;
@synthesize mms;

- (id)initWithNibName:(NSString *)nibNameOrNil rootViewController:(RootViewController *)rootViewController mainMenuScene:(MainMenuScene *)mainMenuScene{
    self = [super initWithNibName:nibNameOrNil bundle:nil];
    if(self){
        self.rvc = rootViewController;
        self.mms = mainMenuScene;
        
        mode = 0;   // Creating
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil rootViewController:(RootViewController *)rootViewController levelEditorScene:(LevelEditorScene *)levelEditorScene{
    self = [super initWithNibName:nibNameOrNil bundle:nil];
    if(self){
        self.rvc = rootViewController;
        self.les = levelEditorScene;
        
        mode = 1;   // Saving
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil levelSelectViewController:(LevelSelectViewController *)levelSelectViewController{
    self = [super initWithNibName:nibNameOrNil bundle:nil];
    if(self){
        self.lsvc = levelSelectViewController;
        
        mode = 2;   // Renaming
    }
    return self;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if(textField == levelName){
        if([string length] > 1){
            return NO;
        }else if([string length] == 0){
            return YES;
        }else if([levelName.text length] > 19){
            return NO;
        }else{
            string = [string lowercaseString];
            if([string length] != 0){
                if(strchr("qwertyuiopasdfghjklzxcvbnm1234567890 ", [string characterAtIndex: 0])){
                    return YES;
                }else{
                    return NO;
                }
            }
            return YES;
        }
    }else if(textField == levelWidth){
        if([string length] > 1){
            return NO;
        }else if([string length] == 0){
            return YES;
        }else if([levelWidth.text length] > 1){
            return NO;
        }else{
            string = [string lowercaseString];
            if([string length] != 0){
                if(strchr("1234567890", [string characterAtIndex: 0])){
                    return YES;
                }else{
                    return NO;
                }
            }
            return YES;
        }
    }else{
        if([string length] > 1){
            return NO;
        }else if([string length] == 0){
            return YES;
        }else if([levelHeight.text length] > 1){
            return NO;
        }else{
            string = [string lowercaseString];
            if([string length] != 0){
                if(strchr("1234567890", [string characterAtIndex: 0])){
                    return YES;
                }else{
                    return NO;
                }
            }
            return YES;
        }
    }
}

- (IBAction)goBack:(id)sender{
    if(mode == 0){
        [rvc dismissViewControllerAnimated:YES completion:^(void){}];
    }else if(mode == 1){
        [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];
        [rvc dismissViewControllerAnimated:YES completion:^(void){}];
    }else{
        [lsvc dismissViewControllerAnimated:YES completion:^(void){}];
    }
}

- (IBAction)saveLevel:(id)sender{
    NSString *text = [levelName text];
    int width = [[levelWidth text] intValue];
    int height = [[levelHeight text] intValue];
    
    if(mode != 0 && ([text length] == 0 || [text length] > 20)){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Your level name is invalid." delegate:self cancelButtonTitle:@"Okay" otherButtonTitles: nil];
        [alert show];
        [alert release];
    }else if(mode == 0 && (width < 3 || width > 25 || height < 3 || height > 25)){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Your level's dimensions are invalid. They must be between\n3x3 and 25x25" delegate:self cancelButtonTitle:@"Okay" otherButtonTitles: nil];
        [alert show];
        [alert release];
    }else{
        if(mode == 0){
            [mms createWithWidth:width height:height];
            [rvc dismissViewControllerAnimated:YES completion:^(void){}];
        }else if(mode == 1){
            [les saveWithFileName: [NSString stringWithFormat:@"%@.txt", text]];
            [rvc dismissViewControllerAnimated:YES completion:^(void){}];
        }else{
            [lsvc renameCustomLevel: text];
            [lsvc dismissViewControllerAnimated:YES completion:^(void){}];
        }
    }
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

#pragma mark - View lifecycle

- (void)viewDidLoad{
    [super viewDidLoad];
    if(fileNameSuggest != nil)
        [self.levelName setText: fileNameSuggest];
    [self.titleLabel setFont: [UIFont fontWithName:@"Krungthep" size: 36.0f]];
    
    if(mode == 0){
        [self.levelWidth becomeFirstResponder];
        [self.titleLabel setText: @"Create Level"];
        [self.saveButton setTitle:@"Create" forState:UIControlStateNormal];
        [self.levelName setHidden: YES];
        [self.levelNameLabel setHidden: YES];
        [self.levelWidthLabel setFrame: CGRectMake(15, 66, 102, 22)];
        [self.levelWidth setFrame: CGRectMake(125, 61, 50, 31)];
        [self.levelHeightLabel setFrame: CGRectMake(15, 112, 106, 22)];
        [self.levelHeight setFrame: CGRectMake(125, 107, 50, 31)];
        [self.saveButton setFrame: CGRectMake(190, 60, 84, 37)];
        [self.backButton setFrame: CGRectMake(190, 106, 72, 37)];
    }else if(mode == 1){
        [self.levelName becomeFirstResponder];
        [self.titleLabel setText: @"Save Level"];
        [self.levelWidth setHidden: YES];
        [self.levelHeight setHidden: YES];
        [self.levelWidthLabel setHidden: YES];
        [self.levelHeightLabel setHidden: YES];
        [self.mapSizeHintLabel setHidden: YES];
    }else{
        [self.levelName becomeFirstResponder];
        [self.titleLabel setText: @"Rename Level"];
        [self.saveButton setTitle:@"Rename" forState:UIControlStateNormal];
        [self.levelWidth setHidden: YES];
        [self.levelHeight setHidden: YES];
        [self.levelWidthLabel setHidden: YES];
        [self.levelHeightLabel setHidden: YES];
        [self.mapSizeHintLabel setHidden: YES];
    }
}

- (void)viewDidUnload{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

@end
