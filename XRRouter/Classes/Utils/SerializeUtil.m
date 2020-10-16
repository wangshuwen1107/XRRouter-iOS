//
// Created by 王书文 on 2020/9/30.
//

#import "SerializeUtil.h"


@implementation SerializeUtil {

}

#pragma mark -json串转换成字典
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];

    if (err) {
        NSLog(@"json解析失败：%@", err);
        return nil;
    }
    return dic;
}

#pragma mark -json串转换成数组
+ (NSArray *)arrayWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }

    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSArray *arr = [NSJSONSerialization JSONObjectWithData:jsonData
                                                   options:NSJSONReadingMutableContainers
                                                     error:&err];

    if (err) {
        NSLog(@"json解析失败：%@", err);
        return nil;
    }
    return arr;

}
@end
