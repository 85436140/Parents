//
//  PersonVC.m
//  Parents
//
//  Created by kfd on 15-1-8.
//  Copyright (c) 2015年 qzz. All rights reserved.
//

#import "PersonVC.h"

@interface PersonVC ()

@end

@implementation PersonVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setBackButtonVisible:@"返回" andButtonFrame:NAVIGATION_RECT_MIN];
    self.title = @"我";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
