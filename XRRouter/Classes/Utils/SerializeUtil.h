//
// Created by 王书文 on 2020/9/30.
//

#import <Foundation/Foundation.h>


@interface SerializeUtil : NSObject
+(NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;
+(NSArray *)arrayWithJsonString:(NSString *)jsonString;
@end
