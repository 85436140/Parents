//
//  GrideCacheService.m
//  Parents
//
//  Created by kfd on 14-12-19.
//  Copyright (c) 2014年 qzz. All rights reserved.
//

#import "ClassInfoCacheService.h"
#import "FMDatabase.h"

@implementation ClassInfoCacheService

//判断数据是否存在
+(BOOL)QuerySqlExites:(NSString *)kName
{
    BOOL flag;
    
    FMDatabase *db = [FMDatabase databaseWithPath:DATABAE_PATH];
    if (![db open]) {
        NSLog(@"数据打开失败");
        return false;
    }
    NSString *SqlString = [NSString stringWithFormat:@"select * from ClassInfo where className = '%@'",kName];
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

+(BOOL)insertClassInfo{
    
    NSMutableArray *data = [[NSMutableArray alloc] initWithCapacity:0];
    for(int i = 1; i <= 30; i++){
        [data addObject:[NSString stringWithFormat:@"%i班",i]];
    }
    
    if ([self dataPath:ER_DATABASE_PATH]) {
        
        FMDatabase *db = [FMDatabase databaseWithPath:DATABAE_PATH];
        if (![db open]) {
            return NO;
        }
        
        NSString *createTable = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS ClassInfo (ID INTEGER PRIMARY KEY AUTOINCREMENT,ClassName VARCHAR(100))"];
        BOOL bo = [db executeUpdate:createTable];
        
        for (int i = 0; i < data.count; i++) {
            if (![self QuerySqlExites:[data objectAtIndex:i]]) {
                NSString *sqlInsert = [NSString stringWithFormat:@"INSERT INTO ClassInfo('ClassName') VALUES('%@');",[data objectAtIndex:i]];
                bo = [db executeUpdate:sqlInsert];
            }
        }
        
        [db close];
        return bo;
    }
    return NO;
}

+(NSMutableArray *)QueryClassInfo
{
    NSMutableArray *pList = [[NSMutableArray alloc]init];
    FMDatabase *db = [FMDatabase databaseWithPath:DATABAE_PATH];
    if (![db open]) {
        NSLog(@"数据打开失败");
        return pList;
    }
    NSString *SqlString = [NSString stringWithFormat:@"select * from ClassInfo"];
    FMResultSet *set = [db executeQuery:SqlString];
    while([set next]) {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:0];
        [dic setValue:[set stringForColumn:@"ID"] forKey:@"class_id"];
        [dic setValue:[set stringForColumn:@"ClassName"] forKey:@"className"];
        [pList addObject:dic];
    }
    [db close];
    return pList;
}

+(BOOL)deleteClassInfo{
    
    FMDatabase *db = [FMDatabase databaseWithPath:DATABAE_PATH];
    if (![db open]) {
        NSLog(@"数据打开失败");
        return false;
    }
    NSString *SqlString = [NSString stringWithFormat:@"drop table ClassInfo"];
    BOOL flag = [db executeUpdate:SqlString];
    
    [db close];
    return flag;
}

@end
