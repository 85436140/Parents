//
//  Task.m
//  Parents
//
//  Created by kfd on 14-11-26.
//  Copyright (c) 2014年 qzz. All rights reserved.
//

#import "Task.h"

#define P_Task [Task shareTaskInstance]

static Task *taskInstance = nil;

@implementation Task

+(Task *)shareTaskInstance{
    @synchronized(self) {
        if (nil == taskInstance) {
            taskInstance = [[Task alloc] init];
        }
    }
    return taskInstance;
}

+(Task *)boundTaskDataWithdict:(NSDictionary *)dic
{
    Task *boundTask = [[Task alloc]init];
    boundTask.taskId = dic[@"tid"];
    boundTask.taskName = dic[@"task_name"];
    boundTask.name_type_id = dic[@"name_type_id"];
    boundTask.taskType = dic[@"task_type"];
    boundTask.addTime = dic[@"add_time"];
    boundTask.comment = dic[@"comment"];
    boundTask.planTime = dic[@"plan_time"];
    boundTask.startTime = dic[@"start_time"];
    boundTask.planStartTime = dic[@"plan_startTime"];
    boundTask.restTime = dic[@"rest_time"];
    boundTask.giveupTime = dic[@"giveup_time"];
    boundTask.endTime = dic[@"end_time"];
    boundTask.costTime = dic[@"cost_time"];
    boundTask.isRemind = dic[@"needRemind"];
    boundTask.photoStatus = dic[@"needPhoto"];
    boundTask.startPictureCount = dic[@"start_picture_count"];
    boundTask.endPictureCount = dic[@"end_picture_count"];
    boundTask.starLevel = dic[@"star_level"];
    boundTask.status = dic[@"task_status"];
    boundTask.updated = dic[@"updated"];
    boundTask.count = dic[@"count"];
    boundTask.role = dic[@"role"];
    boundTask.uid = dic[@"uid"];
    return boundTask;
}

@end
