//
//  LecutureDetailVC.m
//  Parents
//
//  Created by kfd on 14-11-12.
//  Copyright (c) 2014年 qzz. All rights reserved.
//

#import "LecutureDetailVC.h"

@interface LecutureDetailVC ()

@end

@implementation LecutureDetailVC

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:YES];
}

- (IBAction)backBtnAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)editBtnAction:(id)sender {
}

- (IBAction)collectBtnAction:(id)sender {
}

- (IBAction)shareBtnAction:(id)sender {
}

- (IBAction)textFontBtnAction:(id)sender {
}

-(void)setDataSourceWithOrganizerName:(NSString *)organizerName
                   andActivityTimeLbl:(NSString *)activityTime
                    andActivityFeeLbl:(NSString *)activityFee
                andActivityAddressLbl:(NSString *)activityAddress
                      andFitPeopleLbl:(NSString *)fitPeople
             andActitvityFrequencyLbl:(NSString *)activityFrequency
           andActivityPreferentialLbl:(NSString *)activityPreferential{
    [_organizersNameLbl setText:organizerName];
    [_activityTimeLbl setText:activityTime];
    [_activityFeeLbl setText:activityFee];
    [_activityAddressLbl setText:activityAddress];
    [_fitPeopleLbl setText:fitPeople];
    [_activityFrequencyLbl setText:activityFrequency];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setHidden:NO];
    self.navigationItem.title = @"成为更好的父母系列之三";
    [self setDataSourceWithOrganizerName:@"亲之助" andActivityTimeLbl:@"2014-10-28 10:00 to 11:30" andActivityFeeLbl:@"100元/人" andActivityAddressLbl:@"上海市浦东新区巨野路243号2楼亲之助" andFitPeopleLbl:@"6~12岁儿童" andActitvityFrequencyLbl:@"两周一次" andActivityPreferentialLbl:@"父母同来半价，单亲家庭半价，会员半价"];
    [self setBackButtonVisible:@"返回" andButtonFrame:NAVIGATION_RECT_MIN];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
