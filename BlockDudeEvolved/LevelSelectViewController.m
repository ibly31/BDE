//
//  LevelSelectViewController.m
//  BlockDudeEvolved
//
//  Created by Billy Connolly on 12/23/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "LevelSelectViewController.h"
#import "ChooseLevelScene.h"
#import "AppDelegate.h"
#import "SaveLevelViewController.h"

@implementation LevelSelectViewController
@synthesize rvc;
@synthesize cls;
@synthesize customLevelArray;
@synthesize fileToChange;

- (id)initWithRVC:(RootViewController *)rootViewController chooseLevelScene:(ChooseLevelScene *)chooseLevelScene{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if(self){
        self.rvc = rootViewController;
        self.cls = chooseLevelScene;
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSArray *files = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:(NSString *)[paths objectAtIndex:0] error:nil];

        self.customLevelArray = [[NSMutableArray alloc] init];
        for(int x = 0; x < [files count]; x++){
            NSString *file = [files objectAtIndex: x];
            if([file length] >= 5){
                NSString *sub = [file substringFromIndex: [file length] - 4];
                if([sub compare: @".txt"] == NSOrderedSame){
                    [customLevelArray addObject: [file substringToIndex: [file length] - 4]];
                }
            }
        }
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.allowsSelectionDuringEditing = YES;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if(section == 0){
        return @"Default Levels";
    }else{
        return @"Custom Levels";
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0)
        return 23;
    else if([cls levelEditorMode]){
        return [customLevelArray count] + 1; // includes "edit" button
    }else{
        return [customLevelArray count];     // discludes "edit" button

    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        cell.textLabel.font = [UIFont fontWithName:@"Krungthep" size:18.0f];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.backgroundColor = [UIColor blackColor];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        cell.editingAccessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    }
    
    if([cls levelEditorMode]){
        if(indexPath.section == 0 && indexPath.row == 0){
            cell.textLabel.text = @"Go Back";
        }else if(indexPath.section == 1 && indexPath.row == 0){
            cell.textLabel.text = @"Edit";
        }else if(indexPath.section == 0){
            cell.textLabel.text = [NSString stringWithFormat:@"Level %i", indexPath.row];
        }else{
            cell.textLabel.text = [customLevelArray objectAtIndex: indexPath.row - 1];
        }
    }else{
        if(indexPath.section == 0 && indexPath.row == 0){
            cell.textLabel.text = @"Go Back";
        }else if(indexPath.section == 0){
            cell.textLabel.text = [NSString stringWithFormat:@"Level %i", indexPath.row];
        }else{
            cell.textLabel.text = [customLevelArray objectAtIndex: indexPath.row];
        }
    }
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([cls levelEditorMode]){
        if(indexPath.section == 1 && indexPath.row != 0){
            return YES;
        }else{
            return NO;
        }
    }else{
        return NO;
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(editingStyle == UITableViewCellEditingStyleDelete){
        NSString *fileToDelete = [customLevelArray objectAtIndex: indexPath.row - 1];
        [customLevelArray removeObjectAtIndex: indexPath.row - 1];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [self deleteCustomLevel: fileToDelete];
    } 
}

- (void)deleteCustomLevel:(NSString *)customLevel{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    customLevel = [NSString stringWithFormat:@"%@/%@.txt", [paths objectAtIndex:0], customLevel];
    [[NSFileManager defaultManager] removeItemAtPath:customLevel error:nil];
}

- (void)renameCustomLevel:(NSString *)newName{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSLog(@"%i", fileToChange.row);
    NSString *oldName = [customLevelArray objectAtIndex: fileToChange.row - 1];
    [customLevelArray replaceObjectAtIndex:fileToChange.row - 1 withObject:newName];
    [[NSFileManager defaultManager] moveItemAtPath:[NSString stringWithFormat:@"%@/%@.txt", [paths objectAtIndex:0], oldName] toPath:[NSString stringWithFormat:@"%@/%@.txt", [paths objectAtIndex:0], newName] error:nil];
    UITableViewCell *cellToChange = [self.tableView cellForRowAtIndexPath: fileToChange];
    [cellToChange.textLabel setText: newName];
}

- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath{
    return NO;
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate
                         
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if([cls levelEditorMode]){
        if(indexPath.section == 1 && indexPath.row == 0){
            if(tableView.editing)
                [tableView setEditing:NO animated:YES];
            else
                [tableView setEditing:YES animated:YES];
            return;
        }
    }
    
    if([indexPath section] == 0){
        [cls didSelectLevel: [NSString stringWithFormat:@"Level %i", [indexPath row]] custom:NO];
        [rvc dismissViewControllerAnimated:YES completion:^(void){}];
    }else if([cls levelEditorMode]){
        [cls didSelectLevel: [customLevelArray objectAtIndex:indexPath.row - 1] custom:YES];    // -1 for edit
        [rvc dismissViewControllerAnimated:YES completion:^(void){}];
    }else{
        [cls didSelectLevel: [customLevelArray objectAtIndex:indexPath.row] custom:YES];        // not -1 for edit
        [rvc dismissViewControllerAnimated:YES completion:^(void){}];
    }
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{
    self.fileToChange = indexPath;
    SaveLevelViewController *slvc = [[SaveLevelViewController alloc] initWithNibName:@"SaveLevelViewController" levelSelectViewController:self];
    slvc.fileNameSuggest = [customLevelArray objectAtIndex: indexPath.row - 1];
    [self presentViewController:slvc animated:YES completion:^(void){}];
}

@end
