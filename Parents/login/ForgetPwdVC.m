//
//  ForgetPwdVC.m
//  Parents
//
//  Created by kfd on 15-2-9.
//  Copyright (c) 2015年 qzz. All rights reserved.
//

#import "ForgetPwdVC.h"

@interface ForgetPwdVC (){

    NSInteger time;
    
    NSTimer *timer;
}

@end

@implementation ForgetPwdVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setBackButtonVisible:@"返回" andButtonFrame:NAVIGATION_RECT_MIN];
    self.title = @"修改密码";
    time = 60;
}

-(void)updateView{
    
    [_getVCodeBtnOutlet setUserInteractionEnabled:NO];
    time --;
    if (time == 0) {
        time = 60;
        [timer invalidate];
        [_getVCodeBtnOutlet setUserInteractionEnabled:YES];
        [_getVCodeBtnOutlet setTitle:@"获取验证码" forState:UIControlStateNormal];
        return;
    }
    [_getVCodeBtnOutlet setTitle:[NSString stringWithFormat:@"%ld后重新获取",(long)time] forState:UIControlStateNormal];
}

- (IBAction)getVCodeBtnAction:(id)sender {
    [self touchesBegan:nil withEvent:nil];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateView) userInfo:nil repeats:YES];
    
    [HTTPREQUEST requestWithPost:@"user/send_sms2.php" requestParams:@{@"phone":[_phoneTF text]} successBlock:^(NSData *data) {
        NSString *result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        if (![result isEqual:@"0"]) {
            NSLog(@"----vcode----%@",result);
        }
    } failedBlock:^(NSString *code, NSString *msg) {
    }];
}

- (IBAction)confirmBtnAction:(id)sender {
    
    NSString *phone = [_phoneTF text];
//    NSString *vCode = [_vCodeTF text];
    NSString *newPwd = [_pwdNewTF text];
    NSString *repeatNewPwd = [_repeatNewPwdTF text];
    
    if (phone.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入手机号" duration:1];
        return;
    }
    
//    if (vCode.length == 0) {
//        [SVProgressHUD showErrorWithStatus:@"请输入验证码" duration:1];
//        return;
//    }
    
    if (newPwd.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入新密码" duration:1];
        return;
    }
    
    if (repeatNewPwd.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入重复新密码" duration:1];
        return;
    }
    
    if (![newPwd isEqual:repeatNewPwd]) {
        [SVProgressHUD showErrorWithStatus:@"两次输入密码不一致" duration:1];
        return;
    }
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithCapacity:0];
    [dict setValue:phone forKey:@"phone"];
    [dict setValue:newPwd forKey:@"password"];
    [dict setValue:@"1" forKey:@"role"];
    
    [HTTPREQUEST requestWithPost:@"user/pwd_edit.php" requestParams:dict successBlock:^(NSData *data) {
        NSString *result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        if (![result isEqual:@"0"]) {
            NSLog(@"-------pwd update success-------%@:",result);
            [self.navigationController popViewControllerAnimated:YES];
        }
    } failedBlock:^(NSString *code, NSString *msg) {
        
    }];
}

//隐藏键盘
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [[event allTouches] anyObject];
    if (![[touch view] isKindOfClass:[UITextField class]]) {
        [self.view endEditing:YES];
    }
    [super touchesBegan:touches withEvent:event];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
