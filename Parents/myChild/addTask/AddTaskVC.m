//
//  AddTaskViewController.m
//  P_Child
//
//  Created by David on 14/10/24.
//  Copyright (c) 2014年 Wm. All rights reserved.
//

#import "AddTaskVC.h"
#import "DetailTaskVC.h"
@interface AddTaskVC ()

@end

@implementation AddTaskVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setHidden:NO];
    [self.navigationItem setTitle:@"添加任务"];
    [self setBackButtonVisible:@"返回" andButtonFrame:NAVIGATION_RECT_MIN];
    dataArray = [[NSMutableArray alloc] initWithObjects:@"小提琴",@"数学作业",@"语文作业",@"英语作业", nil];

    [self requestLocalDailyTask];
}

-(void)requestLocalDailyTask{

//    NSArray *dailyTaskList = [DBService queryLocalData];
//    for (NSDictionary *dic in dailyTaskList) {
//        Task *task = [Task boundTaskDataWithdict:dic];
//    }
}

#pragma mark -- dataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *cellIdentity = @"CellIdentity";
    tableView.showsVerticalScrollIndicator = NO;
    DailyTaskCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentity];
    if (!cell) {
        cell = [[DailyTaskCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentity];
    }
    [cell setDataSourceDailyTaskName:@"语文" andTaskImg:nil andTimeLbl:@"" setButtonTag:indexPath.row addDailyTaskBlock:^(NSInteger bTag) {
        
    } checkDailyTaskBlock:^(NSInteger bTag) {
        
    }];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"最近常用任务";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//添加任务按钮触发事件
-(void)alert
{
    UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"成功添加任务" message:@"您是否立即执行任务？" delegate:self cancelButtonTitle:@"稍候执行" otherButtonTitles:@"立即执行", nil];
    [alert show];
}

- (IBAction)xueXi:(id)sender {
    DetailTaskVC *detail = [[DetailTaskVC alloc] initwithTaskType:[sender tag]];
    [self.navigationController pushViewController:detail animated:YES];
    detail.navigationItem.title = @"学习类";
}

- (IBAction)yuLe:(id)sender {
    DetailTaskVC *detail = [[DetailTaskVC alloc] initwithTaskType:[sender tag]];
    [self.navigationController pushViewController:detail animated:YES];
    detail.navigationItem.title = @"娱乐类";
}

- (IBAction)shengHuo:(id)sender {
    DetailTaskVC *detail = [[DetailTaskVC alloc] initwithTaskType:[sender tag]];
    [self.navigationController pushViewController:detail animated:YES];
    detail.navigationItem.title = @"生活类";
}

- (IBAction)caiYi:(id)sender {
    DetailTaskVC *detail = [[DetailTaskVC alloc] initwithTaskType:[sender tag]];
    [self.navigationController pushViewController:detail animated:YES];
    detail.navigationItem.title = @"才艺类";
}

- (IBAction)yueDu:(id)sender {
    DetailTaskVC *detail = [[DetailTaskVC alloc] initwithTaskType:[sender tag]];
    [self.navigationController pushViewController:detail animated:YES];
    detail.navigationItem.title = @"阅读类";
}

- (IBAction)ziDingYi:(id)sender {
    CustomTwoVC *custom = [[CustomTwoVC alloc] init];
    [self.navigationController pushViewController:custom animated:YES];
    custom.navigationItem.title = @"自定义类";
}

- (IBAction)yunDong:(id)sender {
    DetailTaskVC *detail = [[DetailTaskVC alloc] initwithTaskType:[sender tag]];
    [self.navigationController pushViewController:detail animated:YES];
    detail.navigationItem.title = @"运动类";
}

@end
