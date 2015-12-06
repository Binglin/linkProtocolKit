//
//  BIlinkProtocol.h
//  linkProtocolKit
//
//  Created by 郑林琴 on 15/11/21.
//  Copyright © 2015年 Ice Butterfly. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BIlinkProtocol <NSObject>


/*
 * view controller maybe init from code 、xib、storyboard
 * implement the function with their init
 */
+ (__kindof UIViewController<BIlinkProtocol> *)initializeFromInterface;

@optional
- (void)settingWithParameters:(NSDictionary *)parameters;

@end
