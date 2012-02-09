//
//  LevelBrowserViewController.m
//  BlockDudeEvolved
//
//  Created by Billy Connolly on 1/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LevelBrowserViewController.h"
#import "LevelBrowserTableViewCell.h"
#import "ShareLevelViewController.h"
#import "AppDelegate.h"
#import "AmazonClientManager.h"

@implementation LevelBrowserViewController
@synthesize browserView;
@synthesize nameLabel;
@synthesize playCountLabel;
@synthesize filterSelector;
@synthesize saveLevelButton;
@synthesize mapPreviewView;
@synthesize levels;
@synthesize currentlySelectedLevel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Level Browser";
        nextRefreshIsFetching = YES;
        
        self.mapPreviewView = [[MapPreviewView alloc] initWithFrame:CGRectMake(300, 64, 150, 150)];
        [self.view addSubview: mapPreviewView];
        
        UIBarButtonItem *addNew = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(shareLevel)];
        [self.navigationItem setRightBarButtonItems: [NSArray arrayWithObjects:addNew, nil]];
        [addNew release];
        
        [self performSelector:@selector(populateLevelList) withObject:nil afterDelay:0.3f];
    }
    return self;
}

- (void)populateLevelList{
    @try
    {
        if(filterSelector.selectedSegmentIndex == 0){
            DynamoDBScanRequest  *request  = [[[DynamoDBScanRequest alloc] initWithTableName:@"BDELevels"] autorelease];
            DynamoDBScanResponse *response = [[AmazonClientManager ddb] scan:request];
            
            self.levels = response.items;
            nextRefreshIsFetching = NO;
            [browserView reloadData];
            [self changeSelectedLevel: 0];
            [browserView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];
        }else{
            GameCenterModel *gcm = [(AppDelegate *)[[UIApplication sharedApplication] delegate] gameCenterModel];
            NSString *playerID = nil;
            if([gcm isAuthenticated]){
                playerID = [GKLocalPlayer localPlayer].playerID;
            }else{
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"You must be logged in to GameCenter to share levels." delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil];
                [alert show];
                [alert release];
                [gcm authenticatePlayer];
                return;
            }
            
            DynamoDBQueryRequest *request = [[DynamoDBQueryRequest alloc] initWithTableName:@"BDELevels" andHashKeyValue:[[DynamoDBAttributeValue alloc] initWithS:playerID]];
            DynamoDBQueryResponse *response = [[AmazonClientManager ddb] query:request];
            
            self.levels = response.items;
            nextRefreshIsFetching = NO;
            [browserView reloadData];
            [self changeSelectedLevel: 0];
            [browserView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];
        }
    }
    @catch (NSException *exception)
    {
        NSLog(@"Exception: %@", exception);
    }
}

- (IBAction)saveLevel:(id)sender{
    NSString *data = [(DynamoDBAttributeValue *)[[levels objectAtIndex:currentlySelectedLevel] objectForKey:@"Data"] s];
    NSString *name = [(DynamoDBAttributeValue *)[[levels objectAtIndex:currentlySelectedLevel] objectForKey:@"Name"] s];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSArray *files = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:(NSString *)[paths objectAtIndex:0] error:nil];
    
    BOOL alreadyExists = NO;
    for(int x = 0; x < [files count]; x++){
        NSString *file = [files objectAtIndex: x];
        if([file compare: [NSString stringWithFormat:@"%@.txt", name]] == NSOrderedSame){
            alreadyExists = YES;
        }
    }
    
    if(alreadyExists){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:[NSString stringWithFormat:@"You already have a level titled \"%@\". Do you wish to overwrite?", name] delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
        [alert show];
        [alert release];
    }else{
        NSString *path = [NSString stringWithFormat:@"%@/%@.txt", (NSString *)[paths objectAtIndex:0], name];
        [data writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:nil];
    }
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    if(buttonIndex == 1){
        NSString *data = [(DynamoDBAttributeValue *)[[levels objectAtIndex:currentlySelectedLevel] objectForKey:@"Data"] s];
        NSString *name = [(DynamoDBAttributeValue *)[[levels objectAtIndex:currentlySelectedLevel] objectForKey:@"Name"] s];
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        
        NSString *path = [NSString stringWithFormat:@"%@/%@.txt", (NSString *)[paths objectAtIndex:0], name];
        [data writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:nil];
    }
}

- (IBAction)changeFilter:(id)sender{
    nextRefreshIsFetching = YES;
    [browserView reloadData];
    [self populateLevelList];
    
    if(filterSelector.selectedSegmentIndex == 1){
        UIBarButtonItem *edit = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(toggleEdit)];
        UIBarButtonItem *addNew = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(shareLevel)];
        [self.navigationItem setRightBarButtonItems: [NSArray arrayWithObjects:addNew, edit, nil]];
        [edit release];
        [addNew release];
    }else{
        UIBarButtonItem *addNew = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(shareLevel)];
        [self.navigationItem setRightBarButtonItems: [NSArray arrayWithObjects:addNew, nil]];
        [addNew release];
    }
}

- (void)changeSelectedLevel:(int)level{
    self.currentlySelectedLevel = level;
    [mapPreviewView reloadWithLevelData: [(DynamoDBAttributeValue *)[[levels objectAtIndex:level] objectForKey:@"Data"] s]];
    [nameLabel setText: [(DynamoDBAttributeValue *)[[levels objectAtIndex:level] objectForKey:@"Name"] s]];
    
    [saveLevelButton setEnabled: YES];
}

- (void)shareLevel{
    AppDelegate *del = [[UIApplication sharedApplication] delegate];
    UINavigationController *navController = [del navController];
    
    ShareLevelViewController *slvc = [[ShareLevelViewController alloc] initWithNibName:@"ShareLevelViewController" bundle:nil];
    [navController pushViewController:slvc animated:YES];
    [slvc release];
}

- (void)toggleEdit{
    if(browserView.isEditing)
        [browserView setEditing:NO animated:YES];
    else
        [browserView setEditing:YES animated:YES];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(nextRefreshIsFetching){
        [tableView deselectRowAtIndexPath:indexPath animated:NO];
    }else{
        [self changeSelectedLevel: indexPath.row];
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    if(filterSelector.selectedSegmentIndex == 1){
        return YES;
    }else{
        return NO;
    }
}

- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if(editingStyle == UITableViewCellEditingStyleDelete){
        NSLog(@"Deleting file %@ up on the server...", [(DynamoDBAttributeValue *)[[levels objectAtIndex:indexPath.row] objectForKey:@"Name"] s]);
        [levels removeObjectAtIndex: indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    
    LevelBrowserTableViewCell *cell = (LevelBrowserTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[LevelBrowserTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    if(nextRefreshIsFetching){
        [[cell levelNameLabel] setText: @"  Getting Levels..."];
        [[cell levelDifficultyLabel] setText:@""];
        [[cell levelDLCountLabel] setText:@""];
        [[cell loadingIndicator] startAnimating];
    }else if([levels count] == 0){
        [[cell levelNameLabel] setText: @"  No Levels Listed"];
        [[cell levelDifficultyLabel] setText:@""];
        [[cell levelDLCountLabel] setText:@""];
        [[cell loadingIndicator] stopAnimating];
    }else{
        [[cell levelNameLabel] setText: [(DynamoDBAttributeValue *)[[levels objectAtIndex:indexPath.row] objectForKey:@"Name"] s]];
        [[cell loadingIndicator] stopAnimating];
        
        NSInteger difficulty = [[(DynamoDBAttributeValue *)[[levels objectAtIndex:indexPath.row] objectForKey:@"Difficulty"] n] integerValue];
        NSInteger dlCount = [[(DynamoDBAttributeValue *)[[levels objectAtIndex:indexPath.row] objectForKey:@"DLCount"] n] integerValue];        
        
        [[cell levelDLCountLabel] setText: [NSString stringWithFormat: @"Downloads: %i", dlCount]];
        
        switch(difficulty){
            case 0:
                [[cell levelDifficultyLabel] setText:@"HARD"];
                [[cell levelDifficultyLabel] setTextColor: [UIColor redColor]];
                break;
            case 1:
                [[cell levelDifficultyLabel] setText:@"MED-HARD"];
                [[cell levelDifficultyLabel] setTextColor: [UIColor orangeColor]];
                break;
            case 2:
                [[cell levelDifficultyLabel] setText:@"MEDIUM"];
                [[cell levelDifficultyLabel] setTextColor: [UIColor yellowColor]];
                break;
            case 3:
                [[cell levelDifficultyLabel] setText:@"EASY-MED"];
                [[cell levelDifficultyLabel] setTextColor: [UIColor colorWithRed:0.6f green:0.8f blue:0.2f alpha:1.0f]];
                break;
            case 4:
                [[cell levelDifficultyLabel] setText:@"EASY"];
                [[cell levelDifficultyLabel] setTextColor: [UIColor greenColor]];
                break;
            case 5:
                [[cell levelDifficultyLabel] setText:@"FUN"];
                [[cell levelDifficultyLabel] setTextColor: [UIColor colorWithRed:1.0f green:0.57 blue:0.73 alpha:1.0f]];
                break;
            default:
                [[cell levelDifficultyLabel] setText:@"MEDIUM"];
                [[cell levelDifficultyLabel] setTextColor: [UIColor yellowColor]];
                break;
                
        }
    }
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(nextRefreshIsFetching == YES)
        return 1;
    else if([levels count] != 0)
        return [levels count];
    else
        return 1;
}

#pragma mark - View lifecycle

- (void)viewDidLoad{
    [browserView setBackgroundColor: [UIColor whiteColor]];
    //[browserView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];
    [super viewDidLoad];     
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
