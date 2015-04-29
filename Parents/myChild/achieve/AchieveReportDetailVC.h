//
//  AchieveReportDetailVC.h
//  Parents
//
//  Created by kfd on 14-12-29.
//  Copyright (c) 2014年 qzz. All rights reserved.
//

#import "PCBaseVC.h"
#import "Subject.h"
#import "PNLineChartView.h"
#import "PNPlot.h"
#import "AddAchieveMentVC.h"
#import "Score.h"
#import "ScoreCell.h"

@interface AchieveReportDetailVC : PCBaseVC

@property (weak, nonatomic) IBOutlet UIButton *preMonthBtnOutlet;
@property (weak, nonatomic) IBOutlet UIButton *nextMonthBtnOutlet;
@property (weak, nonatomic) IBOutlet UILabel *monthLbl;
@property (weak, nonatomic) IBOutlet UILabel *myAvgScoreLbl;
@property (weak, nonatomic) IBOutlet UIView *SocreReportView;
@property (strong, nonatomic) PNLineChartView *lineChartView;
@property (weak, nonatomic) IBOutlet UITableView *scoreTB;

- (IBAction)preMonthBtnAction:(id)sender;
- (IBAction)nextMonthBtnAction:(id)sender;
- (IBAction)addAchieveBtnAction:(id)sender;

-(instancetype)initWithAchievieReport:(Subject *)subjectReport;
-(instancetype)initWithScoreReport:(NSMutableArray *)scoreList
                  andOnlyScoreList:(NSArray *)onlyScoreList
                        andSubject:(Subject *)subject;
@end
