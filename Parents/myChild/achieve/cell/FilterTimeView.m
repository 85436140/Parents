//
//  FilterTimeView.m
//  Parents
//
//  Created by kfd on 15-1-5.
//  Copyright (c) 2015年 qzz. All rights reserved.
//

#import "FilterTimeView.h"

@interface FilterTimeView(){

    NSDateComponents *comps;
    DateTimePickerView *dateTimePV;
    
    NSString *filterTimeStr;
    NSInteger year;
    NSInteger month;
    NSInteger day;
    NSInteger btnTag;
}

@end

@implementation FilterTimeView

-(void)initWithDateComponents{
    NSDate *nowdata = [[NSDate alloc] init];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
    comps = [calendar components:unitFlags fromDate:nowdata];
    year = [comps year];
    month = [comps month];
    day = [comps day];
    NSString *timeStr = [NSString stringWithFormat:@"%ld-%ld-%ld",year,month,day];
    [_startTimeBtnOutlet setTitle:timeStr forState:UIControlStateNormal];
    [_endTimeBtnOutlet setTitle:timeStr forState:UIControlStateNormal];
}

-(void)awakeFromNib{

    [super awakeFromNib];
    [self initWithDateComponents];
    btnTag = 0;
    dateTimePV = [[[NSBundle mainBundle] loadNibNamed:@"DateTimePickerView" owner:self options:nil] objectAtIndex:0];
    [dateTimePV setHidden:YES];
}

- (IBAction)startTimeBtnAction:(id)sender {
    
    [dateTimePV setFrame:CGRectMake(SCREEN_WIDTH/2-70, 0, WIDTH(dateTimePV), 100)];
    [dateTimePV setHidden:NO];
    [dateTimePV choiceFilterTimeBlock:^(NSString *filterTime) {
        [_startTimeBtnOutlet setTitle:filterTime forState:UIControlStateNormal];
    }];
    [self addSubview:dateTimePV];
    btnTag = 0;
}

- (IBAction)endTimeBtnAction:(id)sender {
    
    [dateTimePV setFrame:CGRectMake(SCREEN_WIDTH/2-70, 0, WIDTH(dateTimePV), 100)];
    [dateTimePV setHidden:NO];
    [dateTimePV choiceFilterTimeBlock:^(NSString *filterTime) {
        [_endTimeBtnOutlet setTitle:filterTime forState:UIControlStateNormal];
    }];
    btnTag = 1;
    [self addSubview:dateTimePV];
}

-(void)choiceFilterTimeBlock:(void(^)(NSString *startTimeStr,NSString *endTimeStr))filterTimeBlock{
    _filterTimeBlock = filterTimeBlock;
}

- (IBAction)finishedBtnAction:(id)sender {
    NSString *startTime = [_startTimeBtnOutlet.titleLabel text];
    NSString *endTime = [_endTimeBtnOutlet.titleLabel text];
    _filterTimeBlock(startTime,endTime);
    [self setFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
    [self setHidden:YES];
}
@end
