//
//  CustomTwoViewController.h
//  P_Child
//
//  Created by David on 14/10/27.
//  Copyright (c) 2014年 kfd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SVProgressHUD.h"
#import "CustomAlertView.h"

@interface CustomTwoVC : PCBaseVC
@property (weak, nonatomic) IBOutlet UISwitch *isRemindSwitch;

@property (weak, nonatomic) IBOutlet UIView *setRemindTimeView;
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UIView *useTimeView;
@property (weak, nonatomic) IBOutlet UIView *startRemindView;
@property (weak, nonatomic) IBOutlet UIView *takePhotoView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UIView *projectNameView;

@property (weak, nonatomic) IBOutlet UITextField *taskNameTF;

@property (weak, nonatomic) IBOutlet UIButton *taskTypeBtnOutlet;
@property (weak, nonatomic) IBOutlet UIButton *confirmAddBtnOutlet;
@property (weak, nonatomic) IBOutlet UIButton *planTimeBtnOutlet;
@property (weak, nonatomic) IBOutlet UIButton *photoBtnOutlet;
@property (weak, nonatomic) IBOutlet UIButton *startTimeBtnOutlet;

- (IBAction)confirmAddBtnAction:(id)sender;
- (IBAction)onSwitch:(id)sender;
- (IBAction)taskTypeBtnAction:(id)sender;
- (IBAction)planTimeBtnAction:(id)sender;
- (IBAction)photoBtnAction:(id)sender;
- (IBAction)startTimeBtnAction:(id)sender;

@end
