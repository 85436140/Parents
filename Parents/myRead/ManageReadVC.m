//
//  ManageReadVC.m
//  Parents
//
//  Created by kfd on 14-11-12.
//  Copyright (c) 2014年 qzz. All rights reserved.
//

#import "ManageReadVC.h"

@interface ManageReadVC ()
{
    NSArray *myReadTitleArr;
    NSString *btitle;
}
@end

@implementation ManageReadVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setHidden:NO];
    myReadTitleArr = @[@"我的订阅",@"其它专栏"];
    btitle = @"取消订阅";
    [self setBackButtonVisible:@"返回" andButtonFrame:NAVIGATION_RECT_MIN];
    self.navigationItem.title = @"管理订阅";
    UIButton *rightBtn = [PCBaseVC initWithBtn:@"保存" andBtnFrame:NAVIGATION_RECT_MIN];
    [self setNavigationRightBtn:rightBtn];
}

#pragma mark UITableView DataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [myReadTitleArr count];
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{

    return [myReadTitleArr objectAtIndex:section];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentiy = @"cellIdentity";
    
    ManageReadCell *cell = (ManageReadCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentiy];
    if (!cell) {
        cell = [[ManageReadCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentiy];
    }
    if (indexPath.section==1) {
        btitle = @"订阅";
    }
    [cell setDataSourceWithGroupName:@"教育专栏" setButtonTag:indexPath.row
                      setButtonTitle:btitle
                     andReadBtnBlock:^(NSInteger bTag){
                     
    }];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [PCBaseVC customHeadView:[myReadTitleArr objectAtIndex:section]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
