//
//  PersonDatasView.h
//  Parents
//
//  Created by kfd on 14/12/17.
//  Copyright (c) 2014年 qzz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomAlertView : UIView<UIPickerViewDataSource,UIPickerViewDelegate>
@property (nonatomic,strong) NSArray *dataList1;
@property (nonatomic,strong) NSArray *dataList2;
@property (nonatomic,strong) NSArray *dataList3;
@property (nonatomic,assign) NSUInteger rowOfCompent;

@property (weak, nonatomic) IBOutlet UIPickerView *pickView;

@property (nonatomic,strong) UIView *superView;
@property (nonatomic,strong) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UIView *pickerBottomView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *FixedSpacePx;

@property (nonatomic,strong) NSString *row1Str;
@property (nonatomic,strong) NSString *row1;
@property (nonatomic,strong) NSString *row2Str;
@property (nonatomic,strong) NSString *row2;
@property (nonatomic,strong) NSString *row3Str;
@property (nonatomic,strong) NSString *row3;

@property (nonatomic,strong) NSDictionary *dicKey;

@property (nonatomic,strong) void (^CancelBlock)(void);
@property (nonatomic,strong) void (^sureBlock)(NSString *row1,NSString *row1Str,NSString *row2,NSString *row2Str,NSString *row3,NSString *row3Str);

-(void)setDataSource:(NSArray *)dataList1
       withDataList2:(NSArray *)dataList2
       withDataList3:(NSArray *)dataList3
             withKey:(NSDictionary *)dicKey
         cancelBlock:(void(^)(void))cancelBlock
           sureBlock:(void(^)(NSString *row1,NSString *row1Str,NSString *row2,NSString *row2Str,NSString *row3,NSString *row3Str))sureBlock;
-(void)showInView:(UIView *)superView;

- (IBAction)ClickCancelbar:(id)sender;
- (IBAction)ClickSureBar:(id)sender;

@end
