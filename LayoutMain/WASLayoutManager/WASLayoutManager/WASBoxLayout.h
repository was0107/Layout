//
//  WASBoxLayout.h
//  WASLayoutManager
//
//  Created by allen.wang on 11/2/12.
//  Copyright (c) 2012 b5m. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WASLayoutManager2.h"



@interface WASBoxStrut : NSObject
+(id) strutWithValue:(int) value;
@end


@interface WASBoxGlue : WASBoxStrut
+(id) glue;
@end

@interface WASBoxLayout : NSObject<WASLayoutManager2>

@property (nonatomic, assign, readonly) int axis;
AS_STATIC_PROPERTY_INT(X_AXIS);
AS_STATIC_PROPERTY_INT(Y_AXIS);
AS_STATIC_PROPERTY_INT(LINE_AXIS);
AS_STATIC_PROPERTY_INT(PAGE_AXIS);

- (id) initWithContainer:(Container *)theContainer axis:(int) theAxis;
@end
