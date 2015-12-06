//
//  ViewController.m
//  linkProtocolKit
//
//  Created by 郑林琴 on 15/11/21.
//  Copyright © 2015年 Ice Butterfly. All rights reserved.
//

#import "ViewController.h"
#import "CodeViewController.h"
#import "XibViewController.h"
#import "StoryBoardViewController.h"
#import "BIlinkProtocol.h"
#import "BIlinkHelper.h"

#import "CodeViewController.h"
#import "XibViewController.h"
#import "StoryBoardViewController.h"

#import "NSString+BIURLParams.h"


@interface ViewController ()

@property (nonatomic, assign) BOOL boolValue;
@property (nonatomic, copy) NSString *string;
@property (nonatomic, copy) NSNumber *number;
@property (nonatomic, assign) NSInteger intValue;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)codeAction:(id)sender {
    
    /*
     the following two code blocks act the same
     1.
     [[BIlinkHelper helper] openApplink:@"http://www.xxx.com/app?appinner=app&pageName=code];
     
     
     2.
     CodeViewController *code =  [[CodeViewController alloc] init];
     code.view.backgroundColor = [UIColor lightGrayColor];
     [self.navigationController pushViewController:code animated:YES];
     */
    [[BIlinkHelper helper] openApplink:@"http://www.xxx.com/app?appinner=app&pageName=code"];
}


- (IBAction)xibAction:(id)sender {
    
    /*
     the following two code blocks act the same
     1.
     [[BIlinkHelper helper] openApplink:@"http://www.xxx.com/app?appinner=app&pageName=xib&text=abc"];
     
     2.
     XibViewController *xibViewController =  [[XibViewController alloc] initWithNibName:@"XibViewController" bundle:nil];
     xibViewController.xibString = @"abc";
     [self.navigationController pushViewController:xibViewController animated:YES];
     */
    
    
    [[BIlinkHelper helper] openApplink:@"http://www.xxx.com/app?appinner=app&pageName=xib&text=abc"];
}

- (IBAction)storyboardAction:(id)sender {
    
    /*
     the following two code blocks act the same
     
     [[BIlinkHelper helper] openApplink:@"http://www.xxx.com/app?appinner=app&pageName=storyboard"];
     
     UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
     StoryBoardViewController *storyBoardVC = [storyboard instantiateViewControllerWithIdentifier:@"storyboardViewController"];
     [self.navigationController pushViewController:storyBoardVC animated:YES];
     */
    [[BIlinkHelper helper] openApplink:@"http://www.xxx.com/app?appinner=app&pageName=storyboard"];
}

- (IBAction)showWebView:(id)sender {
    
   /*http://www.xxx.com/?appinner=app&pageName=web&url=http%3A%2F%2Fwww.baidu.com 
    * 链接中有url的话 需要encode下
    */
    
   NSString *appJumpBaidu =  [[BIlinkHelper helper] wrapLinkWithPageName:@"web" parameters:[[@{@"url":@"http://www.baidu.com"} URLParamQueryString] getURLParams]];
    [[BIlinkHelper helper] openApplink:appJumpBaidu];
}

@end
