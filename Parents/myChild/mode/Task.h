//
//  Task.h
//  Parents
//
//  Created by kfd on 14-11-26.
//  Copyright (c) 2014年 qzz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Task : NSObject

@property (strong, nonatomic) NSString *taskId;
@property (strong, nonatomic) NSString *taskName;
@property (strong, nonatomic) NSString *startTime;
@property (strong, nonatomic) NSString *planStartTime;
@property (strong, nonatomic) NSString *restTime;
@property (strong, nonatomic) NSString *starLevel;

@property (strong, nonatomic) NSString *addTime;
@property (strong, nonatomic) NSString *comment;
@property (strong, nonatomic) NSString *endPictureCount;
@property (strong, nonatomic) NSString *endTime;
@property (strong, nonatomic) NSString *giveupTime;

@property (strong, nonatomic) NSString *isRemind;
@property (strong, nonatomic) NSString *photoStatus;
@property (strong, nonatomic) NSString *planTime;
@property (strong, nonatomic) NSString *costTime;

@property (strong, nonatomic) NSString *startPictureCount;
@property (strong, nonatomic) NSString *status;
@property (strong, nonatomic) NSString *taskType;
@property (strong, nonatomic) NSString *updated;
@property (strong, nonatomic) NSString *count;
@property (strong, nonatomic) NSString *role;
@property (strong, nonatomic) NSString *name_type_id;
@property (strong, nonatomic) NSString *uid;
+(Task *)shareTaskInstance;
+(Task *)boundTaskDataWithdict:(NSDictionary *)dic;
@end
