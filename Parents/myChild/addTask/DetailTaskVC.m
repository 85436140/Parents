//
//  DetailTaskViewController.m
//  P_Child
//
//  Created by David on 14/10/24.
//  Copyright (c) 2014年 Wm. All rights reserved.
//

#import "DetailTaskVC.h"

@interface DetailTaskVC ()
{
    NSArray *taskNameArr;
    NSInteger _taskTypeId;
}

@end

@implementation DetailTaskVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setBackButtonVisible:@"返回" andButtonFrame:NAVIGATION_RECT_MIN];
    
    taskNameArr = @[@"小提琴",@"钢琴",@"书法",@"歌唱",@"大提琴",@"架子鼓",@"舞蹈"];

}

-(instancetype)initwithTaskType:(NSInteger)taskType{
    _taskTypeId = taskType;
    return [super initWithNibName:@"DetailTaskVC" bundle:nil];
}

#pragma mark -- dataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [taskNameArr count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    TaskNameCell *cell = (TaskNameCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[TaskNameCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    [cell setDataSourceTaskName:[taskNameArr objectAtIndex:indexPath.row] setButtonTag:indexPath.row addTaskBlock:^(NSInteger bTag){
        [self addTask:bTag];
    }];
    return cell;
}

-(void)addTask:(NSInteger)bTag{

    DetailTaskTwoVC *two =[[DetailTaskTwoVC alloc] initwithTaskTypeId:_taskTypeId andTaskName:[taskNameArr objectAtIndex:bTag]];
    [self.navigationController pushViewController:two animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
