//
//  SqliteDatabase.h
//  Parents
//
//  Created by kfd on 14-12-1.
//  Copyright (c) 2014年 qzz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface SqliteDatabase : NSObject

//创建数据表
+ (BOOL)createTable:(NSString*)createSQL;
//插入数据
+ (BOOL)insertData:(NSString*)insertSQL;
//更新数据
+ (BOOL)updateData:(NSString*)updateSQL;
//删除数据
+ (BOOL)deleteData:(NSString*)deleteSQL;

//查询数据
+ (NSMutableArray *)selectData:(NSString *)selectSQL;

+ (NSString *)filePath;
+ (void)copyDataBase;
@end
