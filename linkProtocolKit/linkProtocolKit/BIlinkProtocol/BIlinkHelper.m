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
#import "BIWebViewController.h"


#define BIAppBaseURLString          @"http://www.xxx.com/"
#define BIAppInnerIdentifier        @"appinner=app"
#define BIAppBrowserIdentifier      @"browser"
#define BIAppWebIdentifier          @"web"
#define BIAppViewNameKey            @"pageName"


#define kViewMapKeyClassName        @"className"
#define kViewMapPropertiesKey       @"properties"
#define kViewMapPropertiesMapKey    @"propertiesMap"


@interface BIlinkHelper ()

@property (nonatomic, strong) NSDictionary *viewMapper;

@property (nonatomic, copy) NSString *appInnerIdentifier;
@property (nonatomic, copy) NSString *appbrowserIdentifier;
@property (nonatomic, copy) NSString *appwebIdentifier;
@property (nonatomic, copy) NSString *applinkBaseURL;

@end

@implementation BIlinkHelper

#pragma mark - BIlinkHel

+ (instancetype)helper{
    static BIlinkHelper *_linkHelper_once = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        _linkHelper_once = [[BIlinkHelper alloc] init];
        [_linkHelper_once defaultSetting];
    });
    return _linkHelper_once;
}

- (void)defaultSetting{
    self.applinkBaseURL       = BIAppBaseURLString;
    self.appInnerIdentifier   = BIAppInnerIdentifier;
    self.appbrowserIdentifier = BIAppBrowserIdentifier;
    self.appwebIdentifier     = BIAppWebIdentifier;
}

#pragma mark - setting

- (void)setAppLinkInnerIndentifier:(NSString *)appInnerLinkIdentifier{
    self.appInnerIdentifier   = appInnerLinkIdentifier;
}

- (void)setAppBrowserIdentifier:(NSString *)appBrowserIdentifier{
    self.appbrowserIdentifier = appBrowserIdentifier;
}

- (void)setAppInnerWebIdentifier:(NSString *)appwebIdentifier{
    self.appwebIdentifier     = appwebIdentifier;
}

- (void)setAppLinkBaseURLString:(NSString *)baseURLString{
    self.applinkBaseURL       = baseURLString;
}

#pragma mark -
- (BOOL)isInnerLink:(NSString *)link{
    return ([link rangeOfString:self.appInnerIdentifier].location != NSNotFound);
}

+ (void)openApplink:(NSString *)link{
    [[BIlinkHelper helper] openApplink:link];
}

- (void)openApplink:(NSString *)link{
    NSLog(@"app link = %@", link);

    /***  无app内部链接标识的link*/
    if ([self isInnerLink:link] == NO) {
        [self openAppWebLink:link];
        return;
    }
    
    /***  有app内部链接标识的link*/
    [self openAPPInnerLink:link];
}

- (void)openAppWebLink:(NSString *)link{
        NSLog(@"app web link = %@", link);
    BIWebViewController *webview = [BIWebViewController initializeFromInterface];
    webview.urlString = link;
    [self displayNewController:webview];
}

- (void)openAPPInnerLink:(NSString *)link{
    
    NSDictionary *paramsDics = [link getURLParams];
    NSString *viewIdentifier = paramsDics[BIAppViewNameKey];
    
    
    
    //jump to out of app
    if ([viewIdentifier isEqualToString:self.appbrowserIdentifier]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:link]];
        return;
    }
    
    //处理app内部页面跳转
    else{
        
        /*app 内部网页跳转*/
        if ([viewIdentifier isEqualToString:self.appwebIdentifier]) {
            NSString *paramURL = paramsDics[@"url"];
            [self openAppWebLink:paramURL];
        }
        /*app 内部页面跳转*/
        else{
            NSLog(@"app inner link = %@", link);

            NSDictionary *classViewMapInfoDictionary = self.viewMapper[viewIdentifier];
            NSString *classString = classViewMapInfoDictionary[kViewMapKeyClassName];
            NSAssert(classString, @"还没有实现该类实现链接跳转需要的逻辑哦－the logic that jump to view with the identifier is not impletemented");

            Class<BIlinkProtocol> linkDestinationViewControllerClass = NSClassFromString(classString);
            UIViewController<BIlinkProtocol> *viewControllToDisplay = [linkDestinationViewControllerClass initializeFromInterface];
            
            /** 两种情况:
             *  1.每个controller单独处理url中各种属性
             *  2.属性对应在viewMap.plist中配置（针对url中属性名字和controller中属性不一致时）
             */
            if (paramsDics) {
                
                /**
                 *  1.每个controller单独处理url中各种属性 <每个页面自行处理，非此类中处理各个页面的属性等，可防止本类变得过于庞大和不好维护>
                 *  url中的key可能和controller中属性不一致，可每个类中自行从url中取值进行配置
                 *
                 */
                if ([viewControllToDisplay respondsToSelector:@selector(settingWithParameters:)]) {
                    [viewControllToDisplay settingWithParameters:paramsDics];
                }
                /**
                 *  2.如果不想每个controller自行处理属性设置，则可直接在viewMap.plist中进行设置
                 *    eg  url中包含 text=abc
                 *        a.  controller中属性为text      b. controller中属性为 nameString
                 *            则properties中值为 text        properties中值为 text
                 *           propertiesMap可删除或者为空      propertiesMap中为 @{text:nameString}
                 */
                else{
                    if (classViewMapInfoDictionary[kViewMapPropertiesKey]) {
                        NSString *propertiesString = classViewMapInfoDictionary[kViewMapPropertiesKey];
                        if (propertiesString.length) {
                            NSArray *supportedProperties = [propertiesString componentsSeparatedByString:@","];
                            NSDictionary *propertiesMap = classViewMapInfoDictionary[kViewMapPropertiesMapKey];
                            
                            @try {
                                for (NSString *propertyName in supportedProperties) {
                                    
                                    if (propertiesMap[propertyName]) {
                                        [viewControllToDisplay setValue:paramsDics[propertyName] forKey:classViewMapInfoDictionary[propertyName]];
                                    }else{
                                        [viewControllToDisplay setValue:paramsDics[propertyName] forKey:propertyName];
                                    }
                                }
                            }
                            @catch (NSException *exception) {
                                NSLog(@"<<<<<<<< %s %d %s >>>>>>>exception %@",__FILE__,__LINE__,__func__,exception);
                            }
                        }
                    }
                }
            }
            [self displayNewController:viewControllToDisplay];
        }
    }
}


- (NSString *)wrapLinkWithPageName:(NSString *)pageName parameters:(NSDictionary *)parameters{
    if (parameters && parameters.count) {
        return [NSString stringWithFormat:@"%@?%@&%@=%@&%@",self.applinkBaseURL,self.appInnerIdentifier,BIAppViewNameKey,pageName,[parameters URLParamQueryString]];
    }
    return self.applinkBaseURL;
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
