//
//  SubjectCacheService.h
//  Parents
//
//  Created by kfd on 14-12-29.
//  Copyright (c) 2014年 qzz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DBService.h"
#import "Subject.h"

@interface SubjectCacheService : DBService

+(BOOL)insertSubject:(NSInteger)subjectId andSubjectName:(NSString *)subjectName andState:(NSString *)state;

+(BOOL)updateSubject:(Subject *)subject;

+(BOOL)deleteTable:(NSString *)tableName;

+(BOOL)QuerySqlExites:(NSString *)subjectName;

+(NSMutableArray *)QuerySubject;

+(NSString *)QuerySubjectNameById:(NSInteger)subId;
@end
