//
//  TimeControlView.m
//  P_Child
//
//  Created by kfd on 14-11-3.
//  Copyright (c) 2014年 qzz. All rights reserved.
//

#import "TimeControlView.h"
#define PIE_HEIGHT 200
#define RNAME_WIDTH 200
#define RNAME_HEIGHT 0

@interface TimeControlView(){

    NSInteger weekCount;
    NSInteger weekTotal;
}

@end

@implementation TimeControlView

-(instancetype)initWithFrame:(CGRect)frame{

    self = [[[NSBundle mainBundle] loadNibNamed:@"TimeControlView" owner:self options:nil]objectAtIndex:0];
    if (self) {

    }
    return self;
}

-(void)requestData{

    NSString *uid_c = [[PC_Globle shareUserDefaults] valueForKey:@"uid_c"];
    NSDictionary *dic = [NSDictionary dictionaryWithObject:uid_c forKey:@"uid"];
    [HTTPREQUEST requestWithPost:@"past/time_control.php" requestParams:dic successBlock:^(NSData *data){
        NSString *resultStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        if (![resultStr isEqual:@"0"]) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            weekCount = [dict[@"week_count"] intValue];
            weekTotal = [dict[@"week_total"] intValue];
            NSLog(@"=====:::%@",dict);
        }
    } failedBlock:^(NSString *code, NSString *msg) {
        
    }];
}

-(void)awakeFromNib{

    weekCount = 0;
    weekTotal = 2880;
    [self requestData];
    [self showReportView];
}

-(void)showReportView{

    [self showReportImage];
    
    self.pieChartView = [[PieChartView alloc] initWithFrame:self.pieContainer.bounds
                                                 withValue:self.valueArray
                                                 withColor:self.colorArray];
    
    self.pieChartView.delegate = self;
    [self.pieContainer addSubview:self.pieChartView];
    [self.pieChartView reloadChart];
    [self.pieChartView setTitleText:@"周总时间"];
    [self.pieChartView setAmountText:@"2880"];//[NSString stringWithFormat:@"%@",weekTotal]
}

-(void)showReportImage{

    self.valueArray = [[NSMutableArray alloc] initWithObjects:
                       [NSNumber numberWithInt:(int)weekCount],
                       [NSNumber numberWithInt:(int)weekTotal],
                       nil];
    
//    self.valueArray = [[NSMutableArray alloc] initWithObjects:
//                       [NSNumber numberWithInt:200],
//                       [NSNumber numberWithInt:1000],
//                       nil];
    
    self.colorArray = [NSMutableArray arrayWithObjects:
                       [UIColor colorWithHue:50.0 / 360.0  saturation:(0%8+3)/10.0 brightness:91/100.0 alpha:1],
                       [UIColor colorWithHue:100.0 / 360.0 saturation:(1%8+3)/10.0 brightness:91/100.0 alpha:1],
                       nil];
    
    CGRect pieFrame = CGRectMake(SCREEN_WIDTH/2-PIE_HEIGHT/2, 50, PIE_HEIGHT, PIE_HEIGHT);
    _pieContainer = [[UIView alloc]initWithFrame:pieFrame];
    [self addSubview:self.pieContainer];
}

-(void)viewDidAppear:(BOOL)animated{
    
    [self.pieChartView reloadChart];
}

- (void)selectedFinish:(PieChartView *)pieChartView index:(NSInteger)index percent:(float)per
{
    self.selLabel.text = [NSString stringWithFormat:@"%2.2f%@",per*100,@"%"];
}

@end
