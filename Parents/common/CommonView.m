//
//  CommonView.m
//  P_Child
//
//  Created by kfd on 14-10-23.
//  Copyright (c) 2014年 qzz. All rights reserved.
//

#import "CommonView.h"

@implementation CommonView

+(void)animationWithPicker:(BOOL)isAdd andView:(UIView *)animView andSpacing:(NSInteger)spaceing{
    
    if (isAdd) {
        [UIView animateWithDuration:0.2 animations:^{
            [animView setFrame:CGRectMake(X(animView), Y(animView), WIDTH(animView), HEIGH(animView)+spaceing)];
        }];
    }else{
        [UIView animateWithDuration:0.2 animations:^{
            [animView setFrame:CGRectMake(X(animView), Y(animView), WIDTH(animView), HEIGH(animView)-spaceing)];
        }];
    }
}

+(void)animationWithSapceing:(BOOL)isAdd andView:(UIView *)animView andSpacing:(NSInteger)spaceing{
    
    if (isAdd) {
        [UIView animateWithDuration:0.2 animations:^{
            [animView setFrame:CGRectMake(X(animView), Y(animView)+spaceing, WIDTH(animView), HEIGH(animView))];
        }];
    }else{
        [UIView animateWithDuration:0.2 animations:^{
            [animView setFrame:CGRectMake(X(animView), Y(animView)-spaceing, WIDTH(animView), HEIGH(animView))];
        }];
    }
}

+(NSString *)changetimeStamp:(NSString *)timeStamp andFormatter:(NSString *)format{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    if (format.length == 0) {
        [formatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    }else{
        [formatter setDateFormat:format];
    }
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[timeStamp intValue]];
    return [formatter stringFromDate:date];
}

+(NSString *)changeDateToTimeStamp:(NSString *)date{

    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    NSDate *datenow = [df dateFromString:date];
    NSString *timestamp = [NSString stringWithFormat:@"%ld",(long)[datenow timeIntervalSince1970]];
    return timestamp;
}

+(NSDateComponents *)changetimeStampToDateComponents:(NSString *)timeStamp andFormatter:(NSString *)format{
    
    NSCalendar *calender = [NSCalendar currentCalendar];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    if (format.length == 0) {
        [formatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    }else{
        [formatter setDateFormat:format];
    }
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[timeStamp intValue]];
    NSDateComponents *comps =[calender components:(NSWeekCalendarUnit | NSWeekdayCalendarUnit |NSWeekdayOrdinalCalendarUnit) fromDate:date];
    return comps;
}

+(UIView *)initWithRatingBar:(NSInteger)num andView:(UIView *)myView{

    UIImage *image = [UIImage imageNamed:@"star"];
    for (int i = 0; i < num; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i*20+5, 0, 20, 20)];
        [imageView setImage:image];
        [myView addSubview:imageView];
    }
    return myView;
}

+(NSString *)subStringWithStr:(NSString *)str{

    return [str substringWithRange:NSMakeRange(1, str.length-1)];
}

+(NSString *)systemCurrentTime{
    
    NSDate *date = [[NSDate alloc] init];
    return [NSString stringWithFormat:@"%ld",(long)[date timeIntervalSince1970]] ;
}

@end
