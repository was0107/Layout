//
//  WASLayoutManager2.h
//  WASLayoutManager
//
//  Created by allen.wang on 10/31/12.
//  Copyright (c) 2012 b5m. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WASLayoutManager.h"

@protocol WASLayoutManager2 <WASLayoutManager>

/**
 * Adds the specified component to the layout, using the specified
 * constraint object.
 * @param comp the component to be added
 * @param constraints  where/how the component is added to the layout.
 */
- (void) addLayoutComponent:(Component *) comp withConstraints:(NSObject *) constraints;

/**
 * Calculates the maximum size dimensions for the specified container,
 * given the components it contains.
 * @see java.awt.Component#getMaximumSize
 * @see LayoutManager
 */
- (Dimension)maximumLayoutSize:(Container*) target;

/**
 * Returns the alignment along the x axis.  This specifies how
 * the component would like to be aligned relative to other
 * components.  The value should be a number between 0 and 1
 * where 0 represents alignment along the origin, 1 is aligned
 * the furthest away from the origin, 0.5 is centered, etc.
 */
- (float) getLayoutAlignmentX:(Container*) target;

/**
 * Returns the alignment along the y axis.  This specifies how
 * the component would like to be aligned relative to other
 * components.  The value should be a number between 0 and 1
 * where 0 represents alignment along the origin, 1 is aligned
 * the furthest away from the origin, 0.5 is centered, etc.
 */
- (float) getLayoutAlignmentY:(Container*) target;

/**
 * Invalidates the layout, indicating that if the layout manager
 * has cached information it should be discarded.
 */
- (void) invalidateLayout:(Container*) target;

@end
