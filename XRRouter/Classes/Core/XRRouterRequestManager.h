//
//  XRRouterRequestManager.h
//  Pods
//
//  Created by 王书文 on 2020/10/9.
//


#import <Foundation/Foundation.h>


@interface XRRouterRequestManager : NSObject

typedef void (^XRRouterCallback)(NSDictionary *);
+(instancetype) share;
-(void) addRequest:(NSString *) requestId value:(XRRouterCallback) callback;
-(void) invokeCallback:(NSString *)requestId value:(NSDictionary *) resultDic;
@end




