//
//  TaskListService.m
//  Parents
//
//  Created by kfd on 14-11-26.
//  Copyright (c) 2014年 qzz. All rights reserved.
//

#import "DBService.h"
#import "FMDatabase.h"
#import "NSString+Modify.h"

@implementation DBService

//文件夹的创建
+ (BOOL)dataPath:(NSString *)file
{
    NSFileManager *fileManger = [NSFileManager defaultManager];
    if (![fileManger isExecutableFileAtPath:ER_DATABASE_PATH]) {
        BOOL bo = [fileManger createDirectoryAtPath:ER_DATABASE_PATH withIntermediateDirectories:YES attributes:nil error:nil];
        if (bo) {
            return YES;
        }
        else
        {
            return NO;
        }
    }
    else
    {
        return YES;
    }
}

@end
