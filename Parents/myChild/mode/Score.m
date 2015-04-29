//
//  Score.m
//  Parents
//
//  Created by kfd on 14-11-27.
//  Copyright (c) 2014年 qzz. All rights reserved.
//

#import "Score.h"
#import "SubjectCacheService.h"

@implementation Score

+(Score *)boundDataWithScore:(NSDictionary *)dic{
    Score *score = [[Score alloc] init];
    score.average = [dic[@"average"] floatValue];
    score.examDate = dic[@"exam_date"];
    score.score = [dic[@"score"] intValue];
    score.scoreId = [dic[@"score_id"] intValue];
    score.subId = [dic[@"sub_id"] intValue];
    score.subject = [SubjectCacheService QuerySubjectNameById:[dic[@"sub_id"] intValue]];
    score.total = [dic[@"total"] intValue];
    return score;
}
@end
