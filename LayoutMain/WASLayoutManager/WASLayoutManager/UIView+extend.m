//
//  UIView+extend.m
//  WASLayoutManager
//
//  Created by allen.wang on 11/1/12.
//  Copyright (c) 2012 b5m. All rights reserved.
//

#import "UIView+extend.h"

B5M_FIX_CATEGORY_BUG(UIViewExtend)

@implementation UIView (extend)
- (CGFloat)x
{
    return self.frame.origin.x;
}
- (CGFloat)y
{
    return self.frame.origin.y;
}
- (CGFloat)width
{
    return self.frame.size.width;
}
- (CGFloat)height
{
    return self.frame.size.height;
}

- (CGFloat)boundsX
{
    return self.bounds.origin.x;
}
- (CGFloat)boundsY
{
    return self.bounds.origin.y;
}
- (CGFloat)boundsWidth
{
    return self.bounds.size.width;
}
- (CGFloat)boundsHeight
{
    return self.bounds.size.height;
}

- (UIView *) setFrameEX:(CGRect) frame
{
    self.frame = frame;
    return self;
}

- (CGFloat)maxWidth
{
    return self.x + self.width;
}

- (CGFloat)maxHeight
{
    return self.y + self.height;
}

- (UIView *) setFrameX:(CGFloat) x
{
    CGRect rect = self.frame;
    rect.origin.x = x;
    self.frame = rect;
    return self;
}

- (UIView *) setFrameY:(CGFloat) y
{
    CGRect rect = self.frame;
    rect.origin.y = y;
    self.frame = rect;
    return self;
}
- (UIView *) setFrameWidth:(CGFloat) width
{
    CGRect rect = self.frame;
    rect.size.width = width;
    self.frame = rect;
    return self;
}
- (UIView *) setFrameHeight:(CGFloat) height
{
    CGRect rect = self.frame;
    rect.size.height = height;
    self.frame = rect;
    return self;
}

- (UIView *) setBoundsX:(CGFloat) x
{
    CGRect rect = self.bounds;
    rect.origin.x = x;
    self.bounds = rect;    
    return self;
}

- (UIView *) setBoundsY:(CGFloat) y
{
    CGRect rect = self.bounds;
    rect.origin.y = y;
    self.bounds = rect;
    return self;
}

- (UIView *) setBoundsWidth:(CGFloat) width
{
    CGRect rect = self.bounds;
    rect.size.width = width;
    self.bounds = rect;  
    return self;
}

- (UIView *) setBoundsHeight:(CGFloat) height
{
    CGRect rect = self.bounds;
    rect.size.height = height;
    self.bounds = rect;
    return self;
}

- (UIView *) setFrameOrigin:(CGPoint) origin
{
    CGRect rect = self.frame;
    rect.origin = origin;
    self.frame = rect;
    return self;
}

- (UIView *) setFrameSize:(CGSize) size
{
    CGRect rect = self.frame;
    rect.size = size;
    self.frame = rect;
    return self;
}
- (UIView *) setBoundsOrigin:(CGPoint) origin
{
    CGRect rect = self.bounds;
    rect.origin = origin;
    self.bounds = rect;
    return self;
}
- (UIView *) setBoundsSize:(CGSize) size
{
    CGRect rect = self.bounds;
    rect.size = size;
    self.bounds = rect;
    return self;
}

- (UIView *) setExtendHeight:(CGFloat) height
{
    CGRect rect = self.frame;
    rect.origin.y += height;
    rect.size.height -= height;
    self.frame = rect;
    return self;
}

- (UIView *) setExtendWidth:(CGFloat) width
{
    CGRect rect = self.frame;
    rect.origin.x += width;
    rect.size.width -= width;
    self.frame = rect;
    return self;
}

- (UIView *) setShiftVertical:(CGFloat) vertical
{
    CGRect rect = self.frame;
    rect.origin.y += vertical;
    self.frame = rect;
    return self;
}

- (UIView *) setShiftHorizon:(CGFloat) horizon
{
    CGRect rect = self.frame;
    rect.origin.x += horizon;
    self.frame = rect;
    return self;
}

- (UIView *) addFillSubView:(UIView *) subView
{
    [subView setFrame:self.bounds];
    [self addSubview:subView];
    return self;
}


- (UIView *) emptySubviews
{
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    return self;
}

@end
