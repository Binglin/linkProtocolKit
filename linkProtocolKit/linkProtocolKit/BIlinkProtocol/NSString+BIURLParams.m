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
        
        NSString *paramsPart = [filterLink objectAtIndex:1];
        return [paramsPart queryItems];
    }
    
    return [self queryItems];
}

- (NSDictionary *)queryItems{
    if ([self rangeOfString:@"="].location != NSNotFound) {
        
        NSMutableDictionary * dic = [NSMutableDictionary dictionary];
        
        NSString *paramsPart = self;
        NSArray  *paramsKeyValue = [paramsPart componentsSeparatedByString:@"&"];
        
        for (NSString *keyValue in paramsKeyValue) {
            NSArray  *KeyValueArr = [keyValue componentsSeparatedByString:@"="];
            if (KeyValueArr.count == 2) {
                NSString *value       = [KeyValueArr objectAtIndex:1];
                value = [value stringByRemovingPercentEncoding];
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


/**     @"!#[]'*;/?:@&=$+{}<>,"   */
- (NSString *)URLParamQueryString{
    NSMutableArray *keyValuesArr = [NSMutableArray arrayWithCapacity:self.count];
    NSCharacterSet *allowedCharactors = [NSCharacterSet characterSetWithCharactersInString:@"!#[]'*;/?:@&=$+{}<>,"].invertedSet;
    for (NSString *key in self) {
        
        NSString *formatKey    = [key    stringByAddingPercentEncodingWithAllowedCharacters:allowedCharactors];
        NSString *formatValue  = [self[key] stringByAddingPercentEncodingWithAllowedCharacters:allowedCharactors];
        
        [keyValuesArr addObject:[NSString stringWithFormat:@"%@=%@",formatKey,formatValue]];
    }
    return [keyValuesArr componentsJoinedByString:@"&"];
}

@end
