//
//  TaskCacheService.m
//  Parents
//
//  Created by kfd on 14/12/16.
//  Copyright (c) 2014年 qzz. All rights reserved.
//

#import "TaskCacheService.h"
#import "FMDatabase.h"

@implementation TaskCacheService

#pragma mark  private method
//判断任务类型是否存在
+(BOOL)QueryTaskTypeExites:(NSString *)taskName andTaskType:(NSInteger)taskType
{
    BOOL flag;
    
    FMDatabase *db = [FMDatabase databaseWithPath:DATABAE_PATH];
    if (![db open]) {
        NSLog(@"数据打开失败");
        return false;
    }
    NSString *SqlString = [NSString stringWithFormat:@"select * from TaskType where TaskName = '%@' and TaskType = %ld",taskName,(long)taskType];
    FMResultSet *set = [db executeQuery:SqlString];
    if  ([set next]) {
        flag =YES;
    }
    else
    {
        flag =NO;
    }
    [db close];
    return flag;
}

//判断任务是否存在
+(BOOL)QuerySqlExites:(Task *)task
{
    BOOL flag;
    
    FMDatabase *db = [FMDatabase databaseWithPath:DATABAE_PATH];
    if (![db open]) {
        NSLog(@"数据打开失败");
        return false;
    }
    NSString *SqlString = [NSString stringWithFormat:@"select * from FinishedTask where TaskName = '%@' and TaskType = %d",task.taskName,[task.taskType intValue]];
    FMResultSet *set = [db executeQuery:SqlString];
    if  ([set next]) {
        flag =YES;
    }
    else
    {
        flag =NO;
    }
    [db close];
    return flag;
}

//插入任务类型
+(BOOL)insertTaskType:(NSString *)taskName andTaskType:(NSInteger)taskType{

    if ([self dataPath:ER_DATABASE_PATH]) {
        FMDatabase *db = [FMDatabase databaseWithPath:DATABAE_PATH];
        if (![db open]) {
            return NO;
        }
        
        NSString *createTable = @"CREATE TABLE IF NOT EXISTS TaskType (ID INTEGER PRIMARY KEY AUTOINCREMENT ,TaskName VARCHAR(100),TaskType INTEGER)";
        BOOL bo = [db executeUpdate:createTable];
        
        if(taskName.length != 0){
            if (![self QueryTaskTypeExites:taskName andTaskType:taskType]) {
                NSString *sqlInsert = [NSString stringWithFormat:@"INSERT INTO TaskType('TaskName','TaskType') VALUES('%@',%ld);",taskName,taskType];
                bo = [db executeUpdate:sqlInsert];
            }
        }
        [db close];
        return bo;
    }
    return NO;
}

//插入完成任务
+(BOOL)insertFinishedTask:(Task *)task;
{
    if ([self dataPath:ER_DATABASE_PATH]) {
        FMDatabase *db = [FMDatabase databaseWithPath:DATABAE_PATH];
        if (![db open]) {
            return NO;
        }
        
        NSString *createTable = @"CREATE TABLE IF NOT EXISTS FinishedTask (ID INTEGER,TaskName VARCHAR(100),TaskType INTEGER,BelongDay VARCHAR(100),CostTime INTEGER,PlanTime INTEGER,IsTakePhoto INTEGER,IsRemind INTEGER)";
        
        BOOL bo = [db executeUpdate:createTable];
        
        if (![self QuerySqlExites:task]) {
            //插入表格
            NSString *sqlInsert = [NSString stringWithFormat:@"INSERT INTO FinishedTask('ID','TaskName','TaskType','BelongDay','CostTime','PlanTime','IsTakePhoto','IsRemind') VALUES(?,?,?,?,?,?,?,?);"];
            
            bo = [db executeUpdate:sqlInsert,(long)task.taskId,task.taskName,task.taskType,task.endTime,(long)task.costTime,task.planTime,task.photoStatus,task.isRemind];
        }
        [db close];
        return bo;
    }
    return NO;
}

+(NSString *)QueryTaskTypeByTaskName:(NSString *)taskName andTaskType:(NSInteger)taskType
{
    FMDatabase *db = [FMDatabase databaseWithPath:DATABAE_PATH];
    if (![db open]) {
        NSLog(@"数据打开失败");
        return false;
    }
    NSString *SqlString = [NSString stringWithFormat:@"select * from TaskType where TaskName = '%@' and TaskType = %ld",taskName,taskType];
    FMResultSet *set = [db executeQuery:SqlString];
    if ([set next]) {
        return [set stringForColumn:@"TaskType"];
    }
    [db close];
    return nil;
}

//删除任务类型
+(BOOL)deleteTaskType{
    
    if ([self dataPath:ER_DATABASE_PATH]) {
        FMDatabase *db = [FMDatabase databaseWithPath:DATABAE_PATH];
        if (![db open]) {
            return NO;
        }

        NSString *sqlDel = [NSString stringWithFormat:@"drop table TaskType"];
        BOOL bo = [db executeUpdate:sqlDel];
        
        [db close];
        return bo;
    }
    return NO;
}

//查询完成任务
+(NSMutableArray *)QueryTask
{
    NSMutableArray *taskList = [[NSMutableArray alloc]init];
    FMDatabase *db = [FMDatabase databaseWithPath:DATABAE_PATH];
    if (![db open]) {
        NSLog(@"数据打开失败");
        return taskList;
    }
    NSString *SqlString = [NSString stringWithFormat:@"select * from FinishedTask"];
    FMResultSet *set = [db executeQuery:SqlString];
    while([set next]) {
        Task *task = [[Task alloc]init];
        task.taskId = [NSString stringWithFormat:@"%d",[set intForColumn:@"ID"]];
        task.taskName = [set stringForColumn:@"TaskName"];
        task.taskType = [set stringForColumn:@"TaskType"];
        task.endTime = [set stringForColumn:@"BelongDay"];
        task.costTime = [set stringForColumn:@"CostTime"];
        task.planTime = [set stringForColumn:@"PlanTime"];
        task.photoStatus = [set stringForColumn:@"IsTakePhoto"];
        task.isRemind = [set stringForColumn:@"IsRemind"];
        [taskList addObject:task];
    }
    [db close];
    return taskList;
}

//查询任务类型
+(NSMutableArray *)QueryTaskType
{
    NSMutableArray *taskList = [[NSMutableArray alloc]init];
    FMDatabase *db = [FMDatabase databaseWithPath:DATABAE_PATH];
    if (![db open]) {
        NSLog(@"数据打开失败");
        return taskList;
    }
    NSString *SqlString = [NSString stringWithFormat:@"select * from TaskType"];
    FMResultSet *set = [db executeQuery:SqlString];
    while([set next]) {
        Task *task = [[Task alloc]init];
        task.taskId = [NSString stringWithFormat:@"%d",[set intForColumn:@"ID"]];
        task.taskName = [set stringForColumn:@"TaskName"];
        task.taskType = [set stringForColumn:@"TaskType"];
        [taskList addObject:task];
    }
    [db close];
    return taskList;
}

+(void)cacheTask{
    
    Task *tk1 = [[Task alloc] init];
    tk1.taskName = @"task1";
    tk1.taskType = @"1";
    tk1.endTime = @"星期一";
    tk1.costTime = @"20";
    tk1.planTime = @"30";
    tk1.isRemind = @"0";
    tk1.photoStatus = @"0";
    [self insertFinishedTask:tk1];
    
    Task *tk2 = [[Task alloc] init];
    tk2.taskName = @"task2";
    tk2.taskType = @"1";
    tk2.endTime = @"星期二";
    tk2.costTime = @"30";
    tk2.planTime = @"40";
    tk2.isRemind = @"0";
    tk2.photoStatus = @"0";
    [self insertFinishedTask:tk2];
    
    Task *tk3 = [[Task alloc] init];
    tk3.taskName = @"task3";
    tk3.taskType = @"1";
    tk3.endTime = @"星期三";
    tk3.costTime = @"40";
    tk3.planTime = @"30";
    tk3.isRemind = @"0";
    tk3.photoStatus = @"0";
    [self insertFinishedTask:tk3];
    
    Task *tk4 = [[Task alloc] init];
    tk4.taskName = @"task4";
    tk4.taskType = @"1";
    tk4.endTime = @"星期四";
    tk4.costTime = @"30";
    tk4.planTime = @"30";
    tk4.isRemind = @"0";
    tk4.photoStatus = @"0";
    [self insertFinishedTask:tk4];
    
    Task *tk5 = [[Task alloc] init];
    tk5.taskName = @"task5";
    tk5.taskType = @"1";
    tk5.endTime = @"星期五";
    tk5.costTime = @"45";
    tk5.planTime = @"30";
    tk5.isRemind = @"0";
    tk5.photoStatus = @"0";
    [self insertFinishedTask:tk5];
    
    Task *tk6 = [[Task alloc] init];
    tk6.taskName = @"task6";
    tk6.taskType = @"1";
    tk6.endTime = @"星期六";
    tk6.costTime = @"90";
    tk6.planTime = @"90";
    tk6.isRemind = @"0";
    tk6.photoStatus = @"0";
    [self insertFinishedTask:tk6];
    
    Task *tk7 = [[Task alloc] init];
    tk7.taskName = @"task7";
    tk7.taskType = @"1";
    tk7.endTime = @"星期日";
    tk7.costTime = @"45";
    tk7.planTime = @"45";
    tk7.isRemind = @"0";
    tk7.photoStatus = @"0";
    [self insertFinishedTask:tk7];
}

+(void)cacheTaskType{
    
    [self insertTaskType:@"小提琴" andTaskType:1];
    [self insertTaskType:@"钢琴" andTaskType:1];
    [self insertTaskType:@"书法" andTaskType:1];
    [self insertTaskType:@"足球" andTaskType:2];
    [self insertTaskType:@"篮球" andTaskType:2];
    [self insertTaskType:@"羽毛球" andTaskType:2];
    [self insertTaskType:@"乒乓球" andTaskType:2];
    [self insertTaskType:@"唱歌" andTaskType:3];
    [self insertTaskType:@"跳舞" andTaskType:3];
    [self insertTaskType:@"钢琴" andTaskType:3];
    [self insertTaskType:@"做饭" andTaskType:4];
    [self insertTaskType:@"做清洁" andTaskType:4];
    [self insertTaskType:@"作画" andTaskType:5];
    [self insertTaskType:@"唱歌" andTaskType:5];
    [self insertTaskType:@"看书" andTaskType:6];
}


@end
