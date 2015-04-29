//
//  DateTimePickerView.h
//  Parents
//
//  Created by kfd on 15-1-5.
//  Copyright (c) 2015年 qzz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DateTimePickerView : UIView

@property (weak, nonatomic) IBOutlet UITextField *yearTF;
@property (weak, nonatomic) IBOutlet UITextField *monthTF;
@property (weak, nonatomic) IBOutlet UITextField *dayTF;

- (IBAction)yearAddBtnAction:(id)sender;
- (IBAction)monthAddBtnAction:(id)sender;
- (IBAction)dayAddBtnAction:(id)sender;
- (IBAction)yearDiffBtnAction:(id)sender;
- (IBAction)monthDiffBtnAction:(id)sender;
- (IBAction)dayDiffBtnAction:(id)sender;
- (IBAction)finishedBtnAction:(id)sender;

@property (copy, nonatomic) void (^filterTimeBlock)(NSString *filterTimeStr);
-(void)choiceFilterTimeBlock:(void(^)(NSString *filterTime))filterTimeBlock;
@end
