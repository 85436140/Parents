//
//  DetailTaskViewController.h
//  P_Child
//
//  Created by David on 14/10/24.
//  Copyright (c) 2014年 Wm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailTaskTwoVC.h"
#import "AddTaskVC.h"
#import "TaskNameCell.h"

@interface DetailTaskVC : PCBaseVC<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *taskTypeTableView;

-(instancetype)initwithTaskType:(NSInteger)taskType;

@end
