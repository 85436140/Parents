//
//  FilterTimeView.h
//  Parents
//
//  Created by kfd on 15-1-5.
//  Copyright (c) 2015年 qzz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DateTimePickerView.h"

@interface FilterTimeView : UIView

@property (weak, nonatomic) IBOutlet UIButton *startTimeBtnOutlet;
@property (weak, nonatomic) IBOutlet UIButton *endTimeBtnOutlet;
@property (weak, nonatomic) IBOutlet UIButton *finishedBtnOutlet;

- (IBAction)startTimeBtnAction:(id)sender;
- (IBAction)endTimeBtnAction:(id)sender;
- (IBAction)finishedBtnAction:(id)sender;

@property (copy, nonatomic) void (^filterTimeBlock)(NSString *startTimeStr,NSString *endTimeStr);
-(void)choiceFilterTimeBlock:(void(^)(NSString *startTimeStr,NSString *endTimeStr))filterTimeBlock;
@end
