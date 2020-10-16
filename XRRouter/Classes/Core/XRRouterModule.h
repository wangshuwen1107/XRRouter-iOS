//
// Created by 王书文 on 2020/9/17.
// Copyright (c) 2020 cn.cheney. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XRRouterMethod.h"
#import "XRRouterParamsBuilder.h"

@interface XRRouterModule : NSObject

@property Class  _Nullable protocolClazz;
@property NSObject * _Nullable protocolInstance;
@property NSMutableArray * _Nonnull methodList;

- (void)newMethod:(void (^_Nonnull)(XRRouterMethod* _Nonnull))block;
- (void)newPage:(void (^_Nonnull)(XRRouterMethod* _Nonnull))block;
@end
