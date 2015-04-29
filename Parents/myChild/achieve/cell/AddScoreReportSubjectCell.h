//
//  AddScoreReportSubjectCell.h
//  Parents
//
//  Created by kfd on 14-12-30.
//  Copyright (c) 2014年 qzz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PNLineChartView.h"
#import "PNPlot.h"
#import "Subject.h"

@interface AddScoreReportSubjectCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *subjectLbl;
@property (weak, nonatomic) IBOutlet UIView *emptyReportView;

@property (strong, nonatomic) Subject *subject;
@property (strong, nonatomic) PNLineChartView *lineChartView;

@property (copy, nonatomic) void (^checkAchieveDetailBlock)(Subject *subject);

-(void)setDataSourceWithAchieveReport:(Subject *)subject
          withCheckAchieveDetailBlock:(void(^)(Subject *subject))checkAchieveDetailBlock;
@end
