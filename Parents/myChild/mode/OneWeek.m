//
//  OneWeek.m
//  Parents
//
//  Created by kfd on 14-11-28.
//  Copyright (c) 2014年 qzz. All rights reserved.
//

#import "OneWeek.h"

@implementation OneWeek

+(OneWeek *)boundDataWithOneWeek:(NSDictionary *)dic{
    
    OneWeek *oneweek = [[OneWeek alloc]init];
    NSInteger planTime = [dic[@"plan_time_total"] intValue];
    NSInteger costTime = [dic[@"cost_time_total"] intValue];
    NSInteger chabie = planTime - costTime;

    oneweek.weekday = [dic[@"week_day"] intValue];
    oneweek.taskCount = [dic[@"task_count"] intValue];
    oneweek.planTime = planTime;
    oneweek.costTime = costTime;
    oneweek.chabie = chabie;
    return oneweek;
}
@end
