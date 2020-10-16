//
//  NSArray+NSArray_Empty.m
//  dingstock
//
//  Created by 王书文 on 2020/9/21.
//  Copyright © 2020 cn.cheney. All rights reserved.
//

#import "CollectionUtil.h"

@implementation CollectionUtil

+ (BOOL)isEmpty:(NSArray *)array{
    if (array == nil || array.count == 0) {
        return YES;
    }
    return NO;
}

@end
