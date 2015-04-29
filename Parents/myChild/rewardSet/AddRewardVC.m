//
//  AddRewardVC.m
//  Parents
//
//  Created by kfd on 14-11-11.
//  Copyright (c) 2014年 qzz. All rights reserved.
//

#import "AddRewardVC.h"

@interface AddRewardVC ()
@property (nonatomic,strong) void (^successBlock)();
@end

@implementation AddRewardVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setBackButtonVisible:@"返回" andButtonFrame:NAVIGATION_RECT_MIN];
    self.navigationItem.title = @"添加奖励";
    
    UIButton *rightBtn = [PCBaseVC initWithBtn:@"确定" andBtnFrame:NAVIGATION_RECT_MIN];
    [rightBtn addTarget:self action:@selector(comfirmAction) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn.titleLabel setFont:[UIFont systemFontOfSize:16]];
    [self setNavigationRightBtn:rightBtn];
}

-(id)initWithSuccesBlock:(void(^)(void))successBlock
{
    self=[super init];
    if (self) {
        _successBlock=successBlock;
    }
    return self;
}

+(void)showAddRewardWithSuccesBlock:(void(^)(void))successBlock withController:(UIViewController *)viewController
{
    AddRewardVC *addReward = [[AddRewardVC alloc]initWithSuccesBlock:successBlock];
    UINavigationController *naVC = [[UINavigationController alloc] initWithRootViewController:addReward];
    [naVC.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_bg"] forBarMetrics:UIBarMetricsDefault];
    [viewController.navigationController presentViewController:naVC animated:YES completion:nil];
}

-(void)comfirmAction{

    [self touchesBegan:nil withEvent:nil];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:0];
    
    NSString *content = [_contentTF text];
    NSString *integral = [_integralTF text];
    if ([content length] == 0 || [integral length] == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入内容或积分" duration:1];
        return;
    }
    
    [dic setValue:[PC_Globle.shareUserDefaults valueForKey:@"uid_p"] forKey:@"uid"];
    [dic setValue:content forKey:@"award"];
    [dic setValue:integral forKey:@"factor"];
    [HTTPREQUEST requestWithPost:@"task/task_award_add.php" requestParams:dic successBlock:^(NSData *data) {
        NSString *result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        if(![result isEqual:@"0"]){
            NSLog(@"====添加奖励成功=====%@",[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding]);
            [self forwardToReward];
        }
    } failedBlock:^(NSString *code, NSString *msg) {
        
    }];
}

- (IBAction)confirmAddBtnAction:(id)sender {
    
    [self comfirmAction];
}

//隐藏键盘
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [[event allTouches] anyObject];
    if (![[touch view] isKindOfClass:[UITextField class]]) {
        [self.view endEditing:YES];
    }
    [super touchesBegan:touches withEvent:event];
}

-(void)forwardToReward{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    _successBlock();
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
