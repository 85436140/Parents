//
//  OneWeek.h
//  Parents
//
//  Created by kfd on 14-11-28.
//  Copyright (c) 2014年 qzz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OneWeek : NSObject

@property (nonatomic,assign) NSInteger weekday;
@property (nonatomic,assign) NSInteger taskCount;
@property (nonatomic,assign) NSInteger planTime;
@property (nonatomic,assign) NSInteger costTime;
@property (nonatomic,assign) NSInteger chabie;
+(OneWeek *)boundDataWithOneWeek:(NSDictionary *)dic;
@end
