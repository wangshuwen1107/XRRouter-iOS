//
// Created by 王书文 on 2020/9/17.
// Copyright (c) 2020 cn.cheney. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XRRouterMethod.h"
#import "XRRouterModule.h"

@class XRRouterIntent;
typedef void (^XRRouterErrorHandler)(NSString *,NSString *);
typedef XRRouterIntent * (^XRRouterInterceptor)(XRRouterIntent *);

@interface XRRouter : NSObject
@property(nonatomic) NSString *scheme;
@property (nonatomic)BOOL debug;

+ (instancetype)share;

+ (void)setup:(NSString *)scheme;

- (XRRouterIntent *)url:(NSString *)urlStr;

- (XRRouterModule *)findModule:(NSURL *)url;

- (XRRouterMethod *)findMethod:(NSURL *)url;

- (void)callback:(NSString *)requestId :(NSDictionary *)result;

- (void)errorHandler:(XRRouterErrorHandler) handler;

- (void)callbackError:(NSString *)urlStr errorMsg:(NSString *)errorMsg;

- (void)addInterceptor:(XRRouterInterceptor)interceptor;

- (XRRouterIntent *)processInterceptor:(XRRouterIntent *)intent;

@end
