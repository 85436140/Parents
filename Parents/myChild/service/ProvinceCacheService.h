//
//  ProvinceCacheService.h
//  Parents
//
//  Created by kfd on 14-12-17.
//  Copyright (c) 2014年 qzz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DBService.h"

@interface ProvinceCacheService : DBService

+(BOOL)insertProvince:(NSInteger)pid andProvinceName:(NSString *)provinceName;

+(BOOL)QuerySqlExites:(NSString *)provinceName andTableName:(NSString *)tableName;

+(NSMutableArray *)QueryProvince;
@end
