//
//  LoginViewController.m
//  P_Child
//
//  Created by kfd on 14-10-20.
//  Copyright (c) 2014年 qzz. All rights reserved.
//

#import "LoginVC.h"

#define bgView_height 300
#define MARGIN 20

@interface LoginVC ()
@property (nonatomic,strong) void (^successBlock)();
@end

@implementation LoginVC

- (IBAction)loginBtnAction:(id)sender {
    [self loginAction];
}

- (IBAction)createAccountBtnAction:(id)sender {
    RegistVC *registeVc = [[RegistVC alloc] init];
    [self.navigationController pushViewController:registeVc animated:YES];
}

- (IBAction)forgetPwdBtnAction:(id)sender {
    ForgetPwdVC *forgetPwdVc = [[ForgetPwdVC alloc] init];
    [self.navigationController pushViewController:forgetPwdVc animated:YES];
}

+(void)showLoginVCWithSuccesBlock:(void(^)(void))successBlock withController:(UIViewController *)viewController
{
    LoginVC *loginvc = [[LoginVC alloc] initWithSuccesBlock:successBlock];
    UINavigationController *naVC = [[UINavigationController alloc] initWithRootViewController:loginvc];
    [naVC.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_bg"] forBarMetrics:UIBarMetricsDefault];
    [viewController.navigationController presentViewController:naVC animated:YES completion:nil];
}

-(id)initWithSuccesBlock:(void(^)(void))successBlock
{
    self = [super init];
    if (self) {
        _successBlock = successBlock;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setHidden:NO];
    [self setBackButtonVisible:@"返回" andButtonFrame:NAVIGATION_RECT_MIN];
    self.title = @"登录";
    
    UIButton *confirmBtn = [PCBaseVC initWithBtn:@"确定" andBtnFrame:NAVIGATION_RECT_MIN];
    [confirmBtn addTarget:self action:@selector(confirmAction) forControlEvents:UIControlEventTouchUpInside];
    [self setNavigationRightBtn:confirmBtn];
}

-(void)confirmAction{
    [self loginAction];
}

-(void)loginAction{
    
    NSString *phone = [_phoneTF text];
    NSString *pwd = [_pwdTF text];
    
    NSMutableDictionary *userDic = [NSMutableDictionary dictionaryWithCapacity:0];

    if ([phone length] == 0 ) {
        [SVProgressHUD showErrorWithStatus:@"请输入帐号" duration:1];
        return;
    }
    if ([pwd length] == 0 ) {
        [SVProgressHUD showErrorWithStatus:@"请输入密码" duration:1];
        return;
    }
//    NSString *channelId = [[PC_Globle shareUserDefaults] valueForKey:@"channelid"];
    [userDic setObject:phone forKey:@"phone"];
    [userDic setObject:pwd forKey:@"password"];
    [userDic setObject:@"2" forKey:@"login_type"];
    [userDic setObject:@"1" forKey:@"role"];
    //    [userDic setObject:channelId forKey:@"channelid"];
    
    [HTTPREQUEST requestWithPost:@"user/user_login.php" requestParams:userDic
                successBlock:^(NSData *data) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            if(dic == nil ||dic.count == 0){
                [SVProgressHUD showErrorWithStatus:@"用户名或密码错误" duration:1];
                return;
            }
        NSString *uid_P = [dic valueForKey:@"uid_p"];
        NSLog(@"login success ..requestResult:%@",dic);
        if (uid_P.length != 0) {
            NSUserDefaults *userDefs = [PC_Globle shareUserDefaults];
            [userDefs setValue:[dic valueForKey:@"uid_c"] forKey:@"uid_c"];
            [userDefs setValue:[dic valueForKey:@"uid_p"] forKey:@"uid_p"];
//            [userDefs setValue:[dic valueForKey:@"channelid"] forKey:@"channelid"];
            [userDefs setValue:[dic valueForKey:@"role"] forKey:@"role"];
            [userDefs setValue:[dic valueForKey:@"phone"] forKey:@"phone"];
            [userDefs synchronize];
            
            [self forwardToMainTask];
        }
    } failedBlock:^(NSString *code, NSString *msg) {
        [SVProgressHUD showErrorWithStatus:msg duration:1];
    }];
}

-(void)forwardToMainTask{
     [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    _successBlock();
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
