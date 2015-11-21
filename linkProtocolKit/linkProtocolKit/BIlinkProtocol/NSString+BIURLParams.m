//
//  NSString+BIURLParams.m
//  linkProtocolKit
//
//  Created by 郑林琴 on 15/11/21.
//  Copyright © 2015年 Ice Butterfly. All rights reserved.
//

#import "NSString+BIURLParams.h"

@implementation NSString (BIURLParams)

- (NSDictionary *)getURLParams{
    NSArray *filterLink = [self componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"?#"]];
    if (filterLink.count > 1) {
        NSMutableDictionary * dic = [NSMutableDictionary dictionary];
        NSString *paramsPart = [filterLink objectAtIndex:1];
        NSArray  *paramsKeyValue = [paramsPart componentsSeparatedByString:@"&"];
        for (NSString *keyValue in paramsKeyValue) {
            NSArray  *KeyValueArr = [keyValue componentsSeparatedByString:@"="];
            if (KeyValueArr.count == 2) {
                NSString *value       = [KeyValueArr objectAtIndex:1];
                if (value.length > 0) {
                    [dic setValue:value forKey:KeyValueArr[0]];
                }
            }
        }
        return dic;
    }
    return nil;
}

@end


@implementation NSDictionary (BIURLParamsCombine)

- (NSString *)URLParamFormateString{
    NSMutableArray *keyValuesArr = [NSMutableArray arrayWithCapacity:self.count];
    for (NSString *key in self) {
        NSString *format = [key stringByAddingPercentEncodingWithAllowedCharacters:nil];
        
        [keyValuesArr addObject:[NSString stringWithFormat:@"%@=%@",key,self[key]]];
    }
    return [keyValuesArr componentsJoinedByString:@"&"];
}

@end
