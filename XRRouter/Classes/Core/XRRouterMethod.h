//
// Created by 王书文 on 2020/9/17.
// Copyright (c) 2020 cn.cheney. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XRRouterParam.h"
#import "XRRouterParamsBuilder.h"

@interface XRRouterMethod : NSObject

@property (nonatomic,strong) NSString * _Nonnull methodName;
@property (nonatomic) SEL _Nullable  selector;
@property (nonatomic,strong) NSMutableArray<XRRouterParam*> * _Nonnull paramList;
@property (nonatomic) XRRouterParamType returnType;

- (void)params:(void (^_Nonnull)(XRRouterParamsBuilder *_Nonnull))paramBlock;


@end

