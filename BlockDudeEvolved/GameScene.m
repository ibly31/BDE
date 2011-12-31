//
//  GameScene.m
//  BlockDudeEvolved
//
//  Created by Billy Connolly on 12/6/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "GameScene.h"
#import "GameOverScene.h"
#import "InputLayerDPad.h"
#import "InputLayerButtons.h"

enum {
    O_NONE=0,
    O_UP,
    O_RIGHT,
    O_DOWN,
    O_LEFT
};

@implementation GameScene
@synthesize map;
@synthesize inputLayer;
@synthesize timeLabel;

@synthesize player;
@synthesize carryingBlock;

@synthesize currentLevel;
@synthesize currentCustom;

- (id)initWithLevel:(NSString *)level custom:(BOOL)custom{
    self = [super init];
    if(self){
        self.currentLevel = level;
        self.currentCustom = custom;
        
        moves = 0;
        startInterval = [[NSDate date] timeIntervalSince1970];
        discountInterval = 0.0f;
        
        CCLayerColor *background = [[CCLayerColor alloc] initWithColor: ccc4(255, 255, 255, 255) width:480 height:320];
        [self addChild: background];
        
        self.playerX = -1;
        self.playerY = -1; // Easy check to see if it was set in map load
        
        facingLeft = YES;
        
        self.map = [[TileMap alloc] init];
        [self addChild: map];
        [map loadMapWithString:level custom:custom];
        if(playerX == -1 && playerY == -1){
            NSLog(@"Never set playerlocation. Defaulting to 1,1");
            playerX = 1; playerY = 1;
        }
                                                                                  // 96 = 32x3
        self.player = [[CCSprite alloc] initWithFile:@"Original.png" rect:CGRectMake(96, 0, 32, 32)];
        [player setPosition: ccp(240.0f, 160.0f)];
        [self addChild: player];
        
        self.carryingBlock = [[CCSprite alloc] initWithTexture:[map texture] rect:CGRectMake(64, 0, 32, 32)];
        [carryingBlock setPosition: ccp(240.0f, 192.0f)];
        [carryingBlock setVisible: NO];
        [self addChild: carryingBlock];
        
        [map setOffsetToCenterOn: ccp(playerX, playerY)];
        
        self.timeLabel = [[CCLabelAtlas alloc] initWithString:@"" charMapFile:@"FontOutline.png" itemWidth:16 itemHeight:24 startCharMap:'-'];
        [timeLabel setAnchorPoint: ccp(0.0f, 1.0f)];
        [timeLabel setPosition: ccp(8, 312)];
        [self addChild: timeLabel];
        
        /*self.moveLabel = [[CCLabelAtlas alloc] initWithString:@"Moves: 0" charMapFile:@"FontOutline.png" itemWidth:16 itemHeight:24 startCharMap:'-'];
        [moveLabel setColor: ccc3(255, 255, 255)];
        [moveLabel setAnchorPoint: ccp(1.0f, 1.0f)];
        [moveLabel setPosition: ccp(360, 304)];
        [self addChild: moveLabel];*/
        
        int controlScheme = [[NSUserDefaults standardUserDefaults] integerForKey: @"ControlScheme"];
        if(controlScheme == 1)
            self.inputLayer = (CCLayer *)[[InputLayerDPad alloc] init];
        else if(controlScheme == 2 || controlScheme == 3)
            self.inputLayer = (CCLayer *)[[InputLayerButtons alloc] init];
        else
            NSLog(@"Control scheme != 1 or 2");
    
        [self addChild: inputLayer];
        
        [self schedule:@selector(updateTimeLabel) interval:.01f];
        
        [self schedule:@selector(fall) interval:0.5f];    // Make sure no floating spawns
    }
    return self;
}

- (void)winGame{
    [self unscheduleAllSelectors];
    [(InputLayerButtons *)inputLayer setAcceptInput: NO];
    
    
    NSTimeInterval sinceSeventy = [[NSDate date] timeIntervalSince1970];
    
    GameOverScene *gos = [[GameOverScene alloc] initWithMoves:moves timeTaken:sinceSeventy - startInterval level:currentLevel];
    [[CCDirector sharedDirector] replaceScene: [CCTransitionFade transitionWithDuration:0.5f scene:gos]];
    [gos release];
}

- (void)moveInDirection:(int)direction{
    if(direction == O_LEFT){
        if(![carryingBlock visible]){
            int blockToLeft = [map tileAtX:playerX-1 Y:playerY];
            if(blockToLeft == 0){
                playerX--;
                [map setOffsetToCenterOn: ccp(playerX, playerY)];
                moves++;
                [self fall];
            }else if(blockToLeft == 4){
                playerX--;
                [map setOffsetToCenterOn: ccp(playerX, playerY)];
                moves++;
                [self winGame];
            }
        }else{
            int blockToLeft = [map tileAtX:playerX-1 Y:playerY];
            int blockToLUp = [map tileAtX:playerX-1 Y:playerY-1];
            if(blockToLeft == 0 && blockToLUp == 0){
                playerX--;
                [map setOffsetToCenterOn: ccp(playerX, playerY)];
                moves++;
                [self fall];
            }else if(blockToLeft == 4 && blockToLUp == 0){
                playerX--;
                [map setOffsetToCenterOn: ccp(playerX, playerY)];
                moves++;
                [self winGame];
            }
        }
        facingLeft = YES;
        [player setScaleX: 1.0f];
    }else if(direction == O_RIGHT){
        if(![carryingBlock visible]){
            int blockToRight = [map tileAtX:playerX+1 Y:playerY];
            if(blockToRight == 0){
                playerX++;
                [map setOffsetToCenterOn: ccp(playerX, playerY)];
                moves++;
                [self fall];
            }else if(blockToRight == 4){
                playerX++;
                [map setOffsetToCenterOn: ccp(playerX, playerY)];
                moves++;
                [self winGame];
            }
        }else{
            int blockToRight = [map tileAtX:playerX+1 Y:playerY];
            int blockToRUp = [map tileAtX:playerX+1 Y:playerY-1];
            if(blockToRight == 0 && blockToRUp == 0){
                playerX++;
                [map setOffsetToCenterOn: ccp(playerX, playerY)];
                moves++;
                [self fall];
            }else if(blockToRight == 4 && blockToRUp == 0){
                playerX++;
                [map setOffsetToCenterOn: ccp(playerX, playerY)];
                moves++;
                [self winGame];
            }
        }
        facingLeft = NO;
        [player setScaleX: -1.0f];
    }else if(direction == O_UP){
        if(![carryingBlock visible]){
            if(facingLeft){
                int blockToLeft = [map tileAtX:playerX-1 Y:playerY];
                int blockToLUp = [map tileAtX:playerX-1 Y:playerY-1];
                int blockToUp = [map tileAtX:playerX Y:playerY-1];
                if(blockToLeft != 4 && blockToLeft != 0 && blockToLUp == 0 && blockToUp == 0){
                    playerX--;
                    playerY--;
                    [map setOffsetToCenterOn: ccp(playerX, playerY)];
                    moves++;
                }else if(blockToLeft != 0 && blockToLUp == 4){
                    playerX--;
                    playerY--;
                    [map setOffsetToCenterOn: ccp(playerX, playerY)];
                    moves++;
                    [self winGame];
                }
            }else{
                int blockToRight = [map tileAtX:playerX+1 Y:playerY];
                int blockToRUp = [map tileAtX:playerX+1 Y:playerY-1];
                int blockToUp = [map tileAtX:playerX Y:playerY-1];
                if(blockToRight != 4 && blockToRight != 0 && blockToRUp == 0 && blockToUp == 0){
                    playerX++;
                    playerY--;
                    [map setOffsetToCenterOn: ccp(playerX, playerY)];
                    moves++;
                }else if(blockToRight != 0 && blockToRUp == 4){
                    playerX++;
                    playerY--;
                    [map setOffsetToCenterOn: ccp(playerX, playerY)];
                    moves++;
                    [self winGame];
                }
            }
        }else{
            if(facingLeft){
                int blockToLeft = [map tileAtX:playerX-1 Y:playerY];
                int blockToLUp = [map tileAtX:playerX-1 Y:playerY-1];
                int blockToLUUp = [map tileAtX:playerX-1 Y:playerY-2];
                if(blockToLeft != 0 && blockToLUp == 0 && blockToLUUp == 0){
                    playerX--;
                    playerY--;
                    [map setOffsetToCenterOn: ccp(playerX, playerY)];
                    moves++;
                }else if(blockToLeft != 0 && blockToLUp == 4 && blockToLUUp == 0){
                    playerX--;
                    playerY--;
                    [map setOffsetToCenterOn: ccp(playerX, playerY)];
                    moves++;
                    [self winGame];
                }
            }else{
                int blockToRight = [map tileAtX:playerX+1 Y:playerY];
                int blockToRUp = [map tileAtX:playerX+1 Y:playerY-1];
                int blockToRUUp = [map tileAtX:playerX+1 Y:playerY-2];
                if(blockToRight != 0 && blockToRUp == 0 && blockToRUUp == 0){
                    playerX++;
                    playerY--;
                    [map setOffsetToCenterOn: ccp(playerX, playerY)];
                    moves++;
                }else if(blockToRight != 0 && blockToRUp == 4 && blockToRUUp == 0){
                    playerX++;
                    playerY--;
                    [map setOffsetToCenterOn: ccp(playerX, playerY)];
                    moves++;
                    [self winGame];
                }
            }
        }
    }else if(direction == O_DOWN){
        if([carryingBlock visible]){
            if(facingLeft){
                int blockToLeft = [map tileAtX:playerX-1 Y:playerY];
                int blockToLUp = [map tileAtX:playerX-1 Y:playerY-1];
                if(blockToLeft == 0){
                    [carryingBlock setVisible: NO];
                    [map setTileAtX:playerX-1 Y:playerY value:2];
                    moves++;
                    [self blockFall: ccp(playerX-1, playerY)];
                }else if(blockToLUp == 0){
                    [carryingBlock setVisible: NO];
                    [map setTileAtX:playerX-1 Y:playerY-1 value:2];
                    moves++;
                    // No need to blockfall because we already know the block below is != 0
                }
            }else{
                int blockToRight = [map tileAtX:playerX+1 Y:playerY];
                int blockToRUp = [map tileAtX:playerX+1 Y:playerY-1];
                if(blockToRight == 0){
                    [carryingBlock setVisible: NO];
                    [map setTileAtX:playerX+1 Y:playerY value:2];
                    moves++;
                    [self blockFall: ccp(playerX+1, playerY)];
                }else if(blockToRUp == 0){
                    [carryingBlock setVisible: NO];
                    [map setTileAtX:playerX+1 Y:playerY-1 value:2];
                    moves++;
                    // No need to blockfall because we already know the block below is != 0
                }
            }
        }else{
            if(facingLeft){
                int blockToLeft = [map tileAtX:playerX-1 Y:playerY];
                int blockToLUp = [map tileAtX:playerX-1 Y:playerY-1];
                int blockAbove = [map tileAtX:playerX Y:playerY-1];
                if(blockToLeft == 2 && blockToLUp != 2 && blockAbove == 0){
                    [map setTileAtX:playerX-1 Y:playerY value:0];
                    [carryingBlock setVisible: YES];
                    moves++;
                }
            }else{
                int blockToRight = [map tileAtX:playerX+1 Y:playerY];
                int blockToRUp = [map tileAtX:playerX+1 Y:playerY-1];
                int blockAbove = [map tileAtX:playerX Y:playerY-1];
                if(blockToRight == 2 && blockToRUp != 2 && blockAbove == 0){
                    [map setTileAtX:playerX+1 Y:playerY value:0];
                    [carryingBlock setVisible: YES];
                    moves++;
                }
            }
        }
    }
    [self updateMoveLabel];
}

- (BOOL)attemptFall{
    if(fallAttempts < 30){
        int blockBelow = [map tileAtX:playerX Y:playerY+1];
        if(blockBelow != 0){
            int controlScheme = [[NSUserDefaults standardUserDefaults] integerForKey: @"ControlScheme"];
            if(controlScheme == 1)
                [(InputLayerDPad *)inputLayer setAcceptInput: YES];
            else if(controlScheme == 2 || controlScheme == 3)
                [(InputLayerButtons *)inputLayer setAcceptInput: YES];
            else
                NSLog(@"Control scheme != 1 or 2");

            [self unschedule: @selector(attemptFall)];
            if(blockBelow == 4){
                playerY++;
                [map setOffsetToCenterOn: ccp(playerX, playerY)];
                [self winGame];
            }
            return NO;
        }else{
            playerY++;
            fallAttempts++;
            [map setOffsetToCenterOn: ccp(playerX, playerY)];
            return YES;
        }
    }else{
        NSLog(@"Fall attempts > 30, exitting");
        exit(0);
    }
    return NO;
}

- (void)fall{
    [self unschedule:@selector(fall)];
    int blockUnder = [map tileAtX:playerX Y:playerY+1];
    if(blockUnder == 0){
        fallAttempts = 0;           // Provide a break to the infinite loop
        int controlScheme = [[NSUserDefaults standardUserDefaults] integerForKey: @"ControlScheme"];
        if(controlScheme == 1)
            [(InputLayerDPad *)inputLayer setAcceptInput: NO];
        else if(controlScheme == 2 || controlScheme == 3)
            [(InputLayerButtons *)inputLayer setAcceptInput: NO];
        else
            NSLog(@"Control scheme != 1 or 2");

        if([[NSUserDefaults standardUserDefaults] boolForKey:@"SpeedMode"]){
            while([self attemptFall]){}             // Loop till done fall, instantaneously to viewer
        }else{
            [self schedule: @selector(attemptFall) interval: 0.03f];
        }
    }else if(blockUnder == 4){
        playerY++;
        [map setOffsetToCenterOn: ccp(playerX, playerY)];
        [self winGame];
    }
}

- (BOOL)blockAttemptFall{
    if(fallAttempts < 30){
        int blockBelow = [map tileAtX:currentBlockFall.x Y:currentBlockFall.y+1];
        if(blockBelow != 0){
            int controlScheme = [[NSUserDefaults standardUserDefaults] integerForKey: @"ControlScheme"];
            if(controlScheme == 1)
                [(InputLayerDPad *)inputLayer setAcceptInput: YES];
            else if(controlScheme == 2 || controlScheme == 3)
                [(InputLayerButtons *)inputLayer setAcceptInput: YES];
            else
                NSLog(@"Control scheme != 1 or 2");

            [self unschedule: @selector(blockAttemptFall)];
            return NO;
        }else{
            [map setTileAtX:currentBlockFall.x Y:currentBlockFall.y value:0];
            [map setTileAtX:currentBlockFall.x Y:currentBlockFall.y+1 value:2];
            currentBlockFall.y++;
            fallAttempts++;
            return YES;
        }
    }else{
        NSLog(@"BFall attempts > 30, exitting");
        exit(0);
    }
    return NO;
}

- (void)blockFall:(CGPoint)block{
    currentBlockFall = block;
    int blockUnder = [map tileAtX:currentBlockFall.x Y:currentBlockFall.y+1];
    if(blockUnder == 0){
        fallAttempts = 0;                   // Provide a break to the infinite loop
        int controlScheme = [[NSUserDefaults standardUserDefaults] integerForKey: @"ControlScheme"];
        if(controlScheme == 1)
            [(InputLayerDPad *)inputLayer setAcceptInput: NO];
        else if(controlScheme == 2 || controlScheme == 3)
            [(InputLayerButtons *)inputLayer setAcceptInput: NO];
        else
            NSLog(@"Control scheme != 1 or 2");

        if([[NSUserDefaults standardUserDefaults] boolForKey:@"SpeedMode"]) 
            while([self blockAttemptFall]){}        // Loop till done fall, instantaneously to viewer.
        else
            [self schedule: @selector(blockAttemptFall) interval: 0.05f];
    }
}

- (void)updateMoveLabel{
    //[moveLabel setString:[NSString stringWithFormat:@"Moves: %i", moves]];
}

- (void)updateTimeLabel{
    NSTimeInterval timeElapsed = [[NSDate date] timeIntervalSince1970] - startInterval;
    
    if(timeElapsed >= 60.0f){
        int minutes;
        float seconds;
        minutes = timeElapsed / 60.0f;
        seconds = timeElapsed - (minutes * 60.0f);
        [timeLabel setString:[NSString stringWithFormat:@"%d:%05.2f", minutes, seconds]];
    }else{
        [timeLabel setString:[NSString stringWithFormat:@"%.2f", timeElapsed]];
    }
    
}

- (void)setPlayerX:(int)x{
    playerX = x;
    [map setOffsetToCenterOn: ccp(playerX, playerY)];
}

- (void)setPlayerY:(int)y{
    playerY = y;
    [map setOffsetToCenterOn: ccp(playerX, playerY)];
}

- (int)playerX{
    return playerX;
}

- (int)playerY{
    return playerY;
}

@end
