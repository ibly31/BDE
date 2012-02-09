//
//  MapPreviewView.m
//  BlockDudeEvolved
//
//  Created by Billy Connolly on 2/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MapPreviewView.h"

@implementation MapPreviewView

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)reloadWithLevelData:(NSString *)level{
    levelData = level;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect{
    CGContextRef context = UIGraphicsGetCurrentContext();    
    /*NSString *path;
    //NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    //path = [NSString stringWithFormat:@"%@/%@.txt", (NSString *)[paths objectAtIndex:0], levelName];
    path = [[NSBundle mainBundle] pathForResource:levelName ofType:@"txt"];
    
    NSString *string = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];*/
    
    if(levelData != nil){
        NSString *string = [levelData stringByReplacingOccurrencesOfString:@"\n" withString:@","];
        NSArray *lineStrings = [string componentsSeparatedByString:@","];
        if([lineStrings count] >= 27){ // 5*5
            mapWidth = [[lineStrings objectAtIndex: 0] intValue];
            mapHeight = [[lineStrings objectAtIndex: 1] intValue];
            int index = 2;
            if(mapWidth * mapHeight == [lineStrings count] - 2){    // minus 2 for the header
                int bsf = 0;
                int determiningSize = MAX(mapWidth, mapHeight);
                if(determiningSize > 25)
                    bsf = 5;
                else if(determiningSize > 21)
                    bsf = 6;
                else if(determiningSize > 18)
                    bsf = 7;
                else if(determiningSize > 16)
                    bsf = 8;
                else if(determiningSize > 15)
                    bsf = 9;
                else if(determiningSize > 13)
                    bsf = 10;
                else if(determiningSize > 12)
                    bsf = 11;
                else if(determiningSize > 11)
                    bsf = 12;
                else if(determiningSize > 10)
                    bsf = 13;
                else if(determiningSize > 9)
                    bsf = 15;
                else if(determiningSize > 8)
                    bsf = 16;
                else if(determiningSize > 7)
                    bsf = 18;
                else if(determiningSize > 6)
                    bsf = 21;
                else if(determiningSize > 5)
                    bsf = 25;
                else
                    bsf = 30;
                        
                int centerPoint = (150 / bsf) / 2;
                
                CGContextSetRGBStrokeColor(context, 0, 0, 0, 0);
                for(int y = 0; y < mapHeight; y++){
                    for(int x = 0; x < mapWidth; x++){
                        int value = [[lineStrings objectAtIndex: index] intValue];
                        if(value == 1){
                            CGContextSetRGBFillColor(context, 0, 0, 0, 1);
                            CGContextAddRect(context, CGRectMake((centerPoint + x - (mapWidth/2))*bsf, (centerPoint + y - (mapHeight/2))*bsf, bsf, bsf));
                            CGContextFillPath(context);
                        }else if(value == 2){
                            CGContextSetRGBFillColor(context, 0.5f, 0.5f, 0.5f, 1.0f);
                            CGContextAddRect(context, CGRectMake((centerPoint + x - (mapWidth/2))*bsf, (centerPoint + y - (mapHeight/2))*bsf, bsf, bsf));
                            CGContextFillPath(context);
                        }else if(value == 3){
                            CGContextSetRGBFillColor(context, 0.0f, 1.0f, 0.0f, 1.0f);
                            CGContextAddRect(context, CGRectMake((centerPoint + x - (mapWidth/2))*bsf, (centerPoint + y - (mapHeight/2))*bsf, bsf, bsf));
                            CGContextFillPath(context);
                        }else if(value == 4){
                            CGContextSetRGBFillColor(context, 1.0f, 0.0f, 0.0f, 1.0f);
                            CGContextAddRect(context, CGRectMake((centerPoint + x - (mapWidth/2))*bsf, (centerPoint + y - (mapHeight/2))*bsf, bsf, bsf));
                            CGContextFillPath(context);
                        }
                        index++;
                    }
                }

            }else{
                NSLog(@"Map preview incorrect file format");
            }
        }
    }else{
        NSLog(@"Couldn't load file for map preview");
    }
}
@end
