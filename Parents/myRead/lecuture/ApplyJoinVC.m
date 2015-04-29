//
//  ApplyJoinVC.m
//  Parents
//
//  Created by kfd on 14/11/15.
//  Copyright (c) 2014年 qzz. All rights reserved.
//

#import "ApplyJoinVC.h"

@interface ApplyJoinVC ()

@end

@implementation ApplyJoinVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setBackButtonVisible:@"返回" andButtonFrame:NAVIGATION_RECT_MIN];
    self.navigationItem.title = @"报名参与";
    ViewBorderRadius(_submitApplyBtnOutlet, 5, 1, [UIColor blackColor]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)submitApplyBtnAction:(id)sender {
}
@end
