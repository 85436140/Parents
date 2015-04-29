//
//  LoginViewController.h
//  P_Child
//
//  Created by kfd on 14-10-20.
//  Copyright (c) 2014年 qzz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RegistVC.h"
#include "SVProgressHUD.h"
#import "TaskMainVC.h"
#import "ForgetPwdVC.h"

@interface LoginVC : PCBaseVC

@property (nonatomic, strong) UITextField *activeField;

@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UITextField *pwdTF;

- (IBAction)loginBtnAction:(id)sender;
- (IBAction)createAccountBtnAction:(id)sender;
- (IBAction)forgetPwdBtnAction:(id)sender;

+(void)showLoginVCWithSuccesBlock:(void(^)(void))successBlock withController:(UIViewController *)viewController;
@end
