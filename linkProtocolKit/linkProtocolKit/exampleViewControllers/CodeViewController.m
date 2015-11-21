//
//  BIlinkHelper.h
//  linkProtocolKit
//
//  Created by 郑林琴 on 15/11/21.
//  Copyright © 2015年 Ice Butterfly. All rights reserved.
//

#import "CodeViewController.h"

@interface CodeViewController ()

@end

@implementation CodeViewController

+ (instancetype)initializeFromInterface{
    CodeViewController *code =  [[CodeViewController alloc] init];
    code.view.backgroundColor = [UIColor lightGrayColor];
    return code;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"code";
}

@end
