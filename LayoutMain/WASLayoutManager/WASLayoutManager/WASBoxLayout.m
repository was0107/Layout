//
//  WASBoxLayout.m
//  WASLayoutManager
//
//  Created by allen.wang on 11/2/12.
//  Copyright (c) 2012 b5m. All rights reserved.
//

#import "WASBoxLayout.h"

@interface WASBoxStrut()
@property (nonatomic, assign) int stutValue;
@end

@implementation WASBoxStrut
@synthesize stutValue;

+(id) strutWithValue:(int) value
{
    WASBoxStrut *strut = [[[WASBoxStrut alloc] init] autorelease];
    strut.stutValue = value;
    return strut;
}
@end

@implementation WASBoxGlue
+(id) glue
{
    WASBoxGlue *boxGlue = [[[WASBoxGlue alloc] init] autorelease];
    return boxGlue;
}
@end

@interface WASBoxLayout()
{
    enum  {
        X_AXIS = 0,
        Y_AXIS = 1,
        LINE_AXIS = 2,
        PAGE_AXIS = 3,
    };
}
@property (nonatomic, assign) int gluePosition;
@property (nonatomic, retain) Container *target;

@end

@implementation WASBoxLayout
@synthesize gluePosition = _gluePosition;
@synthesize target = _target;
@synthesize axis = _axis;

DEF_STATIC_PROPERTY_INT(X_AXIS);
DEF_STATIC_PROPERTY_INT(Y_AXIS);
DEF_STATIC_PROPERTY_INT(LINE_AXIS);
DEF_STATIC_PROPERTY_INT(PAGE_AXIS);


- (id) initWithContainer:(WASContainer *)theContainer axis:(int)theAxis
{
    if (theAxis != WASBoxLayout.X_AXIS && 
        theAxis != WASBoxLayout.Y_AXIS &&
        theAxis != WASBoxLayout.LINE_AXIS &&
        theAxis != WASBoxLayout.PAGE_AXIS) 
    {
        [NSException raise:kErrorDomain format:@"Invalid axis"];
    }
    self = [super init];
    if (self) {
        self.gluePosition = -1;
        _axis = theAxis;
        self.target = theContainer;
        self.target.layoutManager = self;
    }
    return self;
}


- (void) dealloc
{
    [_target release]; _target = nil;
    [super dealloc];
}

- (void) checkContainer:(Container *)target {
    if (self.target != target) {
        [NSException raise:kErrorDomain format:@"BoxLayout can't be shared"];
    }
}


#pragma mark -
#pragma mark WASLayoutManager
- (void) addLayoutComponent:(NSString *) name with:(Component *)comp
{
    
}

- (void) removeLayoutComponent:(Component *)comp
{
    
}

- (Dimension) preferredLayoutSize:(Container *)comp
{
    [self checkContainer:comp];
    return comp.bounds.size;
}

- (Dimension) minimumLayoutSize:(Container *)comp
{
    return [self preferredLayoutSize:comp];
}

- (int) glueStart:(Container *) comp
{
    int nmembers = [comp countComponents];
    for (int i = 0 ; i < nmembers ; i++) 
    {
        id m = [comp getComponentAt:i];
        if([m isKindOfClass:[WASBoxGlue class]]) 
            return i;
    }
    return -1;
}

- (void) layoutContainer:(Container *)comp
{
    int width = comp.boundsWidth;
    int height= comp.boundsHeight;

    int nmembers = [comp countComponents];
    int x = comp.boundsX, y = comp.boundsY;
    int glueStart = [self glueStart:comp];

    if (WASBoxLayout.X_AXIS == self.axis || WASBoxLayout.LINE_AXIS == self.axis)
    {
        if (-1 == glueStart || (nmembers - 1 == glueStart)) {
            for (int i = 0 ; i < nmembers ; i++) 
            {
                id m = [comp getComponentAt:i];
                if ([m isKindOfClass:[UIView class]]) {
                    UIView *temp = (UIView *) m;
                    [temp setFrame:CGRectMake(x, y, temp.width, height)];
                    x += temp.width;
                }
                else if([m isKindOfClass:[WASBoxStrut class]]) {
                    WASBoxStrut *strut = (WASBoxStrut *) m;
                    x += strut.stutValue;
                }
            }
        }
        else if (0 == glueStart) {
            x = width;
            for (int i = 0 ; i < nmembers ; i++) 
            {
                id m = [comp getComponentAt:nmembers - 1 - i];
                if ([m isKindOfClass:[UIView class]]) {
                    UIView *temp = (UIView *) m;
                    [temp setFrame:CGRectMake(x - temp.width, y, temp.width, height)];
                    x -= temp.width;
                }
                else if([m isKindOfClass:[WASBoxStrut class]]) {
                    WASBoxStrut *strut = (WASBoxStrut *) m;
                    x -= strut.stutValue;
                }
            }
        }
        else {
            for (int i = 0 ; i < glueStart ; i++) 
            {
                id m = [comp getComponentAt:i];
                if ([m isKindOfClass:[UIView class]]) {
                    UIView *temp = (UIView *) m;
                    [temp setFrame:CGRectMake(x, y, temp.width, height)];
                    x += temp.width;
                }
                else if([m isKindOfClass:[WASBoxStrut class]]) {
                    WASBoxStrut *strut = (WASBoxStrut *) m;
                    x += strut.stutValue;
                }
            }
            x = width;
            for (int i = nmembers - 1 ; i >= glueStart ; i--) 
            {
                id m = [comp getComponentAt:i];
                if ([m isKindOfClass:[UIView class]]) {
                    UIView *temp = (UIView *) m;
                    [temp setFrame:CGRectMake(x - temp.width, y, temp.width, height)];
                    x -= temp.width;
                }
                else if([m isKindOfClass:[WASBoxStrut class]]) {
                    WASBoxStrut *strut = (WASBoxStrut *) m;
                    x -= strut.stutValue;
                }
            }
            
            
        }
    }
    else 
    {
        if (-1 == glueStart || (nmembers - 1 == glueStart)) {
            for (int i = 0 ; i < nmembers ; i++) 
            {
                id m = [comp getComponentAt:i];
                if ([m isKindOfClass:[UIView class]]) {
                    UIView *temp = (UIView *) m;
                    [temp setFrame:CGRectMake(x, y, width, temp.height)];
                    y += temp.height;
                }
                else if([m isKindOfClass:[WASBoxStrut class]])
                {
                    WASBoxStrut *strut = (WASBoxStrut *) m;
                    y += strut.stutValue;
                }
            }

        }   
        else if (0 == glueStart) {
            y = height;
            for (int i = 0 ; i < nmembers ; i++) 
            {
                id m = [comp getComponentAt:nmembers - 1 - i];
                if ([m isKindOfClass:[UIView class]]) {
                    UIView *temp = (UIView *) m;
                    [temp setFrame:CGRectMake(x, y - temp.height, width, temp.height)];
                    y -= temp.height;
                }
                else if([m isKindOfClass:[WASBoxStrut class]]) {
                    WASBoxStrut *strut = (WASBoxStrut *) m;
                    y -= strut.stutValue;
                }
            }

        }
        else {
            for (int i = 0 ; i < glueStart ; i++) 
            {
                id m = [comp getComponentAt:i];
                if ([m isKindOfClass:[UIView class]]) {
                    UIView *temp = (UIView *) m;
                    [temp setFrame:CGRectMake(x, y, width, temp.height)];
                    y += temp.height;
                }
                else if([m isKindOfClass:[WASBoxStrut class]])
                {
                    WASBoxStrut *strut = (WASBoxStrut *) m;
                    y += strut.stutValue;
                }
            }

            y = height;
            for (int i = nmembers - 1 ; i >= glueStart ; i--) 
            {
                id m = [comp getComponentAt:i];
                if ([m isKindOfClass:[UIView class]]) {
                    UIView *temp = (UIView *) m;
                    [temp setFrame:CGRectMake(x, y - temp.height, width, temp.height)];
                    y -= temp.height;
                }
                else if([m isKindOfClass:[WASBoxStrut class]]) {
                    WASBoxStrut *strut = (WASBoxStrut *) m;
                    y -= strut.stutValue;
                }
            }
            
        }

    }
}

#pragma mark -
#pragma mark WASLayoutManager2

- (void) addLayoutComponent:(Component *) comp withConstraints:(NSObject *) constraints
{
    if ([constraints isKindOfClass:[WASBoxGlue class]]) {
        if (-1 == self.gluePosition) {
            self.gluePosition = [self.target countComponents];
        } else {
            [NSException raise:kErrorDomain format:@"cannot add to layout: exist a glue object"];
        }
    } 
    else if(comp){
        [self addLayoutComponent:(NSString *)constraints with:comp];
    } 
    else {
        [NSException raise:kErrorDomain format:@"cannot add to layout: constraint must be a string"];
    }
}

- (Dimension)maximumLayoutSize:(Container*) target
{
    return CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX);
}

- (float) getLayoutAlignmentX:(Container*) target
{
    return 0;
}

- (float) getLayoutAlignmentY:(Container*) target
{
    return 0;
}

- (void) invalidateLayout:(Container*) target
{
    
}
@end
