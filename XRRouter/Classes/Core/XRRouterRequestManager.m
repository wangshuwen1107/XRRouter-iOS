//
//  XRRouterRequestManager.m
//  Pods-XRRouter_Example
//
//  Created by 王书文 on 2020/10/9.
//

#import <Foundation/Foundation.h>
#import "XRRouterRequestManager.h"

@implementation XRRouterRequestManager{
@private
    NSMutableDictionary *_callbackDic;
}

+ (instancetype)share {
    static XRRouterRequestManager *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
    });
    return _sharedInstance;
}

- (instancetype)init {
    if (self = [super init]) {
        _callbackDic = [[NSMutableDictionary alloc] init];
    }
    return self;
};

- (void)addRequest:(NSString *)requestId value:(XRRouterCallback)callback{
    [_callbackDic setObject:callback forKey:requestId];
}

- (void)invokeCallback:(NSString *)requestId value:(NSDictionary *)resultDic{
    XRRouterCallback callback = _callbackDic[requestId];
    if (!callback) {
        NSLog(@"Not Found Callback %@",requestId);
        return;
    }
    [_callbackDic removeObjectForKey:requestId];
    callback(resultDic);
}

@end
