//
//  Award.m
//  Parents
//
//  Created by kfd on 14/11/26.
//  Copyright (c) 2014年 qzz. All rights reserved.
//

#import "Award.h"

@implementation Award

+(Award *)boundAwardDataWithdict:(NSDictionary *)dic{
    Award *award = [[Award alloc] init];
    award.awardId = dic[@"award_id"];
    award.content = dic[@"award"];
    award.condition = dic[@"factor"];
    return award;
}
@end
