//
//  BIlinkHelper.h
//  linkProtocolKit
//
//  Created by 郑林琴 on 15/11/21.
//  Copyright © 2015年 Ice Butterfly. All rights reserved.
//

#import "XibViewController.h"

@interface XibViewController ()

@property (weak, nonatomic) IBOutlet UILabel *xibLabel;

@end


@implementation XibViewController

+ (instancetype)initializeFromInterface{
    return [[XibViewController alloc] initWithNibName:@"XibViewController" bundle:nil];
}

- (void)settingWithParameters:(NSDictionary *)parameters{
    NSString *XIBText = parameters[@"text"];
    self.xibString = XIBText;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"xib";
    self.xibLabel.text = self.xibString;
}

@end
