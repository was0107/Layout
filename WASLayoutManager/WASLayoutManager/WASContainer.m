//
//  WASContainer.m
//  WASLayoutManager
//
//  Created by allen.wang on 10/31/12.
//  Copyright (c) 2012 b5m. All rights reserved.
//

#import "WASContainer.h"

@interface WASContainer()
@property (nonatomic, retain) NSMutableArray *component;
@property (nonatomic, retain) WASFlowLayout *flowLayout;

- (void) checkAddToSelf:(Component *) comp;
- (void) checkNotAWindow:(Component *) comp;
@end

@implementation WASContainer
@synthesize flowLayout    = _flowLayout;
@synthesize component     = _component;
@synthesize layoutManager = _layoutManager;
@synthesize animating     = _animating;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _component = [[NSMutableArray alloc] initWithCapacity:10];
        _flowLayout = [[WASFlowLayout alloc] init];
        [self setLayoutManager:_flowLayout];
        _animating = NO;
    }
    return self;
}

- (void) dealloc
{
    [_component release], _component =  nil;
    [_flowLayout release], _flowLayout = nil;
    self.layoutManager = nil;
    [super dealloc];
}

- (void) layoutSubviews
{
    if (_layoutManager) {
        [_layoutManager layoutContainer:self];
    }
    else {
        [super layoutSubviews];
    }
}

- (void) setLayoutManager:(id)layoutManager
{
    if (_layoutManager != layoutManager) {
        [_layoutManager release];
        _layoutManager = [layoutManager retain];
        [self layoutSubviews];
    }
}

- (BOOL) isAnimating
{
    return _animating;
}


- (void) layoutWith:(id) layout animated:(BOOL) animated
{
    if (_animating) {
        return;
    }
    _animating = YES;
    [UIView animateWithDuration:animated ? 0.5f : 0.0f 
                     animations:^{
        [self setLayoutManager:layout];
    } completion:^(BOOL finished) {
        _animating = NO;
    }];
}

- (int) countComponents
{
    return [_component count];
}

- (Component *) add:(Component *) comp
{    
    [ self addImpl:comp with:NULL with:-1];
    return comp;
}

- (Component *) add:(NSString *)name withComponet:(Component *)comp 
{
    [ self addImpl:comp with:name with:-1];
    return comp;
}

- (Component *) add:(Component *) comp withIndex:(int) index 
{
    [ self addImpl:comp with:nil with:index];
    return comp;
}

- (void) checkAddToSelf:(Component *)comp
{
    if ([comp isKindOfClass:[self class]]) {
        for (Container *cn = self; cn != nil; cn = (Container *)cn.superview) {
            if (cn == comp) {
                [NSException raise:kErrorDomain format:@"adding container's parent to itself"];
            }
        }
    }
}

- (void) checkNotAWindow:(Component *) comp
{
    if ([comp isKindOfClass:[UIWindow class]]) {
        [NSException raise:kErrorDomain format:@"adding a window to a container"];
    }
}


- (void) addImpl:(Component *) comp with:(NSObject *) constraints with:(int ) index
{
    if (index > (int)[_component count] || (index < 0 && index != -1)) {
        [NSException raise:kErrorDomain format:@"illegal component position"];
    }
    
    [self checkAddToSelf:comp];
    
    [self checkNotAWindow:comp];
        
    /* Reparent the component and tidy up the tree's state. */
    if (([comp isKindOfClass:[UIView class]]) && comp.superview) {
        [comp removeFromSuperview];
        if (index > [_component count]) {
            [NSException raise:kErrorDomain format:@"illegal component position"];
        }
    }
    
    //index == -1 means add to the end.
    if (index == -1) {
        [_component addObject:comp];
        if ([comp isKindOfClass:[UIView class]]) {
            [self addSubview:comp];

        }

    } else {
        [_component insertObject:comp atIndex:index];
        if ([comp isKindOfClass:[UIView class]]) {
            [self insertSubview:comp atIndex:index];
        }
    }
    
    if (_layoutManager && [_layoutManager respondsToSelector:@selector(addLayoutComponent:with:)]) {
        if ([_layoutManager conformsToProtocol:@protocol(WASLayoutManager2)]) {
            id<WASLayoutManager2> layoutManage2 = _layoutManager;
            [layoutManage2 addLayoutComponent:comp withConstraints: constraints];
        }
        else {
            [_layoutManager addLayoutComponent:(NSString *)constraints with:comp];
        }
    }
    
    [self layoutSubviews];
    
}

- (Component *) getComponentAt:(int)index 
{
    if (index > (int)[_component count] || (index < 0 && index != -1)) {
        [NSException raise:kErrorDomain format:@"illegal component position"];
    }
    return [_component objectAtIndex:index];
}

- (void) removeComponentAt:(int) index
{
    if (index < 0  || index >= (int)[_component count]) {
        [NSException raise:kErrorDomain format:@"illegal component position"];
    }
    Component *comp = [_component objectAtIndex:index];
    
    if (_layoutManager && [_layoutManager respondsToSelector:@selector(removeLayoutComponent:)]) {
        [_layoutManager removeLayoutComponent:comp];
    }

    [_component removeObjectAtIndex:index];
    
    [self layoutSubviews];
}

- (void) removeComponent:(Component *)comp
{
    if (comp.superview == self) {
        int index = [_component indexOfObject:comp];
        if (index >= 0) {
            [self removeComponentAt:index];
        }
    }
}

- (void) removeAll
{
    while ([_component count]) {
        int index = (int)[_component count] - 1;
        Component *comp = [_component objectAtIndex:index];
        if (_layoutManager && [_layoutManager respondsToSelector:@selector(removeLayoutComponent:)]) {
            [_layoutManager removeLayoutComponent:comp];
        }
        [_component removeObjectAtIndex:index];
    }
    [self layoutSubviews];
}
@end
