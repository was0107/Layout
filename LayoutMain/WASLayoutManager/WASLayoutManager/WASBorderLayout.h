//
//  WASBorderLayout.h
//  WASLayoutManager
//
//  Created by allen.wang on 11/1/12.
//  Copyright (c) 2012 b5m. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WASLayoutManager2.h"

@interface WASBorderLayout : NSObject<WASLayoutManager2>
@property (nonatomic, assign) int hgap;
@property (nonatomic, assign) int vgap;

AS_STATIC_PROPERTY(NORTH);
AS_STATIC_PROPERTY(SOURTH);
AS_STATIC_PROPERTY(EAST);
AS_STATIC_PROPERTY(WEST);
AS_STATIC_PROPERTY(CENTER);



- (Component *) getComponent:(Component *) theComponent;
- (Component *) getComponentName:(NSString *) theName;



@end
