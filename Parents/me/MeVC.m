//
//  MeVC.m
//  Parents
//
//  Created by kfd on 14-11-14.
//  Copyright (c) 2014年 qzz. All rights reserved.
//

#import "MeVC.h"

@interface MeVC ()

@end

@implementation MeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setHidden:NO];
    [self setBackButtonVisible:@"首页" andButtonFrame:NAVIGATION_RECT_MIN];
    self.navigationItem.title = @"我";
    
    NSUserDefaults *user = [PC_Globle shareUserDefaults];
    NSString *real_name_p = [user valueForKey:@"real_name_p"];
    NSString *real_name_c = [user valueForKey:@"real_name_c"];
    if(real_name_p.length != 0){
        [_parentNameLbl setText:real_name_p];
    }
    if(real_name_c.length != 0){
        [_childNameLbl setText:real_name_c];
    }
    
    [self boundGesture];
}

-(void)boundGesture{

    //个人信息
    [_meView setUserInteractionEnabled:YES];
    UITapGestureRecognizer *meGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(meAction)];
    [_meView addGestureRecognizer:meGesture];
    
    //账户余额
    [_accountMoneyView setUserInteractionEnabled:YES];
    UITapGestureRecognizer *accountMoneyGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(accountMoneyAction)];
    [_accountMoneyView addGestureRecognizer:accountMoneyGesture];
    
    //设置
    [_setView setUserInteractionEnabled:YES];
    UITapGestureRecognizer *settingGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(settingAction)];
    [_setView addGestureRecognizer:settingGesture];
    
    //账户安全
    [_accountSafeView setUserInteractionEnabled:YES];
    UITapGestureRecognizer *accountSafeGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(accountSafeAction)];
    [_accountSafeView addGestureRecognizer:accountSafeGesture];

}

-(void)forwardToPersonInfo{
    PersonInfoVC *personInfoVc = [[PersonInfoVC alloc] init];
    [self.navigationController pushViewController:personInfoVc animated:YES];
}

-(void)meAction{
    [self forwardToPersonInfo];
}

-(void)accountMoneyAction{
    AccountBalanceVC *accountBalanceVc = [[AccountBalanceVC alloc] init];
    [self.navigationController pushViewController:accountBalanceVc animated:YES];
}

-(void)settingAction{
    SettingVC *setVc = [[SettingVC alloc] init];
    [self.navigationController pushViewController:setVc animated:YES];
}

-(void)accountSafeAction{
    AccountSafeVC *accountSafeVc = [[AccountSafeVC alloc] init];
    [self.navigationController pushViewController:accountSafeVc animated:YES];
}

- (IBAction)settingBtnAction:(id)sender {
    [self settingAction];
}

- (IBAction)balanceBtnAction:(id)sender {
    [self accountMoneyAction];
}

- (IBAction)accountSaftBtnAction:(id)sender {
    [self accountSafeAction];
}

- (IBAction)meHeadBtnAction:(id)sender {
    [self forwardToPersonInfo];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)comeInPersonInfoBtnAction:(id)sender {
    [self forwardToPersonInfo];
}

@end
