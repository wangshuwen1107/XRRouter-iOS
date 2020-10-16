//
// Created by 王书文 on 2020/9/17.
// Copyright (c) 2020 cn.cheney. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, XRRouterParamType) {
    XRString,
    XRNumber,
    XRMap,
    XRArray,
    XRObject,
    XREmpty,
};

@interface XRRouterParam : NSObject
@property NSString *paramName;
@property XRRouterParamType paramType;
@end
