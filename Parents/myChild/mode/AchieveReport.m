//
//  AchieveReport.m
//  Parents
//
//  Created by kfd on 14-12-10.
//  Copyright (c) 2014年 qzz. All rights reserved.
//

#import "AchieveReport.h"

@implementation AchieveReport

+(AchieveReport *)boundDataWithAchieveReport:(Score *)score andAchieveReportView:(UIView *)achieveReportView{
    
    AchieveReport *achieveReport = [[AchieveReport alloc] init];
    achieveReport.subject = score.subject;
    achieveReport.avgScore = [NSString stringWithFormat:@"%f",score.average];
    [achieveReport.achieveReportView addSubview:achieveReportView];
    return achieveReport;
}

@end
