//
// Created by 王书文 on 2020/9/17.
// Copyright (c) 2020 cn.cheney. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XRRouterModule.h"

@protocol XRRouterProtocol <NSObject>


+ (NSString *_Nonnull)moduleName;

+ (void)registerMethod:(nonnull XRRouterModule *) module;


@end
