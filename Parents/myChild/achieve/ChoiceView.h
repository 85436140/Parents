//
//  ChoiceView.h
//  Parents
//
//  Created by kfd on 14-11-14.
//  Copyright (c) 2014年 qzz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChoiceView : UIView<UIPickerViewDelegate,UIPickerViewDataSource>
@property (weak, nonatomic) IBOutlet UIView *startDateTimeDDLView;
@property (weak, nonatomic) IBOutlet UIView *endDateTimeDDLView;

@property (weak, nonatomic) IBOutlet UITextField *startDateTimeTextFeild;
@property (weak, nonatomic) IBOutlet UITextField *endDateTimeTextFeild;

@property (weak, nonatomic) IBOutlet UIPickerView *startDateTimePickerView;
@property (weak, nonatomic) IBOutlet UIPickerView *endDateTimePickerView;

@property (weak, nonatomic) IBOutlet UIButton *confirmBtnOutlet;
- (IBAction)confirmBtnAction:(id)sender;

@property (copy, nonatomic) void (^confirmBlock)(void);
-(void)confirmBtnBlock:(void(^)(void))confirmBtn;
@end
