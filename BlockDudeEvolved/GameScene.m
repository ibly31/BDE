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
@synthesize moveLabel;

@synthesize player;
@synthesize carryingBlock;

@synthesize currentLevel;

- (id)initWithLevel:(int)level{
    self = [super init];
    if(self){
        self.currentLevel = level;
        
        moves = 0;
        startInterval = [[NSDate date] timeIntervalSince1970];
        discountInterval = 0.0f;
        
        CCLayerColor *background = [[CCLayerColor alloc] initWithColor: ccc4(255, 255, 255, 255) width:480 height:320];
        [self addChild: background];
        
        self.playerX = -1;
        self.playerY = -1; // Easy check to see if it was set in map load
        
        facingLeft = YES;
        
        self.map = [[TileMap alloc] initWithMap:currentLevel gameScene:self];
        if(playerX == -1 && playerY == -1){
            NSLog(@"Never set playerlocation. Defaulting to 1,1");
            playerX = 1; playerY = 1;
        }
        
        [self addChild: map];
                                                                                  // 96 = 32x3
        self.player = [[CCSprite alloc] initWithFile:@"Original.png" rect:CGRectMake(96, 0, 32, 32)];
        [player setPosition: ccp(240.0f, 160.0f)];
        [self addChild: player];
        
        self.carryingBlock = [[CCSprite alloc] initWithTexture:[map texture] rect:CGRectMake(64, 0, 32, 32)];
        [carryingBlock setPosition: ccp(240.0f, 192.0f)];
        [carryingBlock setVisible: NO];
        [self addChild: carryingBlock];
        
        [map setOffsetToCenterOn: ccp(playerX, playerY)];
        
        self.timeLabel = [[CCLabelTTF alloc] initWithString:@"" fontName:@"Krungthep" fontSize:20.0f];
        [timeLabel setColor: ccc3(255, 0, 0)];
        [timeLabel setAnchorPoint: ccp(0.0f, 1.0f)];
        [timeLabel setPosition: ccp(8.0f, 312.0f)];
        [self addChild: timeLabel];
        
        self.moveLabel = [[CCLabelTTF alloc] initWithString:@"Moves: 0" fontName:@"Krungthep" fontSize:20.0f];
        [moveLabel setColor: ccc3(255, 0, 0)];
        [moveLabel setAnchorPoint: ccp(1.0f, 1.0f)];
        [moveLabel setPosition: ccp(472.0f, 312.0f)];
        [self addChild: moveLabel];
        
        int controlScheme = [[NSUserDefaults standardUserDefaults] integerForKey: @"ControlScheme"];
        if(controlScheme == 1)
            self.inputLayer = (CCLayer *)[[InputLayerDPad alloc] init];
        else if(controlScheme == 2 || controlScheme == 3)
            self.inputLayer = (CCLayer *)[[InputLayerButtons alloc] init];
        else
            NSLog(@"Control scheme != 1 or 2");
    
        [self addChild: inputLayer];
        
        [self schedule:@selector(updateTimeLabel) interval:.01f];
    }
    return self;
}

- (void)winGame{
    [self unschedule: @selector(updateTimeLabel)];
    
    NSTimeInterval sinceSeventy = [[NSDate date] timeIntervalSince1970];
    
    GameOverScene *gos = [[GameOverScene alloc] initWithMoves:moves timeTaken:sinceSeventy - startInterval levelNumber:currentLevel];
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
                if(blockToLeft == 2 && blockToLUp == 0 && blockAbove == 0){
                    [map setTileAtX:playerX-1 Y:playerY value:0];
                    [carryingBlock setVisible: YES];
                    moves++;
                }
            }else{
                int blockToRight = [map tileAtX:playerX+1 Y:playerY];
                int blockToRUp = [map tileAtX:playerX+1 Y:playerY-1];
                int blockAbove = [map tileAtX:playerX Y:playerY-1];
                if(blockToRight == 2 && blockToRUp == 0 && blockAbove == 0){
                    [map setTileAtX:playerX+1 Y:playerY value:0];
                    [carryingBlock setVisible: YES];
                    moves++;
                }
            }
        }
    }
    [self updateMoveLabel];
}

- (void)attemptFall{
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
        }else{
            playerY++;
            fallAttempts++;
            [map setOffsetToCenterOn: ccp(playerX, playerY)];
        }
    }else{
        NSLog(@"Fall attempts > 30, exitting");
        exit(0);
    }
}

- (void)fall{
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

        if([[NSUserDefaults standardUserDefaults] boolForKey:@"SpeedMode"]) 
            [self schedule: @selector(attemptFall) interval: 0.0f];
        else
            [self schedule: @selector(attemptFall) interval: 0.03f];
    }
}

- (void)blockAttemptFall{
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
        }else{
            [map setTileAtX:currentBlockFall.x Y:currentBlockFall.y value:0];
            [map setTileAtX:currentBlockFall.x Y:currentBlockFall.y+1 value:2];
            currentBlockFall.y++;
            fallAttempts++;
        }
    }else{
        NSLog(@"BFall attempts > 30, exitting");
        exit(0);
    }
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
            [self schedule: @selector(blockAttemptFall) interval: 0.0f];
        else
            [self schedule: @selector(blockAttemptFall) interval: 0.05f];
    }
}

- (void)updateMoveLabel{
    [moveLabel setString:[NSString stringWithFormat:@"Moves: %i", moves]];
}

- (void)updateTimeLabel{
    NSTimeInterval sinceSeventy = [[NSDate date] timeIntervalSince1970];
    [timeLabel setString:[NSString stringWithFormat:@"%.2f", sinceSeventy - startInterval]];
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
