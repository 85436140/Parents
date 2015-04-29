//
//  SpaceListVC.m
//  Parents
//
//  Created by kfd on 14-11-10.
//  Copyright (c) 2014年 qzz. All rights reserved.
//

#import "SpaceListVC.h"

@interface SpaceListVC ()

@end

@implementation SpaceListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setHidden:NO];
    [self setBackButtonVisible:@"返回" andButtonFrame:NAVIGATION_RECT_MIN];
    ViewBorderRadius(_pictureBtnOutlet, 5, 1, [UIColor blackColor]);
    ViewBorderRadius(_sendBtnOutlet, 5, 1, [UIColor blackColor]);
}

#pragma mark -- dataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentity = @"CellIdentity";
    SpaceCell *cell = (SpaceCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentity];
    if (cell == nil) {
        cell = [[SpaceCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentity];
    }
    
    [cell setDataSourceWithHeadImg:[UIImage imageNamed:@"accout"] andHeadImage2:[UIImage imageNamed:@"accout"] note:@"sdsf" andNote2:@"wdada"];
    
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)pictureBtnAction:(id)sender {
}

- (IBAction)sendBtnAction:(id)sender {
}
@end
