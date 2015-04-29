//
//  OldTaskView.m
//  Parents
//
//  Created by kfd on 14-11-11.
//  Copyright (c) 2014年 qzz. All rights reserved.
//

#import "OldTaskView.h"

@implementation OldTaskView

-(instancetype)initWithFrame:(CGRect)frame{

    self = [[[NSBundle mainBundle] loadNibNamed:@"OldTaskView" owner:self options:nil]objectAtIndex:0];
    if (self) {
        ViewBorderRadius(_timeAllotView, 10, 0, [UIColor whiteColor]);
        ViewBorderRadius(_oneWeekView, 10, 0, [UIColor whiteColor]);
        ViewBorderRadius(_myAchieveView, 10, 0, [UIColor whiteColor]);
        ViewBorderRadius(_myGrownView, 10, 0, [UIColor whiteColor]);
    }
    return self;
}

-(void)comeInReportBlock:(void(^)(NSInteger bTag))comeInReport{
    _comeInReportBlock = comeInReport;
}

- (IBAction)timeControlBtnAction:(id)sender {
    _comeInReportBlock([sender tag]);
}

- (IBAction)timeAllotBtnAction:(id)sender {
    _comeInReportBlock([sender tag]);
}

- (IBAction)onceWeekBtnAction:(id)sender {
    _comeInReportBlock([sender tag]);
}

- (IBAction)myAchieveBtnAction:(id)sender {
    _comeInReportBlock([sender tag]);
}

- (IBAction)myGrownBtnAction:(id)sender {
    _comeInReportBlock([sender tag]);
}
@end
