//
//  WASCardLayout.m
//  WASLayoutManager
//
//  Created by allen.wang on 11/1/12.
//  Copyright (c) 2012 b5m. All rights reserved.
//

#import "WASCardLayout.h"

@interface WASCard : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, retain) Component *component;

@end

@implementation WASCard
@synthesize name = _name;
@synthesize component = _component;

- (id) initWithName:(NSString *) theName with:(Component *) theComponent
{
    self = [super init];
    if (self) {
        self.name = theName;
        self.component = theComponent;
    }
    return self;
}

@end

@interface WASCardLayout()
@property (nonatomic, retain) NSMutableArray *contents;

@end

@implementation WASCardLayout
@synthesize currentIndex = _currentIndex;
@synthesize contents    = _contents;
@synthesize hgap = _hgap;
@synthesize vgap = _vgap;

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
        self.contents = [NSMutableArray arrayWithCapacity:10];
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

- (void) checkLayout:(Container *) parent
{
    if (parent.layoutManager != self) {
        [NSException raise:kErrorDomain format:@"wrong parent for CardLayout"];
    }
}

- (void) showDefaultComponent:(Container *) parent
{
    if ([parent countComponents] > 0) {
        _currentIndex = 0;
        [[parent getComponentAt:0] setHidden:NO];
        [parent setNeedsDisplay];
    }
}

- (void) first:(Container *) parent
{
    [self checkLayout:parent];
    
    int ncomponents = [parent countComponents];
    for (int i = 0 ; i < ncomponents ; i++) {
        Component *comp = [parent getComponentAt:i];
        if (!comp.isHidden) {
            [comp setHidden:YES];
            break;
        }
    }
    [self showDefaultComponent:parent];
}

- (void) next:(Container *) parent
{
    [self checkLayout:parent];
    
    int ncomponents = [parent countComponents];
    for (int i = 0 ; i < ncomponents ; i++) {
        Component *comp = [parent getComponentAt:i];
        if (!comp.isHidden) {
            [comp setHidden:YES];
            _currentIndex = (i + 1) % ncomponents;
            comp = [parent getComponentAt:_currentIndex];
            [comp setHidden:NO];
            [parent setNeedsDisplay];
            return;
        }
    }
    [self showDefaultComponent:parent];
}

- (void) previous:(Container *) parent
{
    [self checkLayout:parent];
    
    int ncomponents = [parent countComponents];
    for (int i = 0 ; i < ncomponents ; i++) {
        Component *comp = [parent getComponentAt:i];
        if (!comp.isHidden) {
            [comp setHidden:YES];
            _currentIndex = ((i > 0) ? i-1 : ncomponents-1);
            comp = [parent getComponentAt:_currentIndex];
            [comp setHidden:NO];
            [parent setNeedsDisplay];            
            return;
        }
    }
    [self showDefaultComponent:parent];
}

- (void) last:(Container *) parent
{
    [self checkLayout:parent];
    
    int ncomponents = [parent countComponents];
    for (int i = 0 ; i < ncomponents ; i++) {
        Component *comp = [parent getComponentAt:i];
        if (!comp.isHidden) {
            [comp setHidden:YES];
            break;
        }
    }
    if (ncomponents > 0) {
        _currentIndex = ncomponents - 1;
        [[parent getComponentAt:_currentIndex] setHidden:NO];
        [parent setNeedsDisplay];
    }
}

- (void) showComponent:(Container *) parent name:(NSString *)theName
{
    [self checkLayout:parent];
    Component *next = nil;
    int ncomponents = (int)[self.contents count];
    for (int i = 0; i < ncomponents; i++) {
        WASCard *card = [[self contents] objectAtIndex:i];
        if ([theName isEqualToString:card.name]) {
            next = card.component;
            _currentIndex = i;
            break;
        }
    }
    if (next && next.isHidden) {
        ncomponents = [parent countComponents];
        for (int i = 0; i < ncomponents; i++) {
            Component *comp = [parent getComponentAt:i];
            if (!comp.isHidden) {
                [comp setHidden:YES];
                break;
            }
        }
        [next setHidden:NO];
        [parent setNeedsDisplay];
    }
}


#pragma mark -
#pragma mark WASLayoutManager
- (void) addLayoutComponent:(NSString *) name with:(Component *)comp
{
    if (0 !=[self.contents count]) {
        [comp setHidden:YES];
    }

    for (int i=0, total = (int)[self.contents count]; i < total; i++) {
        if ([name isEqualToString:(((WASCard *)[_contents objectAtIndex:i]).name)]) {
            ((WASCard *)[_contents objectAtIndex:i]).component = comp;
            return;
        }
    }
    [_contents addObject:[[WASCard alloc] initWithName:name with:comp]];
}

- (void) removeLayoutComponent:(Component *)comp
{
    for (int i=0, total = (int)[self.contents count]; i < total; i++) {
        if (comp == (((WASCard *)[_contents objectAtIndex:i]).component)) {
            if (!comp.isHidden && comp.superview) {
                [self next:(Container *)comp.superview];
            }
            [_contents removeObjectAtIndex:i];
            if (_currentIndex > i ) {
                _currentIndex--;
            }
            break;
        }
    }
}

- (Dimension) preferredLayoutSize:(Container *)comp
{
    int ncomponents = [comp countComponents];
    int w = 0;
    int h = 0;
    for (int i = 0 ; i < ncomponents ; i++) {
        Component *target = [comp getComponentAt:i];
        if (target.width > w) {
            w = target.width;
        }
        if (target.height > h) {
            h = target.height;
        }
    }
    return CGSizeMake(w + _hgap*2, h + _vgap*2);
}

- (Dimension) minimumLayoutSize:(Container *)comp
{
    return [self preferredLayoutSize:comp];
}

- (void) layoutContainer:(Container *)comp
{
    int ncomponents = [comp countComponents];
    Component *target = nil;
    BOOL currentFound =  NO;
    for (int i = 0 ; i < ncomponents ; i++) {
        target = [comp getComponentAt:i];
        [target setFrame:CGRectMake(_hgap, _vgap, comp.width - 2 * _hgap, comp.height - 2 * _vgap)];
        
        if (!target.isHidden) {
            currentFound = YES;
        }
    }
    
    if (!currentFound && ncomponents > 0) {
        [[comp getComponentAt:0] setHidden:NO]; 
    }

}

#pragma mark -
#pragma mark WASLayoutManager2

- (void) addLayoutComponent:(Component *) comp withConstraints:(NSObject *) constraints
{
    if (!constraints) {
        constraints = @"";
    }
    if ([constraints isKindOfClass:[NSString class]]) {
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
