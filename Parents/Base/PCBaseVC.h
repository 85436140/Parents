//
//  PCBaseVC.h
//  P_Child
//
//  Created by kfd on 14/10/29.
//  Copyright (c) 2014年 qzz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonView.h"

@interface PCBaseVC : UIViewController

+(UIButton *)initWithBtn:(NSString *)titleName andBtnFrame:(CGRect)btnFrame;
+(UIView *)customHeadView:(NSString *)headTitle;

-(void)setBackButtonVisible:(NSString *)titleName andButtonFrame:(CGRect)buttonFrame;
-(void)setNavigationLeftBtn:(UIButton *)btn;
-(void)setNavigationRightBtn:(UIButton *)btn;
-(void)setNavigationTitle:(UILabel *)titleLbl;
-(void)reloadView;
@end
