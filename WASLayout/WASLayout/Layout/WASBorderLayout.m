//
//  WASBorderLayout.m
//  WASLayoutManager
//
//  Created by allen.wang on 11/1/12.
//  Copyright (c) 2012 b5m. All rights reserved.
//

#import "WASBorderLayout.h"

@interface WASBorderLayout()
@property (nonatomic, strong) Component *center;
@property (nonatomic, strong) Component *north;
@property (nonatomic, strong) Component *south;
@property (nonatomic, strong) Component *east;
@property (nonatomic, strong) Component *west;

@end

@implementation WASBorderLayout
@synthesize center,north,south,east,west;
@synthesize hgap = _hgap;
@synthesize vgap = _vgap;

DEF_STATIC_PROPERTY(NORTH);
DEF_STATIC_PROPERTY(SOURTH);
DEF_STATIC_PROPERTY(EAST);
DEF_STATIC_PROPERTY(WEST);
DEF_STATIC_PROPERTY(CENTER);

- (id) init
{
    return [self initWithHGap:0 VGap:0];
}

- (id)initWithHGap:(int) theHGap VGap:(int) theVGap
{
    self = [super init];
    if (self) {
        self.hgap = theHGap;
        self.vgap = theVGap;
    }
    return self;
}

- (NSString *) debugDescription
{
    return [self description];
}

- (NSString *) description
{
    return [NSString stringWithFormat:@"%@ [hgap = %@, vgap = %@ ] ",NSStringFromClass([self class]), @(self.hgap), @(self.vgap)];
}


- (Component *) getComponent:(Component *) theComponent
{
    return nil;
}

- (Component *) getComponentName:(NSString *) theName
{    
    if ([theName isEqualToString:WASBorderLayout.NORTH]) {
        return self.north;
    } else if ([theName isEqualToString:WASBorderLayout.SOURTH]) {
        return self.south;
    } else if ([theName isEqualToString:WASBorderLayout.EAST]) {
        return self.east;
    } else if ([theName isEqualToString:WASBorderLayout.WEST]) {
        return self.west;
    } else if ([theName isEqualToString:WASBorderLayout.CENTER]) {
        return self.center;
    } else {
        return nil;
    }
}


- (Component *) getChildPosition:(NSString *)post leftToRight:(BOOL)lft
{
    Component *result = nil;
    
    if ([post isEqualToString:WASBorderLayout.NORTH]) {
        result = self.north;
    } else if ([post isEqualToString:WASBorderLayout.SOURTH]) {
        result = self.south;
    } else if ([post isEqualToString:WASBorderLayout.EAST]) {
        result = self.east;
    } else if ([post isEqualToString:WASBorderLayout.WEST]) {
        result = self.west;
    } else if ([post isEqualToString:WASBorderLayout.CENTER]) {
        result = self.center;
    }
    
    if (result != nil && result.isHidden) {
        result = nil;
    }
    return result;
}

- (Component *) addComponent:(Component *) theComponent position:(int) thePosition
{
    static NSString *coms[] = {@"North",@"South",@"East",@"West",@"Center"};
    if (thePosition < 0 || thePosition > 4) {
        [self addLayoutComponent:nil with:theComponent];
    }else {
        [self addLayoutComponent:coms[thePosition] with:theComponent];
    }
    return theComponent;
}


#pragma mark -
#pragma mark WASLayoutManager
- (void) addLayoutComponent:(NSString *) name with:(Component *)comp
{
    if (!name) {
        name = WASBorderLayout.CENTER;
    }
    
    if ([WASBorderLayout.CENTER isEqualToString:name]) {
        [self.center removeFromSuperview];
        self.center = comp;
    } else if ([WASBorderLayout.NORTH isEqualToString:name]) { 
        [self.north removeFromSuperview];
        self.north = comp;
    } else if ([WASBorderLayout.SOURTH isEqualToString:name]) { 
        [self.south removeFromSuperview];
        self.south = comp;
    } else if ([WASBorderLayout.EAST isEqualToString:name]) { 
        [self.east removeFromSuperview];
        self.east = comp;
    } else if ([WASBorderLayout.WEST isEqualToString:name]) { 
        [self.west removeFromSuperview];
        self.west = comp;
    } else {
        [NSException raise:kErrorDomain format:@"cannot add to layout: unknown constraint: "];
    }
}

- (void) removeLayoutComponent:(Component *)comp
{
    if (comp == center) {
        [self.center removeFromSuperview];
        self.center = nil;
    } else if (comp == north) {
        [self.north removeFromSuperview];
        self.north = nil;
    } else if (comp == south) {
        [self.south removeFromSuperview];
        self.south = nil;
    } else if (comp == east) {
        [self.east removeFromSuperview];
        self.east = nil;
    } else if (comp == west) {
        [self.west removeFromSuperview];
        self.west = nil;
    }
}



- (Dimension) preferredLayoutSize:(Container *)comp
{
    Dimension dim = CGSizeZero;
    
    BOOL ltf = YES;
    Component *c = nil;
    
    if ((c = [self getChildPosition:WASBorderLayout.EAST leftToRight:ltf])) {
        Dimension d = c.frame.size;
        dim.width += d.width + _hgap;
        dim.height = MAX(dim.height,d.height);
    }
    if ((c = [self getChildPosition:WASBorderLayout.WEST leftToRight:ltf])) {
        Dimension d = c.frame.size;
        dim.width += d.width + _hgap;
        dim.height = MAX(dim.height,d.height);
    }
    if ((c = [self getChildPosition:WASBorderLayout.CENTER leftToRight:ltf])) {
        Dimension d = c.frame.size;
        dim.width += d.width;
        dim.height = MAX(dim.height,d.height);
    }
    if ((c = [self getChildPosition:WASBorderLayout.NORTH leftToRight:ltf])) {
        Dimension d = c.frame.size;
        dim.height += d.width + _vgap;
        dim.width = MAX(dim.width,d.width);
    }
    if ((c = [self getChildPosition:WASBorderLayout.SOURTH leftToRight:ltf])) {
        Dimension d = c.frame.size;
        dim.height += d.width + _vgap;
        dim.width = MAX(dim.width,d.width);
    }
    
    dim.width += self.hgap * 2;
    dim.height+= self.vgap * 2;
    
    return dim;
}

- (Dimension) minimumLayoutSize:(Container *)comp
{
    return [self preferredLayoutSize:comp];
}

- (void) layoutContainer:(Container *)comp
{
    int top =  [comp boundsY] + _vgap;
    int height = [comp boundsHeight]- (_vgap*2);
    int left =  [comp boundsX] + _hgap;
    int width = comp.boundsWidth - (_hgap*2);;
    
    BOOL ltf = YES;
    Component *c = nil;
    
    if ((c = [self getChildPosition:WASBorderLayout.NORTH leftToRight:ltf])) {
        [c setFrame:CGRectMake(left, top, width, c.height)];
        top += c.height + _vgap;
        height -= c.height + _vgap;
    }
    
    if ((c = [self getChildPosition:WASBorderLayout.SOURTH leftToRight:ltf])) {
        [c setFrame:CGRectMake(left, top + height - c.height , width, c.height)];
        height -= c.height + _vgap;
    }
    
    if ((c = [self getChildPosition:WASBorderLayout.EAST leftToRight:ltf])) {
        [c setFrame:CGRectMake(width - c.width + _hgap, top, c.width, height)];
        width -= c.width + _hgap;
    }
    
    if ((c = [self getChildPosition:WASBorderLayout.WEST leftToRight:ltf])) {
        [c setFrame:CGRectMake(left, top, c.width, height)];
        width -= c.width + _hgap;
        left += c.width + _hgap;
    }
    if ((c = [self getChildPosition:WASBorderLayout.CENTER leftToRight:ltf])) {
        [c setFrame:CGRectMake(left,top, width, height)];
    }
}

#pragma mark -
#pragma mark WASLayoutManager2

- (void) addLayoutComponent:(Component *) comp withConstraints:(NSObject *) constraints
{
    if (!constraints || [constraints isKindOfClass:[NSString class]]) {
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
