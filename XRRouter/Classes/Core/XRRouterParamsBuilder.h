//
//  XRRouterParamsBuilder.h
//  Pods
//
//  Created by 王书文 on 2020/9/22.
//
#import <Foundation/Foundation.h>
#import "XRRouterParam.h"

@interface XRRouterParamsBuilder : NSObject

@property NSMutableArray<XRRouterParam *> *paramList;

- (XRRouterParamsBuilder *)newParam:(NSString *)name :(XRRouterParamType) type;
- (XRRouterParamsBuilder *)requestId;
@end
