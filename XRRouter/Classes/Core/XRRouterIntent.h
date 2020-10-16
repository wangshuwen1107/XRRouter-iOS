//
//  NSObject+XRRouterIntent.h
//  dingstock
//
//  Created by 王书文 on 2020/9/18.
//  Copyright © 2020 cn.cheney. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XRRouterRequestManager.h"

@interface XRRouterIntent<R> : NSObject


@property NSString *urlStr;
@property NSURL *url;

- (instancetype)init:(NSString *)urlStr;

- (R)start;
- (R)start:(BOOL) animated;

- (R)startAsync:(XRRouterCallback)callback;
- (R)startAsync:(BOOL) animated callback:(XRRouterCallback)callback;

- (XRRouterIntent *)param:(NSString *)key :(id)value;

@end


