//
//  AchieveMent.h
//  Parents
//
//  Created by kfd on 14-11-10.
//  Copyright (c) 2014年 qzz. All rights reserved.
//

#import "PCBaseVC.h"
#import "AchieveCell.h"
#include "CustomTwoVC.h"
#import "Score.h"
#import "SVProgressHUD.h"
#import "CommonView.h"
#import "AddItemCell.h"
#import "AddAchieveMentVC.h"
#import "Subject.h"
#import "AchieveReportCell.h"
#import "SubjectCacheService.h"
#import "AchieveReportDetailVC.h"
#import "AddScoreReportSubjectCell.h"
#import "PNLineChartView.h"
#import "PNPlot.h"

@interface AchieveMentVC : PCBaseVC<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView *achieveTableView;
@end
