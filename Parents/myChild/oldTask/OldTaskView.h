//
//  OldTaskView.h
//  Parents
//
//  Created by kfd on 14-11-11.
//  Copyright (c) 2014年 qzz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OldTaskView : UIView

@property (weak, nonatomic) IBOutlet UIButton *timeControlBtnOutlet;
@property (weak, nonatomic) IBOutlet UIButton *timeAllotBtnOutlet;
@property (weak, nonatomic) IBOutlet UIButton *onceWeekBtnOutlet;
@property (weak, nonatomic) IBOutlet UIButton *myAchieveBtnOutlet;
@property (weak, nonatomic) IBOutlet UIButton *myGrownBtnOutlet;
@property (weak, nonatomic) IBOutlet UIView *timeAllotView;
@property (weak, nonatomic) IBOutlet UIView *oneWeekView;
@property (weak, nonatomic) IBOutlet UIView *myAchieveView;
@property (weak, nonatomic) IBOutlet UIView *myGrownView;

@property (copy, nonatomic) void (^comeInReportBlock)(NSInteger bTag);

- (IBAction)timeControlBtnAction:(id)sender;
- (IBAction)timeAllotBtnAction:(id)sender;
- (IBAction)onceWeekBtnAction:(id)sender;
- (IBAction)myAchieveBtnAction:(id)sender;
- (IBAction)myGrownBtnAction:(id)sender;

-(void)comeInReportBlock:(void(^)(NSInteger bTag))comeInReport;

@end
