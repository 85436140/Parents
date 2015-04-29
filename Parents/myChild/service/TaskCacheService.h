//
//  TaskCacheService.h
//  Parents
//
//  Created by kfd on 14/12/16.
//  Copyright (c) 2014年 qzz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DBService.h"
#import "Task.h"

@interface TaskCacheService : DBService

///插入已完成任务
+(BOOL)insertFinishedTask:(Task *)task;

//插入任务类型
+(BOOL)insertTaskType:(NSString *)taskName andTaskType:(NSInteger)taskType;

///查询数据
+(NSMutableArray *)QueryTask;
+(NSString *)QueryTaskTypeByTaskName:(NSString *)taskName andTaskType:(NSInteger)taskType;

+(NSMutableArray *)QueryTaskType;

//删除表
+(BOOL)deleteTaskType;
@end
