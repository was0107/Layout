//
//  WASCardLayout.h
//  WASLayoutManager
//
//  Created by allen.wang on 11/1/12.
//  Copyright (c) 2012 b5m. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WASLayoutManager2.h"

@interface WASCardLayout : NSObject<WASLayoutManager2>
@property (nonatomic, assign) int currentIndex;
@property (nonatomic, assign) int hgap;
@property (nonatomic, assign) int vgap;

- (void) showDefaultComponent:(Container *) parent;
- (void) first:(Container *) parent;
- (void) next:(Container *) parent;
- (void) previous:(Container *) parent;
- (void) last:(Container *) parent;
- (void) showComponent:(Container *) parent name:(NSString *)theName;
@end
