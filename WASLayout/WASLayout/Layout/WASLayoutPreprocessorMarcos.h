//
//  WASLayoutPreprocessorMarcos.h
//  WASLayoutManager
//
//  Created by allen.wang on 10/31/12.
//  Copyright (c) 2012 b5m. All rights reserved.
//

#ifndef WASLayoutManager_WASLayoutPreprocessorMarcos_h
#define WASLayoutManager_WASLayoutPreprocessorMarcos_h

#import <UIKit/UIKit.h>
@class WASContainer;


typedef UIView          Component;
typedef WASContainer    Container;
typedef CGSize          Dimension;

#undef	AS_STATIC_PROPERTY_INT
#define AS_STATIC_PROPERTY_INT( __value ) \
@property (nonatomic, readonly) int  __value; \
+ (int)__value;

#undef	DEF_STATIC_PROPERTY_INT
#define DEF_STATIC_PROPERTY_INT( __value ) \
@dynamic __value; \
+ (int)__value \
{ \
    static int __local = 0; \
    __local = __value; \
    return __local; \
}

#undef	AS_STATIC_PROPERTY
#define AS_STATIC_PROPERTY( __name ) \
@property (nonatomic, readonly) NSString * __name; \
+ (NSString *)__name;

#undef	DEF_STATIC_PROPERTY
#define DEF_STATIC_PROPERTY( __name ) \
@dynamic __name; \
+ (NSString *)__name \
{ \
static NSString * __local = nil; \
if ( nil == __local ) \
{ \
__local = [NSString stringWithFormat:@"%s", #__name]; \
} \
return __local; \
}


#undef	DEF_STATIC_PROPERTY2
#define DEF_STATIC_PROPERTY2( __name, __prefix ) \
@dynamic __name; \
+ (NSString *)__name \
{ \
    static NSString * __local = nil; \
    if ( nil == __local ) \
    { \
        __local = [NSString stringWithFormat:@"%@.%s", __prefix, #__name]; \
    } \
    return __local; \
}

#undef	DEF_STATIC_PROPERTY3
#define DEF_STATIC_PROPERTY3( __name, __prefix, __prefix2 ) \
@dynamic __name; \
+ (NSString *)__name \
{ \
    static NSString * __local = nil; \
    if ( nil == __local ) \
    { \
        __local = [NSString stringWithFormat:@"%@.%@.%s", __prefix, __prefix2, #__name]; \
    } \
    return __local; \
}




#define kErrorDomain        @"WASLayout"


#endif
