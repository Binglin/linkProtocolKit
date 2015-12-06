//
//  NSString+BIURLParams.h
//  linkProtocolKit
//
//  Created by 郑林琴 on 15/11/21.
//  Copyright © 2015年 Ice Butterfly. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (BIURLParams)

- (NSDictionary *)getURLParams;

@end


@interface NSDictionary (BIURLParamsCombine)

- (NSString *)URLParamQueryString;

@end
