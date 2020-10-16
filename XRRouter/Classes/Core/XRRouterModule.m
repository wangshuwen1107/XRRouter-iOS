//
// Created by 王书文 on 2020/9/17.
// Copyright (c) 2020 cn.cheney. All rights reserved.
//

#import "XRRouterModule.h"
#import "XRRouterConst.h"

@implementation XRRouterModule

@synthesize protocolInstance;
@synthesize methodList;

- (instancetype)init {
    if (self = [super init]) {
        self.methodList = [[NSMutableArray alloc] init];
    }
    return self;
}


- (void)newMethod:(void (^)(XRRouterMethod *))block {
    XRRouterMethod * method = [[XRRouterMethod alloc]init];
    block(method);
    [self.methodList addObject:method];
}

- (void)newPage:(void (^)(XRRouterMethod *))block {
    XRRouterMethod * method = [[XRRouterMethod alloc]init];
    method.methodName = kOpenVCActionName;
    method.returnType = XRObject;
    block(method);
    [self.methodList addObject:method];
}
@end
