//
//  XRRouterReflection.m
//  dingstock
//
//  Created by 王书文 on 2020/9/13.
//  Copyright © 2020 cn.cheney. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XRRouterReflection.h"
#import <objc/runtime.h>
#import "XRRouterProtocol.h"

@implementation XRRouterReflection


+ (NSMutableArray *)findRouterModules {
    unsigned int outCount;
    Class *classes = objc_copyClassList(&outCount);
    NSMutableArray *returnClazzList = [[NSMutableArray alloc] init];
    for (unsigned int i = 0; i < outCount; i++) {
        Class clazz = classes[i];
        if (class_conformsToProtocol(clazz, @protocol(XRRouterProtocol))) {
            [returnClazzList addObject:clazz];
        }
    }
    free(classes);
    return returnClazzList;

}

@end
