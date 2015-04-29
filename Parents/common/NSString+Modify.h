//
//  NSString+Modify.h
//  P_Child
//
//  Created by kfd on 14-10-23.
//  Copyright (c) 2014年 qzz. All rights reserved.
//
#import <Foundation/Foundation.h>

@interface NSString (Modify)

// 是否是合法电话号码
- (BOOL)isLegalPhoneNumber;

// 是否是合法电子邮箱地址
- (BOOL)isLegalEmailAddress;

// 判断密码格式是否正确
- (BOOL)isLegalPassword;

///得到当前的时间
+(NSString*)dateToNSString;

// 判断是否是整型
- (BOOL)isPureInt;

// 判断是否是浮点型
- (BOOL)isPureFloat;
@end
