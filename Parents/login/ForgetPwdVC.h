//
//  ForgetPwdVC.h
//  Parents
//
//  Created by kfd on 15-2-9.
//  Copyright (c) 2015年 qzz. All rights reserved.
//

#import "PCBaseVC.h"
#import "SVProgressHUD.h"

@interface ForgetPwdVC : PCBaseVC

@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UITextField *vCodeTF;
@property (weak, nonatomic) IBOutlet UITextField *pwdNewTF;
@property (weak, nonatomic) IBOutlet UITextField *repeatNewPwdTF;
@property (weak, nonatomic) IBOutlet UIButton *getVCodeBtnOutlet;

- (IBAction)getVCodeBtnAction:(id)sender;
- (IBAction)confirmBtnAction:(id)sender;

@end
