//
//  WASContainer.h
//  WASLayoutManager
//
//  Created by allen.wang on 10/31/12.
//  Copyright (c) 2012 b5m. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WASLayoutManager.h"
#import "WASLayoutManager2.h"

@interface WASContainer:UIView
@property (nonatomic, retain) id layoutManager;
@property (nonatomic, assign, readonly, getter = isAnimating) BOOL animating;

- (void) layoutWith:(id) layout animated:(BOOL) animated;

- (int) countComponents;
- (Component *) getComponentAt:(int )index;
- (Component *) add:(Component *) comp;
- (Component *) add:(NSString *) name withComponet:(Component *) comp;
- (Component *) add:(Component *) comp withIndex:(int) index ;
- (void) addImpl:(Component *) comp with:(NSObject *) constraints with:(int) index;
- (void) removeComponentAt:(int ) index;
- (void) removeComponent:(Component *) comp;
- (void) removeAll;

@end
