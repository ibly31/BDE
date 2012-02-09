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
#import "ChooseLevelScene.h"
#import "AppDelegate.h"

@implementation SaveLevelViewController
@synthesize titleLabel;
@synthesize levelNameLabel;
@synthesize levelWidthLabel;
@synthesize levelHeightLabel;
@synthesize mapSizeHintLabel;
@synthesize saveOverHintLabel;

@synthesize saveButton;
@synthesize backButton;

@synthesize levelName;
@synthesize levelWidth;
@synthesize levelHeight;

@synthesize fileNameSuggest;
@synthesize sizeSuggest;

@synthesize lsvc;
@synthesize les;
@synthesize cls;

- (id)initWithNibName:(NSString *)nibNameOrNil chooseLevelScene:(ChooseLevelScene *)chooseLevelScene{
    self = [super initWithNibName:nibNameOrNil bundle:nil];
    if(self){
        self.cls = chooseLevelScene;
        
        mode = 0;   // Creating
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil levelEditorScene:(LevelEditorScene *)levelEditorScene{
    self = [super initWithNibName:nibNameOrNil bundle:nil];
    if(self){
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
        }else if([levelName.text length] > 15){
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
        //No need to set nextPopWillBeMenu because we aren't popping TO rootviewcont, so it weeds it out
        [self.navigationController popViewControllerAnimated: YES];
    }else if(mode == 1){
        [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];
        AppDelegate *del = [[UIApplication sharedApplication] delegate];
        ChooseLevelScene *chooseLevelScene = (ChooseLevelScene *)[del navController].delegate;   // Not actually existing
        [chooseLevelScene setNextPopWillNotBeMenu: YES];    // Need to set because we are popping back TO rootviewcont.
        [self.navigationController popViewControllerAnimated: YES];
    }else{
        [self.navigationController popViewControllerAnimated: YES];
    }
}

- (IBAction)saveLevel:(id)sender{
    NSString *text = [levelName text];
    int width = [[levelWidth text] intValue];
    int height = [[levelHeight text] intValue];
    
    if(mode != 0 && ([text length] == 0 || [text length] > 16)){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Your level name is invalid." delegate:self cancelButtonTitle:@"Okay" otherButtonTitles: nil];
        [alert show];
        [alert release];
    }else if(mode == 0 && (width < 5 || width > 30 || height < 5 || height > 30)){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Your level's dimensions are invalid. They must be between\n5x5 and 30x30" delegate:self cancelButtonTitle:@"Okay" otherButtonTitles: nil];
        [alert show];
        [alert release];
    }else{
        if(mode == 0){
            [cls createWithWidth:width height:height];
            [self.navigationController popToRootViewControllerAnimated: YES];
        }else if(mode == 1){
            [les saveWithFileName: [NSString stringWithFormat:@"%@.txt", text]];
            AppDelegate *del = [[UIApplication sharedApplication] delegate];
            ChooseLevelScene *chooseLevelScene = (ChooseLevelScene *)[del navController].delegate;   // Not actually existing
            [chooseLevelScene setNextPopWillNotBeMenu: YES];                                         // in mode = 1
            [self.navigationController popViewControllerAnimated: YES];
        }else{
            [lsvc renameCustomLevel: text];
            [self.navigationController popViewControllerAnimated: YES];
        }
    }
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

#pragma mark - View lifecycle

- (void)viewDidLoad{
    [self.navigationController setNavigationBarHidden:YES animated:YES];

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
        [self.saveOverHintLabel setHidden: YES];
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
        [self.saveOverHintLabel setHidden: YES];
    }
    [super viewDidLoad];

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
