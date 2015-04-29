//
//  AccountBalanceVC.m
//  Parents
//
//  Created by kfd on 14-11-14.
//  Copyright (c) 2014年 qzz. All rights reserved.
//

#import "AccountBalanceVC.h"

@interface AccountBalanceVC (){

    NSArray *moneyArr;
    BOOL isExpansion;
}

@end

@implementation AccountBalanceVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setBackButtonVisible:@"返回" andButtonFrame:NAVIGATION_RECT_MIN];
    self.title = @"账户余额";
    moneyArr = @[@"30/月",@"168/半年",@"298/年"];
    isExpansion = NO;
}

#pragma mark -- pickerView
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [moneyArr count];
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    return [moneyArr objectAtIndex:row];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    [_rechargeTextFeild setText:[moneyArr objectAtIndex:row]];
    [CommonView animationWithPicker:NO andView:_rechargeView andSpacing:100];
    isExpansion = NO;
    [_rechargePickerView setHidden:YES];
}

- (IBAction)payBtnAction:(id)sender {
}

- (IBAction)FeeDDLBtnAction:(id)sender {
    if (isExpansion) {
        [CommonView animationWithPicker:NO andView:_rechargeView andSpacing:100];
        isExpansion = NO;
        [_rechargePickerView setHidden:YES];
    }else{
        [CommonView animationWithPicker:YES andView:_rechargeView andSpacing:100];
        isExpansion = YES;
        [_rechargePickerView setHidden:NO];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
