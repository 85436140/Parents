//
//  MyGrownView.m
//  P_Child
//
//  Created by kfd on 14-11-3.
//  Copyright (c) 2014年 qzz. All rights reserved.
//

#import "MyGrownView.h"

@interface MyGrownView(){
    NSMutableArray *myGrownArr;
}

@end

@implementation MyGrownView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [[[NSBundle mainBundle] loadNibNamed:@"MyGrownView" owner:self options:nil]objectAtIndex:0];
    if (self) {
        
    }
    return self;
}

-(void)requestData{
    
    NSString *uid_c = [[PC_Globle shareUserDefaults] valueForKey:@"uid_c"];
    NSDictionary *dic = [NSDictionary dictionaryWithObject:uid_c forKey:@"uid"];
    [HTTPREQUEST requestWithPost:@"past/my_growth.php" requestParams:dic successBlock:^(NSData *data){
        NSString *resultStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        if (![resultStr isEqual:@"0"]) {
            NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            for (NSDictionary *dict in array) {
                [myGrownArr addObject:[dict valueForKey:@"grow_per"]];
            }
        }
    } failedBlock:^(NSString *code, NSString *msg) {
        
    }];
}

-(void)awakeFromNib{

    myGrownArr = [[NSMutableArray alloc] initWithCapacity:0];
    
    _lineChartView = [[PNLineChartView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-160, 80, 300, 200)];
    [_lineChartView setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:_lineChartView];
    
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
    
    if (myGrownArr.count != 0) {
        PNPlot *plot = [[PNPlot alloc] init];
        plot.plottingValues = myGrownArr;
        plot.lineColor = [UIColor redColor];
        plot.lineWidth = 1.0;
        [self.lineChartView addPlot:plot];
    }else{
        PNPlot *plot = [[PNPlot alloc] init];
        plot.plottingValues = plottingDataValues1;
        plot.lineColor = [UIColor redColor];
        plot.lineWidth = 1.0;
        [self.lineChartView addPlot:plot];
    }
}

@end
