//
//  WASLayoutManager.h
//  WASLayoutManager
//
//  Created by allen.wang on 10/31/12.
//  Copyright (c) 2012 b5m. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WASLayoutPreprocessorMarcos.h"

@protocol WASLayoutManager <NSObject>
/**
 * If the layout manager uses a per-component string,
 * adds the component <code>comp</code> to the layout,
 * associating it
 * with the string specified by <code>name</code>.
 *
 * @param name the string to be associated with the component
 * @param comp the component to be added
 */
- (void) addLayoutComponent:(NSString *) name with:(Component *)comp;

/**
 * Removes the specified component from the layout.
 * @param comp the component to be removed
 */
- (void) removeLayoutComponent:(Component *)comp;

/**
 * Calculates the preferred size dimensions for the specified
 * container, given the components it contains.
 * @param parent the container to be laid out
 *
 * @see #minimumLayoutSize
 */
- (Dimension) preferredLayoutSize:(Container *)comp;

/**
 * Calculates the minimum size dimensions for the specified
 * container, given the components it contains.
 * @param parent the component to be laid out
 * @see #preferredLayoutSize
 */
- (Dimension) minimumLayoutSize:(Container *)comp;

/**
 * Lays out the specified container.
 * @param parent the container to be laid out
 */
- (void) layoutContainer:(Container *)comp;
@end
