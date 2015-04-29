//
//  PersonInfoVC.h
//  Parents
//
//  Created by kfd on 14-12-15.
//  Copyright (c) 2014年 qzz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HttpRequest.h"
#import "ProvinceCacheService.h"
#import "SVProgressHUD.h"
#import "LoginVC.h"
#import "ProvinceVC.h"
#import "ChatViewController.h"

@interface PersonInfoVC : PCBaseVC

//button
@property (weak, nonatomic) IBOutlet UIButton *finishedBtnOutlet;
@property (weak, nonatomic) IBOutlet UIButton *pMaleBtnOutlet;
@property (weak, nonatomic) IBOutlet UIButton *pFemaleBtnOutlet;
@property (weak, nonatomic) IBOutlet UIButton *cMaleBtnOutlet;
@property (weak, nonatomic) IBOutlet UIButton *cFemaleBtnOutlet;
@property (weak, nonatomic) IBOutlet UIButton *addClassBtnOutlet;

@property (weak, nonatomic) IBOutlet UIButton *birthdayBtnOutlet;
@property (weak, nonatomic) IBOutlet UITextField *uname_PTF;
@property (weak, nonatomic) IBOutlet UITextField *uname_CTF;
@property (weak, nonatomic) IBOutlet UIPickerView *rolePV;
@property (weak, nonatomic) IBOutlet UIView *ddlView;
@property (weak, nonatomic) IBOutlet UITextField *roleTF;

//button action
- (IBAction)finishedBtnAction:(id)sender;
- (IBAction)birthdayBtnAction:(id)sender;
- (IBAction)pMaleBtnAction:(id)sender;
- (IBAction)pFemaleBtnAction:(id)sender;
- (IBAction)cMaleBtnAction:(id)sender;
- (IBAction)cFemaleBtnAction:(id)sender;
- (IBAction)addClassBtnAction:(id)sender;
- (IBAction)roleDDL:(id)sender;

-(instancetype)initWithPersonInfo:(NSInteger)groupType;
@end
