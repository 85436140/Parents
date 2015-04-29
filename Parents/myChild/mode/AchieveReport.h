//
//  AchieveReport.h
//  Parents
//
//  Created by kfd on 14-12-10.
//  Copyright (c) 2014年 qzz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Score.h"

@interface AchieveReport : NSObject
@property (nonatomic, strong) NSString *subject;
@property (nonatomic, strong) NSString *avgScore;
@property (nonatomic, strong) Score *score;
@property (nonatomic, strong) UIView *achieveReportView;

+(AchieveReport *)boundDataWithAchieveReport:(Score *)score andAchieveReportView:(UIView *)achieveReportView;
@end