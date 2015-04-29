//
//  MyCircleVC.h
//  Parents
//
//  Created by kfd on 14-11-10.
//  Copyright (c) 2014年 qzz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyCircleCell.h"
#import "SpaceListVC.h"
#import "FriendsCell.h"
#import "ChatViewController.h"
#import "PersonInfoVC.h"

@interface MyCircleVC : PCBaseVC<UITableViewDelegate,UITableViewDataSource>

//视图中小圆点，对应视图的页码
@property (retain, nonatomic) UIPageControl *myPageControl;

@property (weak, nonatomic) IBOutlet UIButton *FSGroupBtnOutlet;
@property (weak, nonatomic) IBOutlet UIButton *myFriendsBtnOutlet;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UIScrollView *mainScrollView;

@property (strong, nonatomic) UITableView *fsGroupTV;
@property (strong, nonatomic) UITableView *myFriendsTV;

- (IBAction)FSGroupBtnAction:(id)sender;
- (IBAction)myFriendsBtnAction:(id)sender;
@end
