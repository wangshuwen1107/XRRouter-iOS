//
//  XRRouterParamsBuilder.m
//  XRRouter
//
//  Created by 王书文 on 2020/9/22.
//

#import <Foundation/Foundation.h>
#import "XRRouterParamsBuilder.h"
#import "XRRouterRequestManager.h"
#import "XRRouterConst.h"

@implementation XRRouterParamsBuilder

-(instancetype)init{
    if (self = [super init])  {
        self.paramList = [[NSMutableArray alloc] init];
    }
    return self;
}

- (XRRouterParamsBuilder *)newParam:(NSString *)name :(XRRouterParamType)type {
    XRRouterParam * param = [[XRRouterParam alloc] init];
    param.paramName = name;
    param.paramType = type;
    [self.paramList addObject:param];
    return  self;
}


- (XRRouterParamsBuilder *)requestId{
    XRRouterParam * param = [[XRRouterParam alloc] init];
    param.paramName = kRequestId;
    param.paramType = XRString;
    [self.paramList addObject:param];
    return  self;
}

@end
