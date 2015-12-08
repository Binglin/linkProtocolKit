/*
 
 */




#import <UIKit/UIKit.h>

@interface BIlinkHelper : NSObject

+ (instancetype)helper;


#pragma mark - setting identifiers
/***  跳转app内部页面的标志 格式为key=value  @param appInnerLinkIdentifier default is @"appinner=app"*/
- (void)setAppLinkInnerIndentifier:(NSString *)appInnerLinkIdentifier;

/***  跳转app外部的链接标识**  @param appBrowserIdentifier default is browser*/
- (void)setAppBrowserIdentifier:(NSString *)appBrowserIdentifier;

/***  app内部网页跳转的标识符号  *  @param appwebIdentifier default is web*/
- (void)setAppInnerWebIdentifier:(NSString *)appwebIdentifier;

/**   链接基础url**  @param baseURL default is http://www.xxx.com/*/
- (void)setAppLinkBaseURLString:(NSString *)baseURLString;


/**  @param fileName default is "viewMap"*/
- (void)setViewMapPlistfileName:(NSString *)fileName;


#pragma mark - link operation

+ (void)openApplink:(NSString *)link;

+ (NSString *)wrapLinkWithPageName:(NSString *)pageName parameters:(NSDictionary *)parameters;



#pragma mark - controller initialization


#pragma mark - show a controller
/**
 *  显示某个controller
 *
 *  @param controller : a controller will be displayed
 */
+ (void)displayNewController:(UIViewController *)controller;

@end
