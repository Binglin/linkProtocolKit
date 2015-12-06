//
//  BIlinkHelper.h
//  linkProtocolKit
//
//  Created by 郑林琴 on 15/11/21.
//  Copyright © 2015年 Ice Butterfly. All rights reserved.
//

#import "StoryBoardViewController.h"


@interface StoryBoardViewController ()

@property (weak, nonatomic) IBOutlet UILabel *textLabel;

@end

@implementation StoryBoardViewController

+ (instancetype)initializeFromInterface{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    StoryBoardViewController *storyBoardVC = [storyboard instantiateViewControllerWithIdentifier:@"storyboardViewController"];
    return storyBoardVC;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"story board";
    
    self.textLabel.text = self.content;
}

@end
