//
//  DateTimePickerView.m
//  Parents
//
//  Created by kfd on 15-1-5.
//  Copyright (c) 2015年 qzz. All rights reserved.
//

#import "DateTimePickerView.h"

@interface DateTimePickerView(){

    NSDateComponents *comps;
    NSInteger year;
    NSInteger month;
    NSInteger day;
}

@end

@implementation DateTimePickerView

-(void)awakeFromNib{
    [super awakeFromNib];
    [self initWithDateComponents];
}

-(void)choiceFilterTimeBlock:(void(^)(NSString *filterTime))filterTimeBlock{
    _filterTimeBlock = filterTimeBlock;
}

-(void)initWithDateComponents{
    NSDate *nowdata = [[NSDate alloc] init];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
    comps = [calendar components:unitFlags fromDate:nowdata];
    year = [comps year];
    month = [comps month];
    day = [comps day];
    [_yearTF setText:[NSString stringWithFormat:@"%ld",year]];
    [_monthTF setText:[NSString stringWithFormat:@"%ld",month]];
    [_dayTF setText:[NSString stringWithFormat:@"%ld",day]];
}

- (IBAction)yearAddBtnAction:(id)sender {
    year++;
    [_yearTF setText:[NSString stringWithFormat:@"%ld",year]];
}

- (IBAction)monthAddBtnAction:(id)sender {
    month++;
    if (month > 12) {
        year++;
        month = 1;
    }
    [_yearTF setText:[NSString stringWithFormat:@"%ld",year]];
    [_monthTF setText:[NSString stringWithFormat:@"%ld",month]];
}

- (IBAction)dayAddBtnAction:(id)sender {
    day++;
    if (day > 31) {
        day = 1;
    }
    [_dayTF setText:[NSString stringWithFormat:@"%ld",day]];
}

- (IBAction)yearDiffBtnAction:(id)sender {
    year--;
    [_yearTF setText:[NSString stringWithFormat:@"%ld",year]];
}

- (IBAction)monthDiffBtnAction:(id)sender {
    month--;
    if (month < 1) {
        year--;
        month = 12;
    }
    [_yearTF setText:[NSString stringWithFormat:@"%ld",year]];
    [_monthTF setText:[NSString stringWithFormat:@"%ld",month]];
}

- (IBAction)dayDiffBtnAction:(id)sender {
    day--;
    if (day < 1) {
        day = 31;
    }
    [_dayTF setText:[NSString stringWithFormat:@"%ld",day]];
}

- (IBAction)finishedBtnAction:(id)sender {
    NSString *timeStr = [NSString stringWithFormat:@"%ld-%ld-%ld",year,month,day];
    _filterTimeBlock(timeStr);
    [self setFrame:CGRectMake(0, 0, WIDTH(self), 1)];
    [self setHidden:YES];
}

@end
