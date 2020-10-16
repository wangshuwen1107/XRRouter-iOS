//
// Created by 王书文 on 2020/9/17.
// Copyright (c) 2020 cn.cheney. All rights reserved.
//

#import "XRRouterMethod.h"

@implementation XRRouterMethod{
@private XRRouterParamsBuilder * paramBuilder;
}

@synthesize methodName;
@synthesize selector;

- (NSMutableArray<XRRouterParam *> *)paramList{
    return paramBuilder.paramList;
}

- (instancetype)init {
    if (self = [super init]) {
        self.methodName = @"";
        self.returnType = XREmpty;
        paramBuilder = [[XRRouterParamsBuilder alloc] init];
        self.selector = nil;
    }
    return self;
}


- (void)params:(void (^)(XRRouterParamsBuilder *))paramBlock {
    paramBlock(paramBuilder);
}

@end
