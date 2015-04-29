//
//  AchieveReportCell.m
//  Parents
//
//  Created by kfd on 14-12-10.
//  Copyright (c) 2014年 qzz. All rights reserved.
//

#import "AchieveReportCell.h"

@implementation AchieveReportCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    self = [[[NSBundle mainBundle] loadNibNamed:@"AchieveReportCell" owner:self options:nil] objectAtIndex:0];
    if (self) {
        
    }
    return self;
}

-(void)setDataSourceWithAchieveReport:(Score *)score
                     andLineChartView:(NSArray *)scores//(PNLineChartView *)lineChartView
          withCheckAchieveDetailBlock:(void(^)(Subject *subject))checkAchieveDetailBlock{
    _scoreList = scores;
    [_subjectLbl setText:[NSString stringWithFormat:@"%@曲线",score.subject]];
    [_avgScoreLbl setText:[NSString stringWithFormat:@"%.2f",score.average]];
//    [_achieveReportView addSubview:lineChartView];
    _checkAchieveDetailBlock = checkAchieveDetailBlock;
    _subject.subject = score.subject;
    _subject.subId = [NSString stringWithFormat:@"%ld",score.subId];
    
    [_achieveReportView addSubview:[self lineChartView]];
}

-(PNLineChartView *)lineChartView{
    
    PNLineChartView *lineChartView = [[PNLineChartView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-160, 0, 300, 200)];
    [lineChartView setBackgroundColor:[UIColor whiteColor]];
    
    lineChartView.max = 100;
    lineChartView.min = 0;
    //设置间距
    lineChartView.interval = (lineChartView.max - lineChartView.min)/2;
    
    NSMutableArray *arrY = [@[] mutableCopy];
    for (int i = 0; i < 3; i++) {
        NSString *str = [NSString stringWithFormat:@"%.0f",lineChartView.min+lineChartView.interval*i];
        [arrY addObject:str];
    }
    lineChartView.xAxisValues = @[@"1", @"2", @"3",@"4", @"5", @"6",@"7"];
    
    lineChartView.yAxisValues = arrY;
    lineChartView.numberOfVerticalElements = arrY.count;
    lineChartView.axisLeftLineWidth = 35;
    lineChartView.pointerInterval = 35;
    
    if (_scoreList.count != 0) {
        PNPlot *plot = [[PNPlot alloc] init];
        plot.plottingValues = _scoreList;
        plot.lineColor = [UIColor redColor];
        plot.lineWidth = 1.0;
        [lineChartView addPlot:plot];
    }
    return lineChartView;
}

- (void)awakeFromNib {
    [_achieveReportView setUserInteractionEnabled:YES];
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(reportDetailAction)];
    [_achieveReportView addGestureRecognizer:gesture];
    
    _subject = [[Subject alloc] init];
}

-(void)reportDetailAction{
    _checkAchieveDetailBlock(_subject);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
