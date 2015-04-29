//
//  PersonInfoVC.h
//  Parents
//
//  Created by kfd on 14-12-15.
//  Copyright (c) 2014年 qzz. All rights reserved.
//

#import "RegistVC.h"
#import "NSString+Modify.h"

@interface RegistVC ()
{
    NSArray *titleArr;
    
    BOOL isExpansion;
    BOOL isCheckedChkBox;
    BOOL isRegisterSuccess;
    
    NSString *cityId;
    NSString *schoolId;
    NSString *gradeId;
    NSString *clazzId;
    
    NSString *phone;
    NSString *pwd;
    
    NSString *uid_C;
    NSString *uid_P;
    
    NSTimer *timer;
    
    NSInteger time;
}
@property (nonatomic, copy) void (^successedBlock)(void);
@end

@implementation RegistVC

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //自定义rightBarButton
    [self setBackButtonVisible:@"返回" andButtonFrame:NAVIGATION_RECT_MIN];
    
    //title
    self.title = @"独立注册";
    
    isExpansion = NO;
    isCheckedChkBox = YES;
    isRegisterSuccess = NO;
    
    time = 60;
}

-(void)registAction{
    
    phone = [_phoneNumTF text];
    pwd = [_pwdTF text];
//    NSString *vcode = [_verificationCodeTF text];
    
    if ([phone length] == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入手机号码" duration:1];
        return;
    }
    if (![phone isLegalPhoneNumber]) {
        [SVProgressHUD showErrorWithStatus:@"请输入合法的电话号码" duration:1];
        return;
    }
//    if ([vcode length] == 0) {
//        [SVProgressHUD showErrorWithStatus:@"请输入验证码" duration:1];
//        return;
//    }
    if ([pwd length] == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入密码" duration:1];
        return;
    }

    NSMutableDictionary *mutableUserDic = [NSMutableDictionary dictionaryWithCapacity:0];
    [mutableUserDic setObject:phone forKey:@"phone"];
    [mutableUserDic setObject:pwd forKey:@"password"];
    [mutableUserDic setObject:@"2" forKey:@"login_type"];
    [mutableUserDic setObject:@"0816e1a5295" forKey:@"channelid"];//[[PC_Globle shareUserDefaults] valueForKey:@"channelid"]
    
    [HTTPREQUEST requestWithPost:@"user/user_register.php" requestParams:mutableUserDic
                successBlock:^(NSData *data) {
        NSString *resultCode = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        if ([resultCode isEqual:@"-101"]) {
            [SVProgressHUD showErrorWithStatus:@"该帐号已被注册" duration:1];
            return;
        }
        
        if(![resultCode isEqual:@"0"]){
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            uid_C = [dic valueForKey:@"uid_c"];
            uid_P = [dic valueForKey:@"uid_p"];
            [[PC_Globle shareUserDefaults] setValue:uid_C forKey:@"uid_c"];
            [[PC_Globle shareUserDefaults] setValue:uid_P forKey:@"regist_uid_p"];
            [[PC_Globle shareUserDefaults] setValue:[dic valueForKey:@"role"] forKey:@"role"];
            isRegisterSuccess = YES;
          NSLog(@"register success:%@",dic);
       }
    } failedBlock:^(NSString *code, NSString *msg) {
        NSLog(@"code:%@-----msg:%@",code,msg);
    }];
}

-(void)loginAction{
    
    NSMutableDictionary *userDic = [NSMutableDictionary dictionaryWithCapacity:0];
    
//    NSString *channelId = [[PC_Globle shareUserDefaults] valueForKey:@"channelid"];
    [userDic setObject:phone forKey:@"phone"];
    [userDic setObject:pwd forKey:@"password"];
    [userDic setObject:@"2" forKey:@"login_type"];
    [userDic setObject:@"1" forKey:@"role"];
    [userDic setObject:@"0816e1a5295" forKey:@"channelid"];
    
    [HTTPREQUEST requestWithPost:@"user/user_login.php" requestParams:userDic
                    successBlock:^(NSData *data) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];

        NSString *uidP = [dic valueForKey:@"uid_p"];
        NSLog(@"login success ..requestResult:%@",dic);
        if (uidP.length != 0) {
            NSUserDefaults *userDefs = [PC_Globle shareUserDefaults];
            [userDefs setValue:[dic valueForKey:@"uid_c"] forKey:@"uid_c"];
            [userDefs setValue:[dic valueForKey:@"uid_p"] forKey:@"uid_p"];
            [userDefs setValue:[dic valueForKey:@"channelid"] forKey:@"channelid"];
            [userDefs setValue:[dic valueForKey:@"role"] forKey:@"role"];
            [userDefs setValue:[dic valueForKey:@"phone"] forKey:@"phone"];
            [userDefs synchronize];
        }
    } failedBlock:^(NSString *code, NSString *msg) {
  }];
}

- (IBAction)confirmRegisterBtnAction:(id)sender {
    [self registAction];
    if (isRegisterSuccess) {
        [self loginAction];
        TaskMainVC *taskMainVc = [[TaskMainVC alloc] init];
        [self.navigationController pushViewController:taskMainVc animated:YES];
    }
}

-(void)updateView{

    [_getVerificationBtnOutlet setUserInteractionEnabled:NO];
    time --;
    if (time == 0) {
        time = 60;
        [timer invalidate];
        [_getVerificationBtnOutlet setUserInteractionEnabled:YES];
        [_getVerificationBtnOutlet setTitle:@"获取验证码" forState:UIControlStateNormal];
        return;
    }
    [_getVerificationBtnOutlet setTitle:[NSString stringWithFormat:@"%ld后重新获取",(long)time] forState:UIControlStateNormal];
}

- (IBAction)getVerificationBtnAction:(id)sender {
    [self touchesBegan:nil withEvent:nil];
    
   timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateView) userInfo:nil repeats:YES];
    
    [HTTPREQUEST requestWithPost:@"user/send_sms2.php" requestParams:@{@"phone":[_phoneNumTF text]} successBlock:^(NSData *data) {
        NSString *result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        if (![result isEqual:@"0"]) {
            NSLog(@"----vcode----%@",result);
        }
    } failedBlock:^(NSString *code, NSString *msg) {
  }];
}

- (IBAction)checkBoxBtnAction:(id)sender {
    if (isCheckedChkBox) {
        [_checkBoxBtnOutlet setImage:[UIImage imageNamed:@"checkbox.png"] forState:UIControlStateNormal];
        isCheckedChkBox = NO;
    }else{
        [_checkBoxBtnOutlet setImage:[UIImage imageNamed:@"checkbox_yes.png"] forState:UIControlStateNormal];
        isCheckedChkBox = YES;
    }
}

//隐藏键盘
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [[event allTouches] anyObject];
    if (![[touch view] isKindOfClass:[UITextField class]]) {
        [self.view endEditing:YES];
    }
    [super touchesBegan:touches withEvent:event];
}

@end
