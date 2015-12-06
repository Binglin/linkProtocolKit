//
//  BIWebViewController.m
//  linkProtocolKit
//
//  Created by 郑林琴 on 15/12/6.
//  Copyright © 2015年 Ice Butterfly. All rights reserved.
//

#import "BIWebViewController.h"



@interface BIWebViewController ()<UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) UIActivityIndicatorView *indicatorView;
@property (nonatomic, strong) UIProgressView *progressView;

@end



@implementation BIWebViewController

- (void)viewDidLoad{
    self.view.backgroundColor = [UIColor whiteColor];
    self.view.backgroundColor = [UIColor colorWithRed:1 green:0.5 blue:0.5 alpha:0.5];
    
    UIBarButtonItem *back = [[UIBarButtonItem  alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
    
    
    self.indicatorView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
    self.indicatorView.backgroundColor = [UIColor redColor];
    
    self.indicatorView.center = self.view.center;
    
    self.navigationItem.leftBarButtonItems = @[back];
    
    self.progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 70, CGRectGetWidth(self.view.bounds), 10)];
    self.progressView.progressTintColor = [UIColor redColor];

    
    
    self.webView = [UIWebView new];
    self.webView.delegate = self;
    [self.view addSubview:self.webView];
    [self.view addSubview:self.indicatorView];
    [self.view addSubview:self.progressView];
    
    [self loadURLString:self.urlString];
    self.progressView.progress = 0.5;
}


- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    self.webView.frame = self.view.bounds;
}



- (void)loadURLString:(NSString *)urlString{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    [self.webView loadRequest:request];
    self.title = urlString;
}

#pragma mark - UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    [self showIndicatorView:YES];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [self refreshLeftTabbars];
    [self showIndicatorView:NO];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error{
    [self showIndicatorView:NO];
}

#pragma mark - indicator
- (void)showIndicatorView:(BOOL)show{
    if (show) {
        [self.indicatorView startAnimating];
    }else{
        [self.indicatorView stopAnimating];
    }
}

#pragma mark - action
- (void)backAction{
    if ([self.webView canGoBack]){
        [self.webView goBack];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)dismissAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)refreshLeftTabbars{

    if ([self.webView canGoBack]) {
        UIBarButtonItem *back = [[UIBarButtonItem  alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
        UIBarButtonItem *dismiss = [[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStylePlain target:self action:@selector(dismissAction)];
        self.navigationItem.leftBarButtonItems = @[back,dismiss];
    }else{
        UIBarButtonItem *back = [[UIBarButtonItem  alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
        self.navigationItem.leftBarButtonItems = @[back];
        
    }
}

#pragma mark - BIlinkProtocol
+ (__kindof UIViewController<BIlinkProtocol> *)initializeFromInterface{
    return [self new];
}

- (void)settingWithParameters:(NSDictionary *)parameters{
    self.urlString = parameters[@"url"];
}

@end
