//
//  BIlinkHelper.m
//  linkProtocolKit
//
//  Created by 郑林琴 on 15/11/21.
//  Copyright © 2015年 Ice Butterfly. All rights reserved.
//

#import "BIlinkHelper.h"
#import "NSString+BIURLParams.h"
#import "BIlinkProtocol.h"

@interface BIlinkHelper ()

@property (nonatomic, strong) NSDictionary *viewMapper;

@end

@implementation BIlinkHelper


+ (instancetype)helper{
    static BIlinkHelper *_linkHelper_once = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        _linkHelper_once = [[BIlinkHelper alloc] init];
    });
    return _linkHelper_once;
}

- (void)openApplink:(NSString *)link{
    NSURLComponents *component = [NSURLComponents componentsWithString:link];
    NSString *urlPath = component.path;
    
    NSDictionary *paramsDics = [link getURLParams];
    
    NSString *viewIdentifier = [urlPath substringFromIndex:1];
    
    //jump to out of app
    if ([viewIdentifier isEqualToString:@"appOut"]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:link]];
        return;
    }
    NSString *classString = self.viewMapper[viewIdentifier];
    
    NSAssert(classString, @"还没有实现该类实现连接跳转需要的逻辑哦－the logic that jump to view with the identifier is not impletemented");
    Class<BIlinkProtocol> linkDestinationViewControllerClass = NSClassFromString(classString);
    UIViewController<BIlinkProtocol> *viewControllToDisplay = [linkDestinationViewControllerClass initializeFromInterface];
    if (paramsDics) {
        if ([viewControllToDisplay respondsToSelector:@selector(canLinkWithParameters:)]) {
            if ([viewControllToDisplay canLinkWithParameters:paramsDics]) {
                [viewControllToDisplay settingWithParameters:paramsDics];
            }
        }
        else{
            if ([viewControllToDisplay respondsToSelector:@selector(settingWithParameters:)]) {
                [viewControllToDisplay settingWithParameters:paramsDics];
            }
        }
    }
    [self displayNewController:viewControllToDisplay];
}

#pragma mark - 显示新的controller
- (void)displayNewController:(UIViewController *)controller{
    UIViewController *top = [self topController];
    if ([top isKindOfClass:[UINavigationController class]]) {
        UINavigationController *nav = (UINavigationController *)top;
        [nav pushViewController:controller animated:YES];
        return;
    }
    if (top.navigationController) {
        [top.navigationController pushViewController:controller animated:YES];
        return;
    }
    [top presentViewController:controller animated:YES completion:nil];
}

#pragma mark - 获取顶部viewController 每个app均需要设置
- (UIViewController *)topController{
    UIViewController *root = [[UIApplication sharedApplication].delegate window].rootViewController;
    
    UIViewController *top = root;
    if ([root isKindOfClass:[UINavigationController class]]) {
        UINavigationController *navi = (UINavigationController *)root;
        return navi.topViewController;
    }
    
    if ([root isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tab = (UITabBarController *)root;
        return tab.selectedViewController;
    }
    NSArray *rootArr = root.childViewControllers;
    for (id vc in rootArr) {
        if ([vc isKindOfClass:[UINavigationController class]]) {
            top = vc;
            break;
        }
    }
    return top;
}

+ (void)dismissTopController{
    [[self helper] dismissTopController];
}

- (void)dismissTopController{
    UIViewController *top = [self topController];
    if (top.navigationController) {
        if ([top.navigationController popViewControllerAnimated:YES]) {
            return;
        }
    }
    [top dismissViewControllerAnimated:YES completion:nil];
}



#pragma mark - 内外链键值对
- (NSDictionary *)viewMapper{
    if (_viewMapper == nil) {
        NSString *mapPlist = [[NSBundle mainBundle] pathForResource:@"viewMap" ofType:@"plist"];
        _viewMapper = [NSDictionary dictionaryWithContentsOfFile:mapPlist];
    }
    return _viewMapper;
}

@end
