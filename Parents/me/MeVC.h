//
//  MeVC.h
//  Parents
//
//  Created by kfd on 14-11-14.
//  Copyright (c) 2014年 qzz. All rights reserved.
//

#import "PCBaseVC.h"
#import "SettingVC.h"
#import "AccountBalanceVC.h"
#import "AccountSafeVC.h"
#import "PersonInfoVC.h"

@interface MeVC : PCBaseVC
@property (weak, nonatomic) IBOutlet UIButton *settingBtnOutlet;
@property (weak, nonatomic) IBOutlet UIButton *balanceBtnOutlet;
@property (weak, nonatomic) IBOutlet UILabel *parentNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *childNameLbl;
@property (weak, nonatomic) IBOutlet UIImageView *myChildHeadIV;
@property (weak, nonatomic) IBOutlet UIButton *mHeadBtnOutlet;
@property (weak, nonatomic) IBOutlet UIView *meView;

@property (weak, nonatomic) IBOutlet UILabel *freeTryTimeLbl;
@property (weak, nonatomic) IBOutlet UILabel *jiFenLbl;
@property (weak, nonatomic) IBOutlet UIView *myChildView;
@property (weak, nonatomic) IBOutlet UIView *setView;
@property (weak, nonatomic) IBOutlet UIView *accountSafeView;
@property (weak, nonatomic) IBOutlet UIView *accountMoneyView;

- (IBAction)comeInPersonInfoBtnAction:(id)sender;
- (IBAction)meHeadBtnAction:(id)sender;
- (IBAction)settingBtnAction:(id)sender;
- (IBAction)balanceBtnAction:(id)sender;
- (IBAction)accountSaftBtnAction:(id)sender;

@end
