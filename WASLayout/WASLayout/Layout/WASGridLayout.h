//
//  WASGridLayout.h
//  WASLayoutManager
//
//  Created by allen.wang on 11/2/12.
//  Copyright (c) 2012 b5m. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WASLayoutManager.h"

@interface WASGridLayout : NSObject<WASLayoutManager>
@property (nonatomic, assign) int hgap;
@property (nonatomic, assign) int vgap;
@property (nonatomic, assign) int rows;
@property (nonatomic, assign) int columns;

- (id) initWithRows:(int) theRow columns:(int) theColumns;
- (id) initWithRows:(int) theRow columns:(int) theColumns hGap:(int) theHGap vGap:(int) theVGap;

@end
