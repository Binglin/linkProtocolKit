/*
 
 */

#import <UIKit/UIKit.h>

@interface BIlinkHelper : NSObject

+ (instancetype)helper;

//
- (void)openApplink:(NSString *)link;

- (void)displayNewController:(UIViewController *)controller;

@end
