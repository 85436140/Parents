//
//  AchieveReportCell.h
//  Parents
//
//  Created by kfd on 14-12-10.
//  Copyright (c) 2014年 qzz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AchieveReport.h"
#import "PNLineChartView.h"
#import "PNPlot.h"
#import "Subject.h"

@interface AchieveReportCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *subjectLbl;
@property (weak, nonatomic) IBOutlet UILabel *avgScoreLbl;
@property (weak, nonatomic) IBOutlet UIView *achieveReportView;

@property (strong, nonatomic) NSArray *scoreList;
@property (copy, nonatomic) void (^checkAchieveDetailBlock)(Subject *subject);
@property (nonatomic,strong) Subject *subject;
-(void)setDataSourceWithAchieveReport:(Score *)score
                     andLineChartView:(NSArray *)scores
          withCheckAchieveDetailBlock:(void(^)(Subject *subject))checkAchieveDetailBlock;
@end
