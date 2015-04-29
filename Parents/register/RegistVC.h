//
//  PersonInfoVC.h
//  Parents
//
//  Created by kfd on 14-12-15.
//  Copyright (c) 2014年 qzz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SVProgressHUD.h"
#import "LoginVC.h"

@interface RegistVC : PCBaseVC

@property (weak, nonatomic) IBOutlet UITextField *phoneNumTF;
@property (weak, nonatomic) IBOutlet UITextField *verificationCodeTF;
@property (weak, nonatomic) IBOutlet UITextField *pwdTF;
@property (weak, nonatomic) IBOutlet UIButton *confirmRigsterBtnOutlet;
@property (weak, nonatomic) IBOutlet UIButton *getVerificationBtnOutlet;
@property (weak, nonatomic) IBOutlet UIButton *checkBoxBtnOutlet;

- (IBAction)confirmRegisterBtnAction:(id)sender;
- (IBAction)getVerificationBtnAction:(id)sender;
- (IBAction)checkBoxBtnAction:(id)sender;

@end
