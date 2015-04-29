//
//  GrideCacheService.h
//  Parents
//
//  Created by kfd on 14-12-19.
//  Copyright (c) 2014年 qzz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DBService.h"

@interface ClassInfoCacheService : DBService

+(BOOL)insertClassInfo;

+(NSMutableArray *)QueryClassInfo;

+(BOOL)deleteClassInfo;
@end
