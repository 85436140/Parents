//
//  AddRewardVC.h
//  Parents
//
//  Created by kfd on 14-11-11.
//  Copyright (c) 2014年 qzz. All rights reserved.
//

#import "PCBaseVC.h"
#import "SVProgressHUD.h"
#import "RewardSetVC.h"

@interface AddRewardVC : PCBaseVC

@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIView *exchangeConditionView;
@property (weak, nonatomic) IBOutlet UIButton *confirmAddBtnOutlet;
- (IBAction)confirmAddBtnAction:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *contentTF;
@property (weak, nonatomic) IBOutlet UITextField *integralTF;
+(void)showAddRewardWithSuccesBlock:(void(^)(void))successBlock withController:(UIViewController *)viewController;
@end
