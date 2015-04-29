//
//  PtaskHeaderView.m
//  Parents
//
//  Created by kfd on 14/11/10.
//  Copyright (c) 2014年 qzz. All rights reserved.
//

#import "PtaskHeaderView.h"

@interface PtaskHeaderView(){

    NSTimer *timer;
}

@end

@implementation PtaskHeaderView

-(void)setFinishedTaskCount:(NSString *)finishedTaskCount{
    _finishedTaskCountLbl.text = finishedTaskCount;
    _currentTimeLbl.text = [self getCurrentTime];
}

-(void)awakeFromNib{
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(CurrentTimeUpdate) userInfo:nil repeats:YES];
}

-(void)CurrentTimeUpdate{
    [_currentTimeLbl setText:[self getCurrentTime]];
}

-(NSString *)getCurrentTime{
    NSDate *date = [NSDate date];
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"HH:mm"];
    NSString *currentTime = [dateformatter stringFromDate:date];
    return currentTime;
}

@end
