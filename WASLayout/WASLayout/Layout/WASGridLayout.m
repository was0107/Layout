//
//  WASGridLayout.m
//  WASLayoutManager
//
//  Created by allen.wang on 11/2/12.
//  Copyright (c) 2012 b5m. All rights reserved.
//

#import "WASGridLayout.h"

@implementation WASGridLayout
@synthesize hgap = _hgap;
@synthesize vgap = _vgap;
@synthesize rows = _rows;
@synthesize columns = _columns;

- (id) init
{
    return [self initWithRows:1 columns:0 hGap:0 vGap:0];
}

- (id) initWithRows:(int) theRow columns:(int) theColumns
{
    return [self initWithRows:theRow columns:theColumns hGap:0 vGap:0];
}

- (id) initWithRows:(int) theRow columns:(int) theColumns hGap:(int) theHGap vGap:(int) theVGap
{
    self = [super init];
    if (self) {
        if ((theRow == 0) && (theColumns == 0)) {
            [NSException raise:kErrorDomain format:@"rows and cols cannot both be zero"];
        }
        self.rows = theRow;
        self.columns = theColumns;
        self.vgap = theVGap;
        self.hgap = theHGap;
    }
    return self;
}
- (void) setRows:(int)theRows
{
    if ((theRows == 0) && (self.columns == 0)) {
        [NSException raise:kErrorDomain format:@"rows and cols cannot both be zero"];
    }
    _rows = theRows;
}

- (void) setColumns:(int)theColumns
{
    if ((theColumns == 0) && (self.rows == 0)) {
        [NSException raise:kErrorDomain format:@"rows and cols cannot both be zero"];
    }
    _columns = theColumns;
}

- (NSString *) debugDescription
{
    return [self description];
}

- (NSString *) description
{
    return [NSString stringWithFormat:@"%@ [hgap = %@, vgap = %@, rows = %@, columns = %@ ] ",NSStringFromClass([self class]), @(self.hgap), @(self.vgap),@(self.rows),@(self.columns)];
}
#pragma mark --
#pragma mark WASLayoutManager

- (void) addLayoutComponent:(NSString *) name with:(Component *)comp
{
    
}

- (void) removeLayoutComponent:(Component *)comp
{
    
}

- (Dimension) preferredLayoutSize:(Container *)target
{
    int ncomponents = [target countComponents];
    int nrows = _rows;
    int ncols = _columns;
    
    if (nrows > 0) {
        ncols = (ncomponents + nrows - 1) / nrows;
    } else {
        nrows = (ncomponents + ncols - 1) / ncols;
    }
    int w = 0;
    int h = 0;
    for (int i = 0 ; i < ncomponents ; i++) {
        Component *comp = [target getComponentAt:i];
        if (w < comp.width) {
            w = comp.width;
        }
        if (h < comp.height) {
            h = comp.height;
        }
    }
    return CGSizeMake(ncols*w + (ncols-1)*_hgap, nrows*h + (nrows-1)*_vgap);
}

- (Dimension) minimumLayoutSize:(Container *)target
{
    return [self preferredLayoutSize:target];
}


- (void) layoutContainer:(Container *)target
{
    int ncomponents = [target countComponents];
    int nrows = _rows;
    int ncols = _columns;
    BOOL ltr = YES;
    
    if (ncomponents == 0) {
        return;
    }
    if (nrows > 0) {
        ncols = (ncomponents + nrows - 1) / nrows;
    } else {
        nrows = (ncomponents + ncols - 1) / ncols;
    }
        
    int totalGapsWidth = (ncols - 1) * _hgap;
    int widthWOInsets = target.width ;
    int widthOnComponent = (widthWOInsets - totalGapsWidth) / ncols;
    int extraWidthAvailable = (widthWOInsets - (widthOnComponent * ncols + totalGapsWidth)) / 2;
    
    int totalGapsHeight = (nrows - 1) * _vgap;
    int heightWOInsets = target.height;
    int heightOnComponent = (heightWOInsets - totalGapsHeight) / nrows;
    int extraHeightAvailable = (heightWOInsets - (heightOnComponent * nrows + totalGapsHeight)) / 2;
    
    if (ltr) {
        for (int c = 0, x = target.boundsX + extraWidthAvailable; c < ncols ; c++, x += widthOnComponent + _hgap) {
            for (int r = 0, y = target.boundsY + extraHeightAvailable; r < nrows ; r++, y += heightOnComponent + _vgap) {
                int i = r * ncols + c;
                if (i < ncomponents) {
                    [[target getComponentAt:i] setFrame:CGRectMake(x, y, widthOnComponent, heightOnComponent)];
                }
            }
        }
    } else {
        for (int c = 0, x = (target.width - widthOnComponent) - extraWidthAvailable; c < ncols ; c++, x -= widthOnComponent + _hgap) {
            for (int r = 0, y = target.boundsY + extraHeightAvailable; r < nrows ; r++, y += heightOnComponent + _vgap) {
                int i = r * ncols + c;
                if (i < ncomponents) {
                    [[target getComponentAt:i] setFrame:CGRectMake(x, y, widthOnComponent, heightOnComponent)];
                }
            }
        }
    }
}


@end
