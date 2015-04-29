//
//  DetailTaskTwoViewController.h
//  P_Child
//
//  Created by David on 14/10/27.
//  Copyright (c) 2014年 kfd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailTaskVC.h"
#import "TaskMainVC.h"
#import "TaskCacheService.h"
#import "CustomAlertView.h"

@interface DetailTaskTwoVC : PCBaseVC

@property (weak, nonatomic) IBOutlet UISwitch *isRemindSwitch;
@property (weak, nonatomic) IBOutlet UIView *takePhoneView;

@property (weak, nonatomic) IBOutlet UIView *setRemindView;
@property (weak, nonatomic) IBOutlet UIView *remindView;
@property (weak, nonatomic) IBOutlet UIView *useTimeView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UIButton *startTimeButOutlet;
@property (weak, nonatomic) IBOutlet UIButton *photoBtnOutlet;

@property (weak, nonatomic) IBOutlet UIButton *confirmAddBtnOutlet;
@property (weak, nonatomic) IBOutlet UIButton *planTimeBtnOutlet;

- (IBAction)photoBtnAction:(id)sender;
- (IBAction)startTimeAction:(id)sender;
- (IBAction)onSwitch:(id)sender;
- (IBAction)confirmBtnAction:(id)sender;
- (IBAction)planTimeBtnAction:(id)sender;

-(instancetype)initwithTaskTypeId:(NSInteger)taskTypeId andTaskName:(NSString *)taskName;
-(instancetype)initWithUpdateParams:(Task *)task isUpdate:(BOOL)flag;

@end
