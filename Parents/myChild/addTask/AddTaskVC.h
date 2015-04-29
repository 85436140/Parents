//
//  AddTaskViewController.h
//  P_Child
//
//  Created by David on 14/10/24.
//  Copyright (c) 2014年 Wm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomTwoVC.h"
#import "DetailTaskTwoVC.h"
#import "DetailTaskVC.h"
#import "DailyTaskCell.h"
#import "DBService.h"

@interface AddTaskVC : PCBaseVC<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *dataArray;
}
- (IBAction)xueXi:(id)sender;
- (IBAction)yuLe:(id)sender;
- (IBAction)shengHuo:(id)sender;
- (IBAction)caiYi:(id)sender;
- (IBAction)yueDu:(id)sender;
- (IBAction)ziDingYi:(id)sender;
- (IBAction)yunDong:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *studyBtnOutlet;
@property (weak, nonatomic) IBOutlet UIButton *sportBtnOutlet;
@property (weak, nonatomic) IBOutlet UIButton *advantestBtnOutlet;
@property (weak, nonatomic) IBOutlet UIButton *lifeBtnOutlet;
@property (weak, nonatomic) IBOutlet UIButton *talentBtnOutlet;
@property (weak, nonatomic) IBOutlet UIButton *readBtnOutlet;
@property (weak, nonatomic) IBOutlet UIButton *customBtnOutlet;

@end
