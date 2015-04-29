//
//  Score.h
//  Parents
//
//  Created by kfd on 14-11-27.
//  Copyright (c) 2014年 qzz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Score : NSObject
@property (nonatomic, assign) float average;
@property (nonatomic, strong) NSString *examDate;
@property (nonatomic, strong) NSString *subject;
@property (nonatomic, assign) NSInteger score;
@property (nonatomic, assign) NSInteger scoreId;
@property (nonatomic, assign) NSInteger subId;
@property (nonatomic, assign) NSInteger total;

+(Score *)boundDataWithScore:(NSDictionary *)dic;
@end
