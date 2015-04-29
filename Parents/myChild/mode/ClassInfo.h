//
//  ClassInfo.h
//  Parents
//
//  Created by kfd on 15-1-12.
//  Copyright (c) 2015年 qzz. All rights reserved.
//

#define CLASS_INFO [ClassInfo shareClassInfo]
#import <Foundation/Foundation.h>

@interface ClassInfo : NSObject

//查询参数链传递存储
@property (nonatomic,strong) NSString *province;
@property (nonatomic,strong) NSString *city;
@property (nonatomic,strong) NSString *zone;
@property (nonatomic,strong) NSString *schoolType;
@property (nonatomic,strong) NSString *school;
@property (nonatomic,strong) NSString *gride;
@property (nonatomic,strong) NSString *cls;

@property (nonatomic,strong) NSString *cityName;
@property (nonatomic,strong) NSString *schoolName;
@property (nonatomic,strong) NSString *grideName;
@property (nonatomic,strong) NSString *className;

//查询返回字段
@property (nonatomic,strong) NSString *zoneId;
@property (nonatomic,strong) NSString *schoolId;
@property (nonatomic,strong) NSString *grideId;
@property (nonatomic,strong) NSString *classId;
@property (nonatomic,strong) NSString *cname;
@property (nonatomic,strong) NSString *studentCount;
@property (nonatomic,strong) NSString *teacherCount;

+(ClassInfo *)shareClassInfo;
+(ClassInfo *)boundDataWithClassInfo:(NSDictionary *)dict;
@end
