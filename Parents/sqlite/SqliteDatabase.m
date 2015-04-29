//
//  SqliteDatabase.m
//  Parents
//
//  Created by kfd on 14-12-1.
//  Copyright (c) 2014年 qzz. All rights reserved.
//

#import "SqliteDatabase.h"

@implementation SqliteDatabase

//数据库路径
+ (NSString *)filePath
{
    NSArray *documentsPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *databaseFilePath = [[documentsPaths objectAtIndex:0] stringByAppendingPathComponent:@"ParentsDB.sqlite"];
    return databaseFilePath;
}

//创建数据表
+ (BOOL)createTable:(NSString*)createSQL
{
    sqlite3 *database;
    if (sqlite3_open([[self filePath] UTF8String],&database) != SQLITE_OK) {
        sqlite3_close(database);
        NSLog(@"数据库打开错误!");
        return NO;
    } else {
        char *errorMsg;
        if (sqlite3_exec(database, [createSQL  UTF8String], NULL, NULL, &errorMsg) != SQLITE_OK) {
            NSLog(@"创建数据表错误: %s", errorMsg);
            sqlite3_free(errorMsg);
            sqlite3_close(database);
            return NO;
        }
    }
    sqlite3_close(database);
    return YES;
}

//插入数据
+ (BOOL)insertData:(NSString*)insertSQL
{
    return [self createTable:insertSQL];
}

//更新数据
+ (BOOL)updateData:(NSString*)updateSQL
{
    sqlite3 *database;
    if (sqlite3_open([[self filePath] UTF8String],&database) != SQLITE_OK) {
        sqlite3_close(database);
        NSLog(@"数据库打开错误!");
        return NO;
    } else {
        sqlite3_stmt *statement;
        if (sqlite3_prepare_v2(database, [updateSQL UTF8String], -1, &statement, NULL) != SQLITE_OK) {
            NSLog(@"更新或删除数据错误:'%s'.",sqlite3_errmsg(database));
            sqlite3_close(database);
            return NO;
        } else {
            int reset = sqlite3_step(statement);
            sqlite3_reset(statement);
            if (reset != SQLITE_DONE) {
                NSLog(@"更新或删除数据错误:'%s'.",sqlite3_errmsg(database));
                sqlite3_close(database);
                return NO;
            }
        }
    }
    sqlite3_close(database);
    return YES;
}

//删除数据
+ (BOOL)deleteData:(NSString*)deleteSQL
{
    return [self updateData:deleteSQL];
}

//查询数据
+ (NSMutableArray *)selectData:(NSString *)selectSQL
{
    sqlite3 *database;
    NSMutableArray *array = nil;
    if (sqlite3_open([[self filePath] UTF8String],&database) != SQLITE_OK) {
        sqlite3_close(database);
        NSLog(@"打开数据表错误!");
        return nil;
    } else
    {
        sqlite3_stmt *statement;
        if (sqlite3_prepare_v2(database, [selectSQL UTF8String], -1, &statement, nil) == SQLITE_OK)
        {
            array = [[NSMutableArray alloc] init];
            while (sqlite3_step(statement)== SQLITE_ROW)
            {
                NSMutableDictionary *myDictionary = [[NSMutableDictionary alloc]init];
                int n = sqlite3_column_count(statement);
                for (int i = 0; i < n; i++)
                {
                    NSString *string;
                    int t = sqlite3_column_type(statement, i);
                    if (t == SQLITE_INTEGER) {
                        int value = sqlite3_column_int(statement, i);
                        string = [NSString stringWithFormat:@"%d",value];
                    } else if (t == SQLITE_FLOAT) {
                        double value = sqlite3_column_double(statement, i);
                        string = [NSString stringWithFormat:@"%f",value];
                    } else if (t == SQLITE3_TEXT) {
                        const unsigned char *value = sqlite3_column_text(statement, i);
                        string = [[NSString alloc] initWithUTF8String: (const char *)value];
                    } else if (t == SQLITE_BLOB) {
                        const void *value = sqlite3_column_blob(statement, i);
                        NSData *data = [NSData dataWithBytes: value length: strlen((const char *)value)];
                        string = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                    } else if (t ==SQLITE_NULL){
                        NSLog(@"没有数据");
                        sqlite3_finalize(statement);
                        sqlite3_close(database);
                        return  nil;
                    }
                    NSString *key = [NSString stringWithFormat:@"key%d",i];
                    [myDictionary setValue:string forKey:key];
                }
                [array addObject:myDictionary];
            }
            sqlite3_finalize(statement);
        }
    }
    sqlite3_close(database);
    
    if ([array count] == 0) {
        return nil;
    }
    
    return array;
}

+(void)copyDataBase
{
    NSString *pathWithDocument=[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"ParentsDB.sqlite"];
    NSString *pathWithBundle=[[NSBundle mainBundle] pathForResource:@"ParentsDB" ofType:@"sqlite"];
    
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:pathWithDocument]) {
        if ([fileManager copyItemAtPath:pathWithBundle toPath:pathWithDocument error:nil]) {
            NSLog(@"copy success");
        }
    }
}

@end
