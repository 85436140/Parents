//
//  AddScoreReportSubjectCell.m
//  Parents
//
//  Created by kfd on 14-12-30.
//  Copyright (c) 2014年 qzz. All rights reserved.
//

#import "AddScoreReportSubjectCell.h"

@implementation AddScoreReportSubjectCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [[[NSBundle mainBundle] loadNibNamed:@"AddScoreReportSubjectCell" owner:self options:nil] objectAtIndex:0];
    if (self) {
        
    }
    return self;
}

-(void)setDataSourceWithAchieveReport:(Subject *)subject
          withCheckAchieveDetailBlock:(void(^)(Subject *subject))checkAchieveDetailBlock{
    _subject = subject;
    [_subjectLbl setText:[NSString stringWithFormat:@"%@曲线",subject.subject]];
    _checkAchieveDetailBlock = checkAchieveDetailBlock;
}

- (void)awakeFromNib {
    [_emptyReportView setUserInteractionEnabled:YES];
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(reportDetailAction)];
    
    _lineChartView = [[PNLineChartView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-160, 0, 300, 200)];
    [_emptyReportView addGestureRecognizer:gesture];
    [_lineChartView setBackgroundColor:[UIColor whiteColor]];
    [_emptyReportView addSubview:_lineChartView];
    
    NSArray *plottingDataValues1 = @[@70, @75, @80, @75, @90, @95, @70];
    //    NSArray *plottingDataValues2 = @[@30, @50, @60, @55, @75, @80, @100];
    self.lineChartView.max = 100;
    self.lineChartView.min = 0;
    //设置间距
    self.lineChartView.interval = (_lineChartView.max - _lineChartView.min)/2;
    
    NSMutableArray *arrY = [@[] mutableCopy];
    for (int i = 0; i < 3; i++) {
        NSString *str = [NSString stringWithFormat:@"%.0f",_lineChartView.min+_lineChartView.interval*i];
        [arrY addObject:str];
    }
    
    self.lineChartView.xAxisValues = @[@"1", @"2", @"3",@"4", @"5", @"6",@"7"];
    
    self.lineChartView.yAxisValues = arrY;
    self.lineChartView.numberOfVerticalElements = arrY.count;
    self.lineChartView.axisLeftLineWidth = 35;
    self.lineChartView.pointerInterval = 35;
    
    PNPlot *plot = [[PNPlot alloc] init];
//    plot.plottingValues = plottingDataValues1;
    plot.lineColor = [UIColor redColor];
    plot.lineWidth = 1.0;
    [self.lineChartView addPlot:plot];
    
}

-(void)reportDetailAction{
    _checkAchieveDetailBlock(_subject);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
