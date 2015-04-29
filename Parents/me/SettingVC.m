//
//  Setting.m
//  Parents
//
//  Created by kfd on 14-11-14.
//  Copyright (c) 2014年 qzz. All rights reserved.
//

#import "SettingVC.h"

@interface SettingVC ()<UIAlertViewDelegate>

@end

@implementation SettingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setBackButtonVisible:@"返回" andButtonFrame:NAVIGATION_RECT_MIN];
    self.navigationItem.title = @"设置";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)exitBtnAction:(id)sender {
    
    UIAlertView *exitAlert = [[UIAlertView alloc] initWithTitle:@"是否确认退出" message:nil delegate:self cancelButtonTitle:@"Cancle" otherButtonTitles:@"OK", nil];
    [exitAlert show];
}

-(void)loginOut{

    NSString *uid = [[PC_Globle shareUserDefaults] valueForKey:@"uid_p"];
    [HTTPREQUEST requestWithPost:@"user/user_loginout.php" requestParams:@{@"uid":uid} successBlock:^(NSData *data) {
        NSString *result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        if (![result isEqual:@"0"]) {
            
        }
    } failedBlock:^(NSString *code, NSString *msg) {
        
    }];
}

#pragma mark -- UIAlertView delegete
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{

    if (buttonIndex == 1) {
        NSUserDefaults *userDefaults = [PC_Globle shareUserDefaults];
        NSDictionary *dictionary = [userDefaults dictionaryRepresentation];
        for(NSString *key in [dictionary allKeys]){
            [userDefaults removeObjectForKey:key];
            [userDefaults synchronize];
        }
        exit(0);
    }
}

@end
