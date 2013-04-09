//
//  WASFlowLayout.h
//  WASLayoutManager
//
//  Created by allen.wang on 10/31/12.
//  Copyright (c) 2012 b5m. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WASLayoutManager.h"



@interface WASFlowLayout : NSObject<WASLayoutManager>

@property (nonatomic, assign) int newAlign;
@property (nonatomic, assign) int hgap;
@property (nonatomic, assign) int vgap;
@property (nonatomic, assign) bool alignOnBaseline;

AS_STATIC_PROPERTY_INT(LEFT);
AS_STATIC_PROPERTY_INT(CENTER);
AS_STATIC_PROPERTY_INT(RIGHT);
AS_STATIC_PROPERTY_INT(LEADING);
AS_STATIC_PROPERTY_INT(TRAILING);



@end
