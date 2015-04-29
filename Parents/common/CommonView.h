//
//  CommonView.h
//  P_Child
//
//  Created by kfd on 14-10-23.
//  Copyright (c) 2014年 qzz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommonView : UIView

+(void)animationWithPicker:(BOOL)isAdd andView:(UIView *)animView andSpacing:(NSInteger)spaceing;
+(void)animationWithSapceing:(BOOL)isAdd andView:(UIView *)animView andSpacing:(NSInteger)spaceing;

+(UIView *)initWithRatingBar:(NSInteger)num andView:(UIView *)myView;
/**
 *把时间戳转换为时间
 */
+(NSString *)changetimeStamp:(NSString *)timeStamp andFormatter:(NSString *)format;

/**
 *把时间转换为时间戳
 */
+(NSString *)changeDateToTimeStamp:(NSString *)date;

/**
 * 把时间戳转换为日期
 * [comps week]       今年的第几周
 * [comps weekday]   星期几（注意，周日是“1”，周一是“2”。。。。）
 * [comps weekdayOrdinal] 这个月的第几周
 */
+(NSDateComponents *)changetimeStampToDateComponents:(NSString *)timeStamp andFormatter:(NSString *)format;

/**
 *截取字符串
 */
+(NSString *)subStringWithStr:(NSString *)str;

/**
 *获取系统当前时间
 */
+(NSString *)systemCurrentTime;

@end
