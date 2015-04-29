//
//  SubjectCacheService.m
//  Parents
//
//  Created by kfd on 14-12-29.
//  Copyright (c) 2014年 qzz. All rights reserved.
//

#import "SubjectCacheService.h"
#import "FMDatabase.h"

@implementation SubjectCacheService

//判断数据是否存在
+(BOOL)QuerySqlExites:(NSString *)subjectName
{
    BOOL flag;
    
    FMDatabase *db = [FMDatabase databaseWithPath:DATABAE_PATH];
    if (![db open]) {
        NSLog(@"数据打开失败");
        return false;
    }
    NSString *SqlString = [NSString stringWithFormat:@"select * from Subject where subjectName = '%@'",subjectName];
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

+(BOOL)insertSubject:(NSInteger)subjectId andSubjectName:(NSString *)subjectName andState:(NSString *)state{
    
    if ([self dataPath:ER_DATABASE_PATH]) {
        
        FMDatabase *db = [FMDatabase databaseWithPath:DATABAE_PATH];
        if (![db open]) {
            return NO;
        }
        
        NSString *createTable = @"CREATE TABLE IF NOT EXISTS Subject (ID INTEGER, SubjectName VARCHAR(100), State VARCHAR(2))";
        BOOL bo = [db executeUpdate:createTable];
        
        if (![self QuerySqlExites:subjectName]) {
            NSString *sqlInsert = [NSString stringWithFormat:@"INSERT INTO Subject('ID','SubjectName','State') VALUES(%ld,'%@','%@');",subjectId,subjectName,state];
            bo = [db executeUpdate:sqlInsert];
        }
        [db close];
        return bo;
    }
    return NO;
}

+(BOOL)updateSubject:(Subject *)subject{
    
    FMDatabase *db = [FMDatabase databaseWithPath:DATABAE_PATH];
    if (![db open]) {
        NSLog(@"数据打开失败");
        return false;
    }
    NSString *SqlString = [NSString stringWithFormat:@"update Subject set State = '%@' where ID = '%@'",subject.state,subject.subId];
    BOOL flag = [db executeUpdate:SqlString];
    [db close];
    return flag;
}

+(BOOL)deleteTable:(NSString *)tableName{

    FMDatabase *db = [FMDatabase databaseWithPath:DATABAE_PATH];
    if (![db open]) {
        NSLog(@"数据打开失败");
        return false;
    }
    NSString *SqlString = [NSString stringWithFormat:@"drop table %@",tableName];
    BOOL flag = [db executeUpdate:SqlString];
    [db close];
    return flag;
}

+(NSMutableArray *)QuerySubject
{
    NSMutableArray *subjectList = [[NSMutableArray alloc]init];
    FMDatabase *db = [FMDatabase databaseWithPath:DATABAE_PATH];
    if (![db open]) {
        NSLog(@"数据打开失败");
        return subjectList;
    }
    NSString *SqlString = [NSString stringWithFormat:@"select * from Subject"];
    FMResultSet *set = [db executeQuery:SqlString];
    while([set next]) {
        Subject *sub = [[Subject alloc] init];
        sub.subId = [set stringForColumn:@"ID"];
        sub.subject = [set stringForColumn:@"SubjectName"];
        sub.state = [set stringForColumn:@"State"];
        [subjectList addObject:sub];
    }
    [db close];
    return subjectList;
}

+(NSString *)QuerySubjectNameById:(NSInteger)subId
{
    FMDatabase *db = [FMDatabase databaseWithPath:DATABAE_PATH];
    if (![db open]) {
        NSLog(@"数据打开失败");
        return nil;
    }
    NSString *SqlString = [NSString stringWithFormat:@"select SubjectName from Subject where ID = %d",subId];
    FMResultSet *set = [db executeQuery:SqlString];
    while([set next]) {
        return [set stringForColumn:@"SubjectName"];
    }
    [db close];
    return nil;
}

@end
