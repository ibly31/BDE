//
//  ShareLevelViewController.m
//  BlockDudeEvolved
//
//  Created by Billy Connolly on 1/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ShareLevelViewController.h"
#import "LevelBrowserTableViewCell.h"
#import "AmazonClientManager.h"
#import "AmazonKeyChainWrapper.h"
#import <GameKit/GameKit.h>
#import "AppDelegate.h"
#import "GameCenterModel.h"

@implementation ShareLevelViewController
@synthesize difficultyPicker;
@synthesize sendingView;
@synthesize sendingLabel;
@synthesize nameLabel;
@synthesize sizeLabel;
@synthesize levelView;
@synthesize customLevelArray;
@synthesize currentlySelectedLevel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Share Level";
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

- (void)didReceiveMemoryWarning{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (IBAction)upload:(id)sender{
    [sendingView startAnimating];
    [sendingLabel setHidden: NO];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [NSString stringWithFormat:@"%@/%@.txt", (NSString *)[paths objectAtIndex:0], currentlySelectedLevel];
    
    NSString *string = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
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
    
    DynamoDBQueryRequest *checkRequest = [[DynamoDBQueryRequest alloc] initWithTableName:@"BDELevels" andHashKeyValue:[[DynamoDBAttributeValue alloc] initWithS:playerID]];
    DynamoDBQueryResponse *checkResponse = [[AmazonClientManager ddb] query: checkRequest];
    
    BOOL alreadyExists = NO;
    if(checkResponse.items.count != 0){
        for(int x = 0; x < checkResponse.items.count; x++){
            if([[(DynamoDBAttributeValue *)[[checkResponse.items objectAtIndex: x] objectForKey:@"Name"] s] compare: currentlySelectedLevel] == NSOrderedSame){
                alreadyExists = YES;
            }
        }
    }
    
    if(alreadyExists){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Overwrite" message:[NSString stringWithFormat:@"You have already shared a level named %@. Do you wish to overwrite?", currentlySelectedLevel] delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Overwrite", nil];
        [alert show];
        [alert release];
        currentPlayerID = playerID;
        currentLevelData = string;
    }else{
        @try{
            NSMutableDictionary *levelDict = 
            [NSDictionary dictionaryWithObjectsAndKeys:[[[DynamoDBAttributeValue alloc] initWithS:playerID] autorelease], @"UserID",
             [[[DynamoDBAttributeValue alloc] initWithS:currentlySelectedLevel] autorelease], @"Name",
             [[[DynamoDBAttributeValue alloc] initWithN:@"0"] autorelease], @"DLCount",
             [[[DynamoDBAttributeValue alloc] initWithN:[NSString stringWithFormat:@"%i", [difficultyPicker selectedRowInComponent:0]]] autorelease], @"Difficulty",
             [[[DynamoDBAttributeValue alloc] initWithS:string] autorelease], @"Data",
             nil];
            
            DynamoDBPutItemRequest *request = [[[DynamoDBPutItemRequest alloc] initWithTableName:@"BDELevels" andItem:levelDict] autorelease];
            [[AmazonClientManager ddb] putItem:request];
            
            [sendingView stopAnimating];
            [sendingLabel setHidden: YES];
            
        }
        @catch (NSException *exception){
            NSLog(@"Exception: %@", exception);
        }
    }
}

- (void)selectLevel:(NSString *)level{
    self.currentlySelectedLevel = level;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [NSString stringWithFormat:@"%@/%@.txt", (NSString *)[paths objectAtIndex:0], level];

    NSString *string = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    if(string != nil){
        string = [string stringByReplacingOccurrencesOfString:@"\n" withString:@","];
        NSArray *lineStrings = [string componentsSeparatedByString:@","];
        if([lineStrings count] >= 27){ // 5*5
            int mapWidth = [[lineStrings objectAtIndex: 0] intValue];
            int mapHeight = [[lineStrings objectAtIndex: 1] intValue];
            [sizeLabel setText: [NSString stringWithFormat:@"%i x %i", mapWidth, mapHeight]];
        }
        [nameLabel setText: level];
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Could not load level." delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles: nil];
        [alert show];
        [alert release];
    }
}

#pragma mark - Delegate/Datasource methods

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    if(buttonIndex == 1){
        @try{
            NSMutableDictionary *levelDict = 
            [NSDictionary dictionaryWithObjectsAndKeys:[[[DynamoDBAttributeValue alloc] initWithS:currentPlayerID] autorelease], @"UserID",
             [[[DynamoDBAttributeValue alloc] initWithS:currentlySelectedLevel] autorelease], @"Name",
             [[[DynamoDBAttributeValue alloc] initWithN:@"0"] autorelease], @"DLCount",
             [[[DynamoDBAttributeValue alloc] initWithN:[NSString stringWithFormat:@"%i", [difficultyPicker selectedRowInComponent:0]]] autorelease], @"Difficulty",
             [[[DynamoDBAttributeValue alloc] initWithS:currentLevelData] autorelease], @"Data",
             nil];
            
            DynamoDBPutItemRequest *request = [[[DynamoDBPutItemRequest alloc] initWithTableName:@"BDELevels" andItem:levelDict] autorelease];
            [[AmazonClientManager ddb] putItem:request];
            
            [sendingView stopAnimating];
            [sendingLabel setHidden: YES];
            
        }
        @catch (NSException *exception){
            NSLog(@"Exception: %@", exception);
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    
    LevelBrowserTableViewCell *cell = (LevelBrowserTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil){
        cell = [[[LevelBrowserTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        [cell.levelDifficultyLabel setHidden: YES];
        [cell.levelDLCountLabel setHidden: YES];
    }
    
    if([customLevelArray count] != 0){
        cell.levelNameLabel.text = [customLevelArray objectAtIndex: indexPath.row];
    }else{
        cell.levelNameLabel.text = @"  No Custom Levels";
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if([customLevelArray count] == 0){
        [tableView deselectRowAtIndexPath:indexPath animated:NO];
    }else{
        [self selectLevel: [customLevelArray objectAtIndex: indexPath.row]];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    int count = [customLevelArray count];
    if(count == 0)
        return 1;
    else
        return count;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return 6;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel *label = [[UILabel alloc] initWithFrame: CGRectMake(0, 0, 200, 22)];
    [label setFont: [UIFont boldSystemFontOfSize: 20.0f]];
    [label setText: [[NSArray arrayWithObjects:@"Hard", @"Med-Hard", @"Medium", @"Easy-Med", @"Easy", @"Fun", nil] objectAtIndex:row]];
    [label setBackgroundColor: [UIColor clearColor]];
    return label;
}


#pragma mark - View lifecycle

- (void)selectDefaultDifficulty{
    [difficultyPicker selectRow:2 inComponent:0 animated:NO];
}

- (void)viewDidLoad{
    [levelView setBackgroundColor: [UIColor whiteColor]];
    if([customLevelArray count] != 0){
        [levelView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];
        [self selectLevel: [customLevelArray objectAtIndex: 0]];
    }
        
    [self performSelector:@selector(selectDefaultDifficulty) withObject:nil afterDelay:0.1f];   //workaround
    [super viewDidLoad];
}

- (void)viewDidUnload{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

@end
