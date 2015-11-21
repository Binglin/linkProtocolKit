//
//  BIlinkProtocol.h
//  linkProtocolKit
//
//  Created by 郑林琴 on 15/11/21.
//  Copyright © 2015年 Ice Butterfly. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BIlinkProtocol <NSObject>

+ (__kindof UIViewController<BIlinkProtocol> *)initializeFromInterface;

@optional
- (BOOL)canLinkWithParameters:(NSDictionary *)parameters;
- (void)settingWithParameters:(NSDictionary *)parameters;

@end
