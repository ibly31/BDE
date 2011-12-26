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

@implementation SaveLevelViewController
@synthesize saveLevelLabel;
@synthesize fileName;
@synthesize fileNameSuggest;
@synthesize rvc;
@synthesize lsvc;
@synthesize les;

- (id)initWithNibName:(NSString *)nibNameOrNil rootViewController:(RootViewController *)rootViewController levelEditorScene:(LevelEditorScene *)levelEditorScene{
    self = [super initWithNibName:nibNameOrNil bundle:nil];
    if(self){
        self.rvc = rootViewController;
        self.les = levelEditorScene;
        
        change = NO;
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil levelSelectViewController:(LevelSelectViewController *)levelSelectViewController{
    self = [super initWithNibName:nibNameOrNil bundle:nil];
    if(self){
        self.lsvc = levelSelectViewController;
        
        change = YES;
    }
    return self;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if([string length] > 1 || [string length] > 20){
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
}

- (IBAction)goBack:(id)sender{
    if(change){
        [lsvc dismissViewControllerAnimated:YES completion:^(void){}];
    }else{
        [rvc dismissViewControllerAnimated:YES completion:^(void){}];
    }
}

- (IBAction)saveLevel:(id)sender{
    NSString *text = [fileName text];
    if([text length] == 0 || [text length] > 20){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Your level name is invalid." delegate:self cancelButtonTitle:@"Okay" otherButtonTitles: nil];
        [alert show];
        [alert release];
    }else{
        if(change){
            [lsvc renameCustomLevel: text];
            [lsvc dismissViewControllerAnimated:YES completion:^(void){}];
        }else{
            [les saveWithFileName: [NSString stringWithFormat:@"%@.txt", text]];
            [rvc dismissViewControllerAnimated:YES completion:^(void){}];
        }
        
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    if(fileNameSuggest != nil)
        [self.fileName setText: fileNameSuggest];
    [self.fileName becomeFirstResponder];
    [self.saveLevelLabel setFont: [UIFont fontWithName:@"Krungthep" size:18.0f]];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

@end
