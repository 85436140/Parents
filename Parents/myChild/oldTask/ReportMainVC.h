//
//  ReportViewController.h
//  P_Child
//
//  Created by 尹祥 on 14/11/2.
//  Copyright (c) 2014年 qzz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TimeControlView.h"
#import "TimeAllotView.h"
#import "OneWeekView.h"
#import "MyAchieveView.h"
#import "MyGrownView.h"

@interface ReportMainVC : PCBaseVC<UIScrollViewDelegate,UIActionSheetDelegate>

//视图中小圆点，对应视图的页码
@property (retain, nonatomic) UIPageControl *myPageControl;
//动态存储数组，用于存放试图控制器
@property (retain, nonatomic) NSArray *taskViewControllers;
//当前页计数
@property (assign, nonatomic) int currentPage;

@property (weak, nonatomic) IBOutlet UIScrollView *reportMainScrolView;
@property (weak, nonatomic) IBOutlet UIButton *backBtnOutlet;
@property (weak, nonatomic) IBOutlet UIButton *shareBtnOutlet;

- (IBAction)backBtn:(id)sender;
- (IBAction)shareBtn:(id)sender;
-(instancetype)initWithReport:(NSInteger)index;
@end
