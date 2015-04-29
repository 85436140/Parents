//
//  ClassInfo.m
//  Parents
//
//  Created by kfd on 15-1-12.
//  Copyright (c) 2015年 qzz. All rights reserved.
//

#import "ClassInfo.h"

static ClassInfo *clsInfo = nil;

@implementation ClassInfo

+(ClassInfo *)shareClassInfo{
    @synchronized(self){
    
        if (nil == clsInfo) {
            clsInfo = [[ClassInfo alloc] init];
        }
    }
    return clsInfo;
}

+(ClassInfo *)boundDataWithClassInfo:(NSDictionary *)dict{
    ClassInfo *clsInfo = [[ClassInfo alloc] init];
    clsInfo.zoneId = dict[@"zid"];
    clsInfo.schoolId = dict[@"sid"];
    clsInfo.grideId = dict[@"gid"];
    clsInfo.classId = dict[@"class_id"];
    clsInfo.cname = dict[@"cname"];
    clsInfo.studentCount = dict[@"stu_count"];
    clsInfo.teacherCount = dict[@"t_count"];
    return clsInfo;
}

@end
