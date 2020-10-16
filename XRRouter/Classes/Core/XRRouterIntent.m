//
//  NSObject+XRRouterIntent.m
//  dingstock
//
//  Created by 王书文 on 2020/9/18.
//  Copyright © 2020 cn.cheney. All rights reserved.
//

#import "XRRouterIntent.h"
#import "XRRouter.h"
#import "CollectionUtil.h"
#import "SerializeUtil.h"
#import "XRRouterRequestManager.h"
#import "TimeUtil.h"
#import "UIViewController+Top.h"
#import "XRRouterConst.h"

@implementation XRRouterIntent {
@private
    NSMutableDictionary<NSString *, id> *_paramsDic;
@private
    XRRouterMethod *_routerMethod;
@private
    XRRouterModule *_routerModule;
}


- (instancetype)init:(NSString *)urlStr {
    if (self = [super init]) {
        self.urlStr = urlStr;
    }
    _paramsDic = [[NSMutableDictionary alloc] init];
    return self;
}


- (id)start {
    return [self start:YES];
}

- (id)start:(BOOL)animated{
    [self _parseUrl:self.urlStr];
    return [self _invokeMethod:_routerModule.protocolInstance
                         clazz: _routerModule.protocolClazz
                         perform:_routerMethod
                         with:_paramsDic
                         animated:animated];
}

- (id)startAsync:(XRRouterCallback )callback{
    return [self startAsync:YES callback:callback];
}

- (id)startAsync:(BOOL)animated callback:(XRRouterCallback)callback{
    [self _parseUrl:self.urlStr];
    
    NSString * requestId = [TimeUtil getCurrentTimeStamp];
    [XRRouterRequestManager.share addRequest:requestId value:callback];
    [_paramsDic setObject:requestId forKey:kRequestId];
    
    return [self _invokeMethod:_routerModule.protocolInstance
                         clazz: _routerModule.protocolClazz
                         perform:_routerMethod
                         with:_paramsDic
                         animated:animated];
}

- (XRRouterIntent *)param:(NSString *)key :(id)value {
    if (!key || !value) {
        return self;
    }
    _paramsDic[key] = value;
    return self;
}


- (void)_parseUrl:(NSString *)urlStr {
    if (urlStr) {
        self.url = [[NSURL alloc] initWithString:urlStr];
        NSString *scheme = self.url.scheme;
        if (!scheme) {
            urlStr = [[NSString alloc] initWithFormat:@"%@://%@",[XRRouter.share scheme] ,urlStr];
            self.url = [[NSURL alloc] initWithString:urlStr];
        }
        //处理拦截器
        [XRRouter.share processInterceptor:self];
        //路由解析 👇
        _routerModule = [XRRouter.share findModule:self.url];
        if (!_routerModule) {
            [XRRouter.share callbackError:urlStr errorMsg:@"Not Found Module"];
            return;
        }
        _routerMethod = [XRRouter.share findMethod:self.url];
        if (!_routerMethod) {
            [XRRouter.share callbackError:urlStr errorMsg:@"Not Found Method"];
            return;
        }
        //解析url里面的query
        [self _parseUrlParams];
        //自动填充requestId的值
        [self _autoAddRequestId];
    }
}


- (void) _autoAddRequestId {
    BOOL hasRequestIdKey = NO;
    for (XRRouterParam *param in _routerMethod.paramList) {
        if ([kRequestId isEqualToString: param.paramName]) {
            hasRequestIdKey = YES;
            break;
        }
    }
    if (hasRequestIdKey && !_paramsDic[kRequestId]) {
        _paramsDic[kRequestId] =  [TimeUtil getCurrentTimeStamp];
    }
}

- (void)_parseUrlParams {
    NSArray<NSString *> *queryList = [self.url.query componentsSeparatedByString:kUrlAnd];
    [queryList enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSArray<NSString *> *queryKV = [obj componentsSeparatedByString:kUrlEqual];
        if (queryKV.count == 2) {
            NSString *paramKey = [queryKV firstObject];
            paramKey = [paramKey stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            NSString *paramValue = [queryKV lastObject];
            paramValue = [paramValue stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            id realValue = nil;
            for (XRRouterParam *param in  _routerMethod.paramList) {
                if (![param.paramName isEqualToString:paramKey]) {
                    continue;
                }
                switch (param.paramType) {
                    case XRString:{
                        realValue = paramValue;
                        //NSLog(@"%@ 👌 %@ ->String", [self getUrlStr],realValue);
                        }
                        break;
                    case XRNumber: {
                        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
                        realValue = [formatter numberFromString:paramValue];
                        //NSLog(@"%@ 👌  %@ ->Number", [self getUrlStr],realValue);
                    }
                        break;
                    case XRArray: {
                        realValue = [SerializeUtil arrayWithJsonString:paramValue];
                        if (!realValue) {
                            realValue = paramValue;
                        }
                        //NSLog(@"%@ 👌  %@ ->Array",[self getUrlStr], realValue);
                      }
                        break;
                    case XRMap: {
                        realValue = [SerializeUtil dictionaryWithJsonString:paramValue];
                        if (!realValue) {
                            realValue = paramValue;
                        }
                        //NSLog(@"%@ 👌 %@ ->Map", [self getUrlStr],realValue);
                    }
                    default:
                        break;
                }

            }
            if (!_paramsDic[paramKey]) {
                _paramsDic[paramKey] = realValue;
            }
        }
    }];
}



- (NSString *)getUrlStr {
    if (!self.url) {
        return @"";
    }
    return [[NSString alloc] initWithFormat:@"%@://%@/%@", self.url.scheme, self.url.host,self.url.path];
}

#pragma mark 执行方法
- (id)_invokeMethod:(NSObject *)instance clazz:(Class)clazz
            perform:(XRRouterMethod *)method
            with:(NSDictionary *)_paramDic
            animated:(BOOL)animated  {
    if (!instance || !method || !clazz) {
        //对象，Class，或者方法异常
        return nil;
    }
    BOOL isClassMethod = NO;
    NSMethodSignature *sig = nil;
    if ([instance respondsToSelector:method.selector]) {
        isClassMethod = NO;
        sig = [instance methodSignatureForSelector:method.selector];
    }else if([clazz respondsToSelector:method.selector]){
        isClassMethod = YES;
        sig = [clazz methodSignatureForSelector:method.selector];
    }
    if (!sig) {
        return nil;
    }
    NSInvocation *inv = [NSInvocation invocationWithMethodSignature:sig];
    inv.selector = method.selector;
    if (isClassMethod) {
        inv.target = clazz;
    }else{
        inv.target = instance;
    }
   
    if (![CollectionUtil isEmpty:method.paramList]) {
        for (int i = 0; i < method.paramList.count; i++) {
            XRRouterParam *param = method.paramList[(NSUInteger) i];
            id objectValue = _paramDic[param.paramName];
            [inv setArgument:&objectValue atIndex:i + 2];

        }
    }
    void * buffer;
    id returnOb;
    @try {
        [inv retainArguments];
        [inv invoke];
        NSUInteger length = sig.methodReturnLength;
        NSString *type = [NSString stringWithUTF8String:sig.methodReturnType];
        if (length>0 && [type isEqualToString:@"@"] && method.returnType != XREmpty) {
            [inv getReturnValue:&buffer];
            returnOb = (__bridge id)(buffer);
            if ([returnOb isKindOfClass:UIViewController.class]
                && [method.methodName isEqualToString:kOpenVCActionName]) {
                [self _openVC:returnOb animated:animated];
            }
        }
    } @catch (NSException *exception) {
        NSLog(@"NSException caught Name: %@  Reason: %@", exception.name, exception.reason);
        NSString *errorMsg = [[NSString alloc] initWithFormat:@"Error Name: ;%@ Reason: %@",
                              exception.name, exception.reason];
        [XRRouter.share callbackError:self.urlStr errorMsg:errorMsg];
    } @finally {
        return returnOb;
    }
}

#pragma mark 打开页面
-(void)_openVC:(UIViewController *)targetVC animated:(BOOL)animated{
    UIViewController *topVC = [UIViewController getTopVc];
    if (topVC && topVC.navigationController) {
        [topVC.navigationController pushViewController:targetVC animated:animated];
    }
}

@end
