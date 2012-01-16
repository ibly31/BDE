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
@synthesize cls;
@synthesize customLevelArray;
@synthesize fileToChange;

- (id)initWithChooseLevelScene:(ChooseLevelScene *)chooseLevelScene{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if(self){
        self.cls = chooseLevelScene;
        self.title = @"Select Level";
        
        if([cls levelEditorMode]){
            UIBarButtonItem *toggleEdit = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(toggleEditing)];            
            UIBarButtonItem *addNew = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:cls action:@selector(addNew)];
            [self.navigationItem setRightBarButtonItems: [NSArray arrayWithObjects:toggleEdit, addNew, nil]];
            [toggleEdit release];
            [addNew release];
        }
        
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

- (void)viewDidLoad{
    self.tableView.allowsSelectionDuringEditing = YES;
    self.tableView.backgroundColor = [UIColor whiteColor];
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [super viewWillAppear:animated];
}

- (void)viewDidUnload{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation{
    return (interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
    [headerLabel setFont: [UIFont fontWithName:@"Krungthep" size:18.0f]];
    [headerLabel setTextColor: [UIColor grayColor]];
    if([cls levelEditorMode]){
        if(section == 0){
            [headerLabel setText:@"    Custom Levels"];
        }else{
            [headerLabel setText:@"    Default Levels"];
        }
    }else{
        if(section == 0){
            [headerLabel setText:@"    Default Levels"];
        }else{
            [headerLabel setText:@"    Custom Levels"];
        }
    }
    return headerLabel;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    if([cls levelEditorMode]){
        if(section == 0){
            return @"Custom Levels";
        }else{
            return @"Default Levels";
        }
    }else{
        if(section == 0){
            return @"Default Levels";
        }else{
            return @"Custom Levels";
        }
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if([cls levelEditorMode]){
        if(section == 1)
            return 22;
        else
            return [customLevelArray count];
    }else{
        if(section == 0)
            return 22;
        else
            return [customLevelArray count];
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
        if(indexPath.section == 1){
            cell.textLabel.text = [NSString stringWithFormat:@"Level %i", indexPath.row + 1];
        }else{
            cell.textLabel.text = [customLevelArray objectAtIndex: indexPath.row];
        }
    }else{
        if(indexPath.section == 0){
            cell.textLabel.text = [NSString stringWithFormat:@"Level %i", indexPath.row + 1];
        }else{
            cell.textLabel.text = [customLevelArray objectAtIndex: indexPath.row];
        }
    }
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([cls levelEditorMode]){
        if(indexPath.section == 0){
            return YES;
        }else{
            return NO;
        }
    }else{
        return NO;
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if(editingStyle == UITableViewCellEditingStyleDelete){
        NSString *fileToDelete = [customLevelArray objectAtIndex: indexPath.row];
        [self deleteCustomLevel: fileToDelete];
        [customLevelArray removeObjectAtIndex: indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } 
}

- (void)deleteCustomLevel:(NSString *)customLevel{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    customLevel = [NSString stringWithFormat:@"%@/%@.txt", [paths objectAtIndex:0], customLevel];
    [[NSFileManager defaultManager] removeItemAtPath:customLevel error:nil];
}

- (void)renameCustomLevel:(NSString *)newName{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *oldName = [customLevelArray objectAtIndex: fileToChange.row];
    [[NSFileManager defaultManager] moveItemAtPath:[NSString stringWithFormat:@"%@/%@.txt", [paths objectAtIndex:0], oldName] toPath:[NSString stringWithFormat:@"%@/%@.txt", [paths objectAtIndex:0], newName] error:nil];
    [customLevelArray replaceObjectAtIndex:fileToChange.row withObject:newName];
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

- (void)toggleEditing{
    if([self.tableView isEditing]){
        [self.tableView setEditing:NO animated:YES];
    }else{
        [self.tableView setEditing:YES animated:YES];
    }
}

#pragma mark - Table view delegate
                         
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    AppDelegate *del = [[UIApplication sharedApplication] delegate];
    UINavigationController *navController = [del navController];
    
    if([cls levelEditorMode]){
        if([indexPath section] == 1){
            [cls didSelectLevel: [NSString stringWithFormat:@"Level %i", [indexPath row] + 1] custom:NO];   // -1 to make first row be level 1
            [navController popToRootViewControllerAnimated:YES];
        }else{
            [cls didSelectLevel: [customLevelArray objectAtIndex:indexPath.row] custom:YES];
            [navController popToRootViewControllerAnimated:YES];
        }
    }else{
        if([indexPath section] == 0){
            [cls didSelectLevel: [NSString stringWithFormat:@"Level %i", [indexPath row] + 1] custom:NO];
            [navController popToRootViewControllerAnimated:YES];
        }else{
            [cls didSelectLevel: [customLevelArray objectAtIndex:indexPath.row] custom:YES];
            [navController popToRootViewControllerAnimated:YES];
        }
    }
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{
    self.fileToChange = indexPath;
    SaveLevelViewController *slvc = [[SaveLevelViewController alloc] initWithNibName:@"SaveLevelViewController" levelSelectViewController:self];
    slvc.fileNameSuggest = [customLevelArray objectAtIndex: indexPath.row];
    [self.navigationController pushViewController:slvc animated:YES];
    [slvc release];
}

@end
