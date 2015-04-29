//
//  RewardPopView.h
//  Parents
//
//  Created by kfd on 14-11-11.
//  Copyright (c) 2014年 qzz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SVProgressHUD.h"
#import "CheckDetailVC.h"

@protocol ReFreshViewDelegate <NSObject>

-(void)refreshView;

@end

@interface RewardPopView : UIView<UIPickerViewDelegate,UIPickerViewDataSource>
@property (weak, nonatomic) IBOutlet UIButton *addBtnOutlet;
@property (weak, nonatomic) IBOutlet UIButton *diffBtnOutlet;
@property (weak, nonatomic) IBOutlet UIView *rankView;
@property (weak, nonatomic) IBOutlet UIView *dropdownList;
@property (weak, nonatomic) IBOutlet UITextField *selectValueTextField;
@property (weak, nonatomic) IBOutlet UIPickerView *encourageNotePickerView;

@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UIButton *cancleBtnOutlet;
@property (weak, nonatomic) IBOutlet UIButton *sendBtnOutlet;
@property (weak, nonatomic) IBOutlet UIView *encourageView;

//委托界面刷新
@property (weak, nonatomic) id <ReFreshViewDelegate> delegate;

- (IBAction)commentDDLBtnAction:(id)sender;

- (IBAction)cancleBtnAction:(id)sender;
- (IBAction)addBtnAction:(id)sender;
- (IBAction)diffBtnAction:(id)sender;
- (IBAction)sendBtnAction:(id)sender;
-(void)initwithTaskId:(NSInteger)tid;
+(void)showCheckDetailVCWithBlock:(void(^)(NSDictionary *dict))sccessBlock withVC:(UINavigationController *)vc;
@end
