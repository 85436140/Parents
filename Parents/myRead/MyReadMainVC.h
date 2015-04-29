//
//  MyReadMainVC.h
//  Parents
//
//  Created by kfd on 14-11-12.
//  Copyright (c) 2014年 qzz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EducationCell.h"
#import "EditChoiceCell.h"
#import "EditChoiceDetailVC.h"
#import "ManageReadVC.h"
#import "LecutureActivityCell.h"
#import "UpComingSignUpCell.h"
#import "LecutureDetailVC.h"
#import "PersonView.h"
#import "LecutureActivityListVC.h"
#import "SubscriptionView.h"
#import "PersonVC.h"

@interface MyReadMainVC : PCBaseVC<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>

//视图中小圆点，对应视图的页码
@property (retain, nonatomic) UIPageControl *myPageControl;
//动态存储数组，用于存放试图控制器
@property (retain, nonatomic) NSArray *taskViewControllers;
//当前页计数
@property (assign, nonatomic) int currentPage;

@property (weak, nonatomic) IBOutlet UIView *topView;


@property (weak, nonatomic) IBOutlet UIButton *educationBtnOutlet;
@property (weak, nonatomic) IBOutlet UIButton *lecutureBtnOutlet;

@property (weak, nonatomic) IBOutlet UIButton *editReadBtnOutlet;

- (IBAction)educationBtnAction:(id)sender;
- (IBAction)lecutureBtnAction:(id)sender;

- (IBAction)editReadBtnAction:(id)sender;

@property (strong, nonatomic) UIScrollView *myReadMainScrollView;
@property (strong, nonatomic) UITableView *educationTableView;
@property (strong, nonatomic) UITableView *lecturesTableView;
@property (strong, nonatomic) UIView *personView;
@end
