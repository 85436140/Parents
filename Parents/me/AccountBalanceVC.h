//
//  AccountBalanceVC.h
//  Parents
//
//  Created by kfd on 14-11-14.
//  Copyright (c) 2014年 qzz. All rights reserved.
//

#import "PCBaseVC.h"

@interface AccountBalanceVC : PCBaseVC<UIPickerViewDelegate,UIPickerViewDataSource>

@property (weak, nonatomic) IBOutlet UITextField *rechargeTextFeild;
@property (weak, nonatomic) IBOutlet UIPickerView *rechargePickerView;
@property (weak, nonatomic) IBOutlet UIView *rechargeView;

@property (weak, nonatomic) IBOutlet UIButton *payBtnOutlet;
- (IBAction)payBtnAction:(id)sender;
- (IBAction)FeeDDLBtnAction:(id)sender;
@end
