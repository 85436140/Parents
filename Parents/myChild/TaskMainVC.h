//
//  TaskMainVC.h
//  Parents
//
//  Created by kfd on 14-11-7.
//  Copyright (c) 2014年 qzz. All rights reserved.
//

#import "PCBaseVC.h"
#import "NowTaskCell.h"
#import "FutureTaskCell.h"
#import "AddTaskVC.h"
#import "SpaceListVC.h"
#import "OldTaskView.h"
#import "AchieveMentVC.h"
#import "RewardSetVC.h"
#import "CheckDetailVC.h"
#import "ReportMainVC.h"
#import "CommonView.h"
#import "TaskCacheService.h"
#import "ChatViewController.h"
#import "HomeVC.h"

@interface TaskMainVC : PCBaseVC<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>

//视图中小圆点，对应视图的页码
@property (retain, nonatomic) UIPageControl *myPageControl;
//动态存储数组，用于存放试图控制器
@property (retain, nonatomic) NSArray *taskViewControllers;
//当前页计数
@property (assign, nonatomic) int currentPage;

@property (weak, nonatomic) IBOutlet UIView *topView;

@property (weak, nonatomic) IBOutlet UIButton *nowTaskBtnOutlet;
@property (weak, nonatomic) IBOutlet UIButton *futureTaskBtnOutlet;
@property (weak, nonatomic) IBOutlet UIButton *oldTaskBtnOutlet;

@property (weak, nonatomic) IBOutlet UIButton *addTaskBtnOutlet;
@property (weak, nonatomic) IBOutlet UIButton *rewardSetBtnOutlet;
@property (weak, nonatomic) IBOutlet UIButton *msgBtnOutlet;
@property (weak, nonatomic) IBOutlet UIButton *achievementBtnOutlet;

@property (strong,nonatomic) DBService *tService;

- (IBAction)nowTaskBtnAction:(id)sender;
- (IBAction)futureTaskBtnAction:(id)sender;
- (IBAction)oldTaskBtnAction:(id)sender;

- (IBAction)addTaskBtnAction:(id)sender;
- (IBAction)rewardSetBtnAction:(id)sender;
- (IBAction)msgBtnAction:(id)sender;
- (IBAction)achievementBtnAction:(id)sender;
-(id)initWithService:(DBService *)taskService;

@end
