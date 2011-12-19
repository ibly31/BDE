//
//  TileMap.m
//  BlockDudeEvolved
//
//  Created by Billy Connolly on 12/6/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "TileMap.h"
#import "GameScene.h"
#import "AppDelegate.h"

@implementation TileMap
@synthesize mapWidth;
@synthesize mapHeight;

- (id)initWithMap:(int)map gameScene:(GameScene *)gs{
    
    animate = [[NSUserDefaults standardUserDefaults] boolForKey:@"SpeedMode"];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"Level%i",map] ofType:@"txt"];
    NSString *string = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
	if(!string){
		NSLog(@"Could not load file %@", map);
        self = nil;
	}else{
        string = [string stringByReplacingOccurrencesOfString:@"\n" withString:@","];
        NSArray *lineStrings = [string componentsSeparatedByString:@","];
        if([lineStrings count] >= 2){
            mapWidth = [[lineStrings objectAtIndex: 0] intValue];
            mapHeight = [[lineStrings objectAtIndex: 1] intValue];
            
            self = [super initWithFile:@"Original.png" capacity:mapWidth * mapHeight];
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
                        if(value == 5){
                            [self setTileAtX:x Y:y value:0];
                            [gs setPlayerX: x];
                            [gs setPlayerY: y];
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
    return self;
}

- (void)setOffsetToCenterOn:(CGPoint)centerOn{
    [self setOffsetToCenterOn:centerOn animated:!animate];
}

- (void)setOffsetToCenterOn:(CGPoint)centerOn animated:(BOOL)animated{
    CGPoint flippedLocation = ccp(centerOn.x, 10.0f - centerOn.y);
    if(animated)
        [self runAction: [CCMoveTo actionWithDuration:0.05f position: ccp((flippedLocation.x * -32.0f) + 240.0f, (flippedLocation.y * -32.0f) + 176.0f)]];
    else
        [self setPosition: ccp((flippedLocation.x * -32.0f) + 240.0f, (flippedLocation.y * -32.0f) + 176.0f)];

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
    }
}

@end
