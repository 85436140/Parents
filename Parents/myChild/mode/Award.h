//
//  Award.h
//  Parents
//
//  Created by kfd on 14/11/26.
//  Copyright (c) 2014年 qzz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Award : NSObject

@property (nonatomic,strong) NSString *awardId;
@property (nonatomic,strong) NSString *content;
@property (nonatomic,strong) NSString *condition;

+(Award *)boundAwardDataWithdict:(NSDictionary *)dic;
@end
