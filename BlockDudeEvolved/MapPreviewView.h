//
//  MapPreviewView.h
//  BlockDudeEvolved
//
//  Created by Billy Connolly on 2/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MapPreviewView : UIView{
    int mapWidth;
    int mapHeight;
    
    NSString *levelData;
    
    CGImageRef previewImage;
}

- (id)initWithFrame:(CGRect)frame;
- (void)reloadWithLevelData:(NSString *)level;

@end
