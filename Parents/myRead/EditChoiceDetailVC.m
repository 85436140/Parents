//
//  EditChoiceDetailVC.m
//  Parents
//
//  Created by kfd on 14-11-12.
//  Copyright (c) 2014年 qzz. All rights reserved.
//

#import "EditChoiceDetailVC.h"

@interface EditChoiceDetailVC ()

@end

@implementation EditChoiceDetailVC

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"教育专栏";
    [self setBackButtonVisible:@"返回" andButtonFrame:NAVIGATION_RECT_MIN];
    
    UIButton *rightBtn = [PCBaseVC initWithBtn:@"取消订阅" andBtnFrame:NAVIGATION_RECT_MIN];
    [self setNavigationRightBtn:rightBtn];
}

#pragma mark -- dataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentity = @"cellIdentity";
    EditChoiceCell *cell = (EditChoiceCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentity];
    if (!cell) {
        cell = [[EditChoiceCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentity];
    }
    [cell setDataSourceWithHeadImage:[UIImage imageNamed:@"accout"] andEducationNameLbl:@"二胎妈妈真实剖白：生二胎前必须清楚的事情" andTimeLbl:@"10月17日" andAuthorName:@"尤佳" andPraiseCountLbl:@"0" andCommentCountLbl:@"0"];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    EductionBriefVC *eductionBriefVc = [[EductionBriefVC alloc] init];
    [self.navigationController pushViewController:eductionBriefVc animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 75;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
