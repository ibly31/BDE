//
//  TileMap.m
//  BlockDudeEvolved
//
//  Created by Billy Connolly on 12/6/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "TileMap.h"
#import "GameScene.h"
#import "LevelEditorScene.h"
#import "AppDelegate.h"

@implementation TileMap
@synthesize mapWidth;
@synthesize mapHeight;

- (id)init{
    animate = [[NSUserDefaults standardUserDefaults] boolForKey:@"SpeedMode"];
    self = [super initWithFile:@"Original.png" capacity:560];   // 28*20, max size
    if(self){
        
    }
    return self;
}

- (void)loadMapWithString:(NSString *)mapName custom:(BOOL)custom{
    NSString *path;
    if(custom){
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        path = [NSString stringWithFormat:@"%@/%@.txt", (NSString *)[paths objectAtIndex:0], mapName];
    }else{
        path = [[NSBundle mainBundle] pathForResource:mapName ofType:@"txt"];
    }
    
    NSString *string = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
	if(!string){
		NSLog(@"Could not load file %@", path);
        self = nil;
	}else{
        string = [string stringByReplacingOccurrencesOfString:@"\n" withString:@","];
        NSArray *lineStrings = [string componentsSeparatedByString:@","];
        if([lineStrings count] >= 2){
            mapWidth = [[lineStrings objectAtIndex: 0] intValue];
            mapHeight = [[lineStrings objectAtIndex: 1] intValue];
            
            if(self){
                for(int y = 0; y < mapHeight; y++){
                    for(int x = 0; x < mapWidth; x++){
                        CCSprite *currentSprite = [[CCSprite alloc] initWithTexture:[self texture] rect:CGRectMake(0, 0, 32, 32)];
                        [currentSprite setPosition: ccp(x * 32, 304 - (y * 32))];
                        [currentSprite setScale: 32.0f/32.0f];
                        [self addChild: currentSprite];
                        [currentSprite release];
                    }
                }
            }
            
            int index = 2;
            if(mapWidth * mapHeight == [lineStrings count] - 2){    // minus two for the width and height "header"
                for(int y = 0; y < mapHeight; y++){
                    for(int x = 0; x < mapWidth; x++){
                        int value = [[lineStrings objectAtIndex: index] intValue];
                        if(value == 3){
                            if([parent_ isKindOfClass: [GameScene class]]){
                                [self setTileAtX:x Y:y value:0];
                                [(GameScene *)parent_ setPlayerX: x];
                                [(GameScene *)parent_ setPlayerY: y];
                            }else{
                                [(LevelEditorScene *)parent_ setCurrentPlayerPosition: ccp(x,y)];
                                [self setTileAtX:x Y:y value:3];
                            }
                        }else if(value == 4 && [parent_ isKindOfClass: [LevelEditorScene class]]){
                            [(LevelEditorScene *)parent_ setCurrentExitPosition: ccp(x,y)];
                            [self setTileAtX:x Y:y value:[[lineStrings objectAtIndex: index] intValue]];
                        }else{
                            [self setTileAtX:x Y:y value:[[lineStrings objectAtIndex: index] intValue]];
                        }
                        index++;
                    }
                }
            }else{
                NSLog(@"Mapwidth * mapheight does not equal linestrings count");
            }
        }else{
            NSLog(@"Linestrings count < 2");
            self = nil;
        }
    }
}

- (void)createMapWithWidth:(int)width height:(int)height{
    mapWidth = width;
    mapHeight = height;
            
    for(int y = 0; y < mapHeight; y++){
        for(int x = 0; x < mapWidth; x++){
            CCSprite *currentSprite = [[CCSprite alloc] initWithTexture:[self texture] rect:CGRectMake(0, 0, 32, 32)];
            [currentSprite setPosition: ccp(x * 32, 304 - (y * 32))];
            [currentSprite setScale: 32.0f/32.0f];
            [self addChild: currentSprite];
            [currentSprite release];
        }
    }
}

- (NSString *)dataString{
    NSMutableString *string = [[NSMutableString alloc] initWithFormat:@"%i,%i,", mapWidth, mapHeight];
    for(int y = 0; y < mapHeight; y++){
        for(int x = 0; x < mapWidth; x++){
            int whichTile = [self tileAtX:x Y:y];
            [string appendFormat:@"%i", whichTile];
            if(x < mapWidth - 1)
                [string appendString:@","];
        }
        if(y < mapHeight - 1)
            [string appendString:@"\n"];
    }
    return string;
}

- (void)toggleOutlines{
    for(int index = 0; index < [children_ count]; index++){
        CCSprite *childAtIndex = (CCSprite *)[children_ objectAtIndex: index];
        [childAtIndex setScale:0.96875f];   // 31/32 so that 1 pixel border shows
    }
}

- (void)levelEditAnimation:(BOOL)which{
    if(which){
        for(int index = 0; index < [children_ count]; index++){
            CCSprite *childAtIndex = (CCSprite *)[children_ objectAtIndex: index];
            [childAtIndex setScale:0.0f];   // 31/32 so that 1 pixel border shows
            [childAtIndex setRotation: CCRANDOM_0_1() * 1080.0f];
        }
    }else {
        for(int index = 0; index < [children_ count]; index++){
            CCSprite *childAtIndex = (CCSprite *)[children_ objectAtIndex: index];
            [childAtIndex runAction: [CCScaleTo actionWithDuration:CCRANDOM_0_1() * 0.25f + 0.35f scale:0.96875f]];
            [childAtIndex runAction: [CCRotateTo actionWithDuration:CCRANDOM_0_1() * 0.25f + 0.35f angle:0.0f]];
            //[childAtIndex setScale:0.96875f];   // 31/32 so that 1 pixel border shows
        }
    }
}

- (void)setOffsetToCenterOn:(CGPoint)centerOn{
    [self setOffsetToCenterOn:centerOn animated:!animate];
}

- (void)setOffsetToCenterOn:(CGPoint)centerOn animated:(BOOL)animated{
    CGPoint flippedLocation = ccp(centerOn.x, 10.0f - centerOn.y);
    
    if([parent_ class] == [GameScene class]){
        if(animated)
            [self runAction: [CCMoveTo actionWithDuration:0.05f position: ccp((flippedLocation.x * -32.0f) + 240.0f, (flippedLocation.y * -32.0f) + 176.0f)]];
        else
            [self setPosition: ccp((flippedLocation.x * -32.0f) + 240.0f, (flippedLocation.y * -32.0f) + 176.0f)];
    }else{
        if(animated)
            [self runAction: [CCMoveTo actionWithDuration:0.15f position: ccp((flippedLocation.x * -32.0f) + 256.0f, (flippedLocation.y * -32.0f) + 160.0f)]];
        else
            [self setPosition: ccp((flippedLocation.x * -32.0f) + 256.0f, (flippedLocation.y * -32.0f) + 160.0f)];
    }
}

- (void)setTileAtX:(int)x Y:(int)y value:(int)value{
    int index = (y*mapWidth) + x;
    if(index >= 0 && index < mapWidth * mapHeight){
        CCSprite *childAtIndex = (CCSprite *)[children_ objectAtIndex: index];
        [childAtIndex setDisplayFrame: [CCSpriteFrame frameWithTexture:[childAtIndex texture] rect:CGRectMake(value * 32, 0, 32, 32)]];
    }else{
        NSLog(@"Cannot set tile (%i,%i), out of bounds.", x, y);
    }
}

- (int)tileAtX:(int)x Y:(int)y{
    int index = (y*mapWidth) + x;
    if(x >= mapWidth || y >= mapHeight || x < 0 || y < 0)
        return 1;
    if(index >= 0 && index < mapWidth * mapHeight){
        CCSprite *childAtIndex = (CCSprite *)[children_ objectAtIndex: index];
        CCSpriteFrame *dframe = [childAtIndex displayedFrame];
        CGRect rect = [dframe rect];
        int value = rect.origin.x / 32;                             // Extremely shitty way to store data, but necessary
        if((int)rect.origin.x % 32 != 0){
            NSLog(@"Rect origin not correctly dividing by 32.");
        }
        return value;
    }else{
        NSLog(@"Cannot get tile (%i,%i), out of bounds.", x, y);
        return 1;           // Fake a brick block, for OOB checks
        // This code should never even be called due to earlier checks
    }
}

- (CGSize)mapSize{
    return CGSizeMake(mapWidth, mapHeight);
}

- (CGPoint)whichTile:(CGPoint)touchLocation{

    for(int index = 0; index < [children_ count]; index++){
        CCSprite *childAtIndex = (CCSprite *)[children_ objectAtIndex: index];
        CGPoint childNodeSpace = [childAtIndex convertToNodeSpaceAR: touchLocation];
        if(fabsf(childNodeSpace.x) <= 16.0f && fabsf(childNodeSpace.y) <= 16.0f){
            int x = index % mapWidth;
            int y = index / mapWidth;
            return ccp(x,y);
        }
    }
    return ccp(-1,-1);
}

- (CGPoint)countPlayerAndExits{
    CGPoint both = ccp(0,0);
    for(int x = 0; x < mapWidth; x++){
        for(int y = 0; y < mapHeight; y++){
            int tileAt = [self tileAtX:x Y:y];
            if(tileAt == 3)
                both.x++;
            if(tileAt == 4)
                both.y++;
        }
    }
    return both;
}

@end
