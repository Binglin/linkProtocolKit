//
//  BIWebViewController.h
//  linkProtocolKit
//
//  Created by 郑林琴 on 15/12/6.
//  Copyright © 2015年 Ice Butterfly. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BIlinkProtocol.h"

@interface BIWebViewController : UIViewController<BIlinkProtocol>

@property (nonatomic, copy) NSString *urlString;

- (void)loadURLString:(NSString *)urlString;

@end
