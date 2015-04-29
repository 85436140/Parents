//
//  AccountSafeVC.m
//  Parents
//
//  Created by kfd on 15-1-29.
//  Copyright (c) 2015年 qzz. All rights reserved.
//

#import "AccountSafeVC.h"

@interface AccountSafeVC ()

@end

@implementation AccountSafeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setBackButtonVisible:@"返回" andButtonFrame:NAVIGATION_RECT_MIN];
    self.title = @"账户安全";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
