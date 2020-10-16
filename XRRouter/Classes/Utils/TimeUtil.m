//
//  TimeUtil.m
//  Pods-XRRouter_Example
//
//  Created by 王书文 on 2020/10/9.
//

#import <Foundation/Foundation.h>
#import "TimeUtil.h"

@implementation TimeUtil

+ (NSString *)getCurrentTimeStamp{
    NSDate* date = [NSDate dateWithTimeIntervalSinceNow:0];//获取当前时间0秒后的时间
    NSTimeInterval time=[date timeIntervalSince1970]*1000;// *1000 是精确到毫秒，不乘就是精确到秒
    NSString *timeString = [NSString stringWithFormat:@"%.0f", time];
    return timeString;
}

@end
