//
// Created by 王书文 on 2020/9/17.
// Copyright (c) 2020 cn.cheney. All rights reserved.
//

#import <objc/runtime.h>
#import "XRRouter.h"
#import "XRRouterReflection.h"
#import "XRRouterProtocol.h"
#import "XRRouterIntent.h"
#import "XRRouterRequestManager.h"
#import "UIViewController+Top.h"
#import "CollectionUtil.h"

@implementation XRRouter {
@private
    NSMutableDictionary *_moduleDic;
@private
    XRRouterErrorHandler errorHandler;
@private
    NSMutableArray<XRRouterInterceptor>* _interceptorList;
};


+ (void)setup:(NSString *)scheme{
    XRRouter.share.scheme = scheme;
    [XRRouter.share _findModules];
}

+ (instancetype)share {
    static XRRouter *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
    });
    return _sharedInstance;
}

- (instancetype)init {
    if (self = [super init]) {
        _moduleDic = [[NSMutableDictionary alloc] init];
        _interceptorList =[[NSMutableArray alloc] init];
        self.debug = YES;
    }
    return self;
};

- (void)_findModules {
    NSMutableArray *protocolClazzList = [XRRouterReflection findRouterModules];
    if (nil == protocolClazzList || protocolClazzList.count == 0) {
        return;
    }
    for (int i = 0; i < protocolClazzList.count; ++i) {
        Class clazz = protocolClazzList[(NSUInteger) i];
        if ([clazz conformsToProtocol:@protocol(XRRouterProtocol)]) {
            Class <XRRouterProtocol> protocolClazz = (Class <XRRouterProtocol>) clazz;
            NSString *moduleName = [protocolClazz moduleName];
            if (!moduleName || moduleName.length == 0) {
                continue;
            }
            XRRouterModule *alreadyExistModule = _moduleDic[[protocolClazz moduleName]];
            if (alreadyExistModule) {
                NSString *errorMsg = [[NSString alloc] initWithFormat:@"Repeated Module Register %@，%@",
                                      alreadyExistModule.protocolClazz,protocolClazz];
                @throw [NSException exceptionWithName:@"Repeated Module Register"
                                               reason:errorMsg userInfo:nil];
                return;
            }
            //new module
            XRRouterModule *routerModule = [[XRRouterModule alloc] init];
            routerModule.protocolInstance = [[clazz alloc] init];
            routerModule.protocolClazz = protocolClazz;
            //registerMethod
            [protocolClazz registerMethod:routerModule];
            //log router
            [self _logModule:routerModule];
            [_moduleDic setValue:routerModule forKey:[protocolClazz moduleName]];
        }
    }

}

-(void) _logModule:(XRRouterModule *) module{
    NSLog(@"-------- %@ --------",module.protocolClazz);
    if ([CollectionUtil isEmpty: module.methodList]) {
        return;
    }
    for (XRRouterMethod * method in module.methodList) {
         NSString *paramsStr = @"?";
         if ([CollectionUtil isEmpty:method.paramList]) {
             paramsStr =@"";
         }else{
             for (XRRouterParam* param in method.paramList) {
                 if ([method.paramList indexOfObject:param] == [method.paramList count] -1) {
                     paramsStr = [paramsStr stringByAppendingFormat:@"%@(%@)",param.paramName,
                                  [self _paramTypeToString:param.paramType]];
                 }else{
                     paramsStr = [paramsStr stringByAppendingFormat:@"%@(%@)&",param.paramName,
                                  [self _paramTypeToString:param.paramType]];
                 }
             }
        }
        
        NSLog(@"%@://%@/%@%@",self.scheme,[module.protocolClazz moduleName],method.methodName,paramsStr);
    }
}

-(NSString *) _paramTypeToString :(XRRouterParamType)type{
    switch (type) {
        case XRString:
            return @"string";
            break;
        case XRNumber:
            return @"number";
            break;
        case XRArray:
            return @"list";
            break;
        case XRMap:
            return @"map";
        default:
            return @"UNKOWN";
    }

}

- (void)callback:(NSString *)requestId :(NSDictionary *)result{
    [XRRouterRequestManager.share invokeCallback:requestId value:result];
}

- (XRRouterIntent *)url:(NSString *)urlStr {
    if (!urlStr) {
        return nil;
    }
    return [[XRRouterIntent alloc] init:urlStr];
}

- (void)errorHandler:(XRRouterErrorHandler)handler{
    errorHandler = handler;
}

- (void)callbackError:(NSString *)urlStr errorMsg:(NSString *)errorMsg{
    if (errorHandler) {
        errorHandler(urlStr,errorMsg);
    }
}

- (void)addInterceptor:(XRRouterInterceptor)interceptor{
    if (!interceptor) {
        return;
    }
    [_interceptorList addObject:interceptor];
}

- (XRRouterIntent *)processInterceptor:(XRRouterIntent *)intent{
    if ([CollectionUtil isEmpty:_interceptorList]) {
        return intent;
    }
    XRRouterIntent *dealIntent = intent;
    for (XRRouterInterceptor interceptor in _interceptorList) {
        dealIntent = interceptor(dealIntent);
    }
    return dealIntent;
}

- (XRRouterModule *)findModule:(NSURL *)url {
    if (!url) {
        return nil;
    }
    return _moduleDic[url.host];
}


- (XRRouterMethod *)findMethod:(NSURL *)url {
    XRRouterModule *module = [self findModule:url];
    if (!module) {
        return nil;
    }
    NSArray *methodList = module.methodList;
    if (!methodList || methodList.count == 0) {
        return nil;
    }
    NSString *path = url.path;
    if (path) {
        path = [path substringFromIndex:1];
    }
    if (!path) {
        return nil;
    }
    XRRouterMethod *targetMethod = nil;
    for (XRRouterMethod *method in methodList) {
        if ([method.methodName isEqualToString:path]) {
            targetMethod = method;
            break;
        }
    }
    return targetMethod;
}


@end
