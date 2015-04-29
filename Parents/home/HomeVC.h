//
//  HomeVC.h
//  Parents
//
//  Created by kfd on 14-11-7.
//  Copyright (c) 2014年 qzz. All rights reserved.
//

#import "PCBaseVC.h"
#import "LoginVC.h"
#import "TaskMainVC.h"
#import "ChildLocation.h"
#import "MyCircleVC.h"
#import "MyReadMainVC.h"
#import "MeVC.h"
#import "SVProgressHUD.h"

@interface HomeVC : PCBaseVC

@property (weak, nonatomic) IBOutlet UIButton *loginBtnOutlet;
@property (weak, nonatomic) IBOutlet UIButton *qrCodeBtnOutlet;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UILabel *nameLbl;
@property (weak, nonatomic) IBOutlet UIButton *loginHeadBtnOutlet;

- (IBAction)loginHeadBtnAction:(id)sender;
- (IBAction)loginBtnAction:(id)sender;
- (IBAction)myChildBtnAction:(id)sender;
- (IBAction)childLoctionBtnAction:(id)sender;
- (IBAction)myReadBtnAction:(id)sender;
- (IBAction)myCircleBtnAction:(id)sender;
- (IBAction)qrCodeBtnAction:(id)sender;

@end
