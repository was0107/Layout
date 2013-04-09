//
//  WASFlowLayout.m
//  WASLayoutManager
//
//  Created by allen.wang on 10/31/12.
//  Copyright (c) 2012 b5m. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "WASFlowLayout.h"
#import "WASContainer.h"

@interface WASFlowLayout()
{
    enum {
        LEFT = 0,       /**< This value indicates that each row of components  should be left-justified. */
        CENTER = 1,     /**< This value indicates that each row of components  should be centered-justified. */
        RIGHT = 2,      /**< This value indicates that each row of components  should be right-justified.*/
        LEADING = 3,    /**< This value indicates that each row of components  should be justified to the leading edge of the container's. orientation, for example, to the left in left-to-right orientations. */
        TRAILING = 4    /**< This value indicates that each row of components  should be justified to the trailing edge of the container's. orientation, for example, to the right in left-to-right orientations.*/
    };
}

- (int) moveComponents:(Container *) target 
                     x:(int)x 
                     y:(int)y 
                 width:(int)width 
                height:(int) height 
              rowStart:(int) rowStart 
                rowEnd:(int)rowEnd 
                   ltr:(BOOL) ltr 
           useBaseline:(BOOL)useBaseline 
                ascent:(int[]) ascent
               descent:(int[]) descent;

@end

@implementation WASFlowLayout
@synthesize newAlign = _newAlign;
@synthesize hgap,vgap,alignOnBaseline;

DEF_STATIC_PROPERTY_INT(LEFT);
DEF_STATIC_PROPERTY_INT(CENTER);
DEF_STATIC_PROPERTY_INT(RIGHT);
DEF_STATIC_PROPERTY_INT(LEADING);
DEF_STATIC_PROPERTY_INT(TRAILING);

- (id) init
{
    return [self initWithAlign:WASFlowLayout.CENTER];
}

- (id) initWithAlign:(int) align 
{
    return [self initWithAlign:align hgap:5 vgap:5];
}

- (id) initWithAlign:(int) align hgap:(int) hgap1 vgap:(int)vgap1
{
    self = [super init];
    if (self) {
        self.newAlign = align;
        self.hgap = hgap1;
        self.vgap = vgap1;
    }
    return self;
}

- (void) setNewAlign:(int)newAlign
{
    switch (newAlign) {
        case LEFT:
        case CENTER:
        case RIGHT:
        case LEADING:
        case TRAILING:
            _newAlign = newAlign;
            break;
        default:
            _newAlign = LEFT;
            break;
    }
}

#pragma mark --
#pragma mark WASFlowLayout private

- (NSString *) debugDescription
{
    return [self description];
}

- (NSString *) description
{
    NSString *str = @"";
    switch (_newAlign) {
        case LEFT:        str = @",align=left"; break;
        case CENTER:      str = @",align=center"; break;
        case RIGHT:       str = @",align=right"; break;
        case LEADING:     str = @",align=leading"; break;
        case TRAILING:    str = @",align=trailing"; break;
    }
    return [NSString stringWithFormat:@"%@ [hgap = %d, vgap = %d %@] ",@"", self.hgap, self.vgap,str];//NSStringFromClass([self class])
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
    Dimension dim = CGSizeZero;
    int nmembers = [target countComponents];
    BOOL firstVisibleComponent = YES;
    
    for (int i = 0 ; i < nmembers ; i++) 
    {
        Component *m = [target getComponentAt:i];
        if (!m.isHidden) {
            Dimension d = m.frame.size;
            dim.height = MAX(dim.height, d.height);
            if (firstVisibleComponent) {
                firstVisibleComponent = NO;
            } else {
                dim.width += hgap;
            }
            dim.width += d.width;
        }
        
    }

    dim.width += self.hgap * 2;
    dim.height+= self.vgap * 2;
    return dim;
}

- (Dimension) minimumLayoutSize:(Container *)target
{
    return [self preferredLayoutSize:target];
}

- (int) moveComponents:(Container *) target 
                     x:(int)x 
                     y:(int)y 
                 width:(int)width 
                height:(int) height 
              rowStart:(int) rowStart 
                rowEnd:(int)rowEnd 
                   ltr:(BOOL) ltr 
           useBaseline:(BOOL)useBaseline 
                ascent:(int[]) ascent
               descent:(int[]) descent
{
    switch (_newAlign) {
        case LEFT:
            x += ltr ? 0 : width;
            break;
        case CENTER:
            x += width / 2;
            break;
        case RIGHT:
            x += ltr ? width : 0;
            break;
        case LEADING:
            break;
        case TRAILING:
            x += width;
            break;
    }
    for (int i = rowStart ; i < rowEnd ; i++) 
    {
        Component *m = [target getComponentAt:i];
        if ([m isKindOfClass:[UIView class]] && !m.isHidden) 
        {
            int cy = y + (height - m.height) / 2;
            if (ltr) 
            {
                [m setFrameOrigin:CGPointMake(x,cy)];
            }
            else 
            {
                [m setFrameOrigin:CGPointMake(target.width - x - m.width,cy)];
            }
            x += m.width + hgap;
        }
    }
    return height;
}

- (void) layoutContainer:(Container *)target
{
    int maxwidth = target.boundsWidth - (target.boundsX + hgap*2);
    int nmembers = [target countComponents];
    int x = 0, y = target.boundsY + vgap;
    int rowh = 0, start = 0;
    
    for (int i = 0 ; i < nmembers ; i++) 
    {
        Component *m = [target getComponentAt:i];
        if ([m isKindOfClass:[UIView class]] && !m.isHidden) 
        {
            Dimension d = m.frame.size;
            if ((x == 0) || ((x + d.width) <= maxwidth)) 
            {
                if (x > 0)
                {
                    x += hgap;
                }
                x += d.width;
                rowh = MAX(rowh, d.height);
            }
            else 
            {
                [self moveComponents:target 
                                   x:target.boundsX + hgap 
                                   y:y 
                               width:maxwidth - x
                              height:rowh 
                            rowStart:start
                              rowEnd:i
                                 ltr:YES 
                         useBaseline:NO 
                              ascent:NULL
                             descent:NULL];
                x = d.width;
                y += vgap + rowh;
                rowh = d.height;
                start = i;
            }
        }
    }
    
    [self moveComponents:target 
                       x:target.boundsX + hgap 
                       y:y 
                   width:maxwidth - x
                  height:rowh 
                rowStart:start
                  rowEnd:nmembers
                     ltr:YES 
             useBaseline:NO 
                  ascent:NULL
                 descent:NULL];
}

@end
