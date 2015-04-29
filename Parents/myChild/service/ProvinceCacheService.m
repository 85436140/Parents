//
//  ProvinceCacheService.m
//  Parents
//
//  Created by kfd on 14-12-17.
//  Copyright (c) 2014年 qzz. All rights reserved.
//

#import "ProvinceCacheService.h"
#import "FMDatabase.h"

@implementation ProvinceCacheService
//判断数据是否存在
+(BOOL)QuerySqlExites:(NSString *)provinceName andTableName:(NSString *)tableName
{
    BOOL flag;
    
    FMDatabase *db = [FMDatabase databaseWithPath:DATABAE_PATH];
    if (![db open]) {
        NSLog(@"数据打开失败");
        return false;
    }
    NSString *SqlString = [NSString stringWithFormat:@"select * from %@ where provinceName = '%@'",tableName,provinceName];
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

+(BOOL)insertProvince:(NSInteger)pid andProvinceName:(NSString *)provinceName{

    if ([self dataPath:ER_DATABASE_PATH]) {
        
        FMDatabase *db = [FMDatabase databaseWithPath:DATABAE_PATH];
        if (![db open]) {
            return NO;
        }
        
        NSString *createTable = @"CREATE TABLE IF NOT EXISTS Province (ID INTEGER ,ProvinceName VARCHAR(100))";
        BOOL bo = [db executeUpdate:createTable];
        
        if (![self QuerySqlExites:provinceName andTableName:@"Province"]) {
            NSString *sqlInsert = [NSString stringWithFormat:@"INSERT INTO Province('ID','ProvinceName') VALUES(%ld,'%@');",pid,provinceName];
            bo = [db executeUpdate:sqlInsert];
        }
        [db close];
        return bo;
    }
    
    return NO;
}

+(NSMutableArray *)QueryProvince
{
    NSMutableArray *pList = [[NSMutableArray alloc]init];
    FMDatabase *db = [FMDatabase databaseWithPath:DATABAE_PATH];
    if (![db open]) {
        NSLog(@"数据打开失败");
        return pList;
    }
    NSString *SqlString = [NSString stringWithFormat:@"select * from Province"];
    FMResultSet *set = [db executeQuery:SqlString];
    while([set next]) {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:0];
        [dic setValue:[set stringForColumn:@"ID"] forKey:@"pid"];
        [dic setValue:[set stringForColumn:@"ProvinceName"] forKey:@"ProvinceName"];
        [pList addObject:dic];
    }
    [db close];
    return pList;
}

@end
