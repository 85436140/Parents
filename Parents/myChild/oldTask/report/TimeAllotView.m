//
//  TimeAllotView.m
//  P_Child
//
//  Created by kfd on 14-11-3.
//  Copyright (c) 2014年 qzz. All rights reserved.
//

#import "TimeAllotView.h"
#define PIE_HEIGHT 200
#define RNAME_WIDTH 200
#define RNAME_HEIGHT 30

@interface TimeAllotView(){

    NSInteger weekCount;
    NSInteger weekTotal;
    
    NSDictionary *timeAllotDic;
}

@end

@implementation TimeAllotView

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [[[NSBundle mainBundle] loadNibNamed:@"TimeAllotView" owner:self options:nil]objectAtIndex:0];
    if (self) {

    }
    return self;
}

-(void)awakeFromNib{
    
    weekCount = 2880;
    weekTotal = 2880;
    [self requestData];
    [self showReportView];
}

-(void)requestData{
    
    NSString *uid_c = [[PC_Globle shareUserDefaults] valueForKey:@"uid_c"];
    NSDictionary *dic = [NSDictionary dictionaryWithObject:uid_c forKey:@"uid"];
    [HTTPREQUEST requestWithPost:@"past/time_allocation.php" requestParams:dic successBlock:^(NSData *data){
        NSString *resultStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        if (![resultStr isEqual:@"0"]) {
            timeAllotDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            weekCount = [timeAllotDic[@"week_count"] intValue];
            weekTotal = [timeAllotDic[@"week_total"] intValue];
            NSLog(@"=====%@",timeAllotDic);
        }
    } failedBlock:^(NSString *code, NSString *msg) {
        
    }];
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
                       [NSNumber numberWithInt:(int)[timeAllotDic valueForKey:@"life_count"]+1],
                       [NSNumber numberWithInt:(int)[timeAllotDic valueForKey:@"play_count"]+1],
                       [NSNumber numberWithInt:(int)[timeAllotDic valueForKey:@"read_count"]+1],
                       [NSNumber numberWithInt:(int)[timeAllotDic valueForKey:@"sports_count"]+1],
                       [NSNumber numberWithInt:(int)[timeAllotDic valueForKey:@"study_count"]+1],
                       [NSNumber numberWithInt:(int)[timeAllotDic valueForKey:@"talent_count"]+1],
                       [NSNumber numberWithInt:(int)[timeAllotDic valueForKey:@"week_count"]+1],
                       [NSNumber numberWithInt:(int)[timeAllotDic valueForKey:@"week_total"]+1],
                       nil];
    
//    self.valueArray = [[NSMutableArray alloc] initWithObjects:
//                       [NSNumber numberWithInt:100],
//                       [NSNumber numberWithInt:200],
//                       [NSNumber numberWithInt:300],
//                       [NSNumber numberWithInt:400],
//                       [NSNumber numberWithInt:500],
//                       [NSNumber numberWithInt:600],
//                       [NSNumber numberWithInt:700],
//                       [NSNumber numberWithInt:2800],
//                       nil];
    
    self.colorArray = [NSMutableArray arrayWithObjects:
                       [UIColor colorWithHue:50.0 / 360.0  saturation:(0%8+3)/10.0 brightness:91/100.0 alpha:1],
                       [UIColor colorWithHue:100.0 / 360.0 saturation:(1%8+3)/10.0 brightness:91/100.0 alpha:1],
                       [UIColor colorWithHue:150.0 / 360.0 saturation:(2%8+3)/10.0 brightness:91/100.0 alpha:1],
                       [UIColor colorWithHue:200.0 / 360.0 saturation:(3%8+3)/10.0 brightness:91/100.0 alpha:1],
                       [UIColor colorWithHue:250.0 / 360.0 saturation:(4%8+3)/10.0 brightness:91/100.0 alpha:1],
                       [UIColor colorWithHue:300.0 / 360.0 saturation:(5%8+3)/10.0 brightness:91/100.0 alpha:1],
                       [UIColor colorWithHue:350.0 / 360.0 saturation:(6%8+3)/10.0 brightness:91/100.0 alpha:1],
                       [UIColor colorWithHue:355.0 / 360.0 saturation:(7%8+3)/10.0 brightness:91/100.0 alpha:1],
                       nil];
    
    CGRect pieFrame = CGRectMake(SCREEN_WIDTH/2-PIE_HEIGHT/2, 50, PIE_HEIGHT, PIE_HEIGHT);
    _pieContainer = [[UIView alloc]initWithFrame:pieFrame];
    [self addSubview:self.pieContainer];
}

-(UIColor *) colorFromHexRGB:(NSString *) inColorString
{
    UIColor *result = nil;
    unsigned int colorCode = 0;
    unsigned char redByte, greenByte, blueByte;
    
    if (nil != inColorString)
    {
        NSScanner *scanner = [NSScanner scannerWithString:inColorString];
        (void) [scanner scanHexInt:&colorCode]; // ignore error
    }
    redByte = (unsigned char) (colorCode >> 16);
    greenByte = (unsigned char) (colorCode >> 8);
    blueByte = (unsigned char) (colorCode); // masks off high bits
    result = [UIColor
              colorWithRed: (float)redByte / 0xff
              green: (float)greenByte/ 0xff
              blue: (float)blueByte / 0xff
              alpha:1.0];
    return result;
}

-(void)viewDidAppear:(BOOL)animated{
    [self.pieChartView reloadChart];
}

- (void)selectedFinish:(PieChartView *)pieChartView index:(NSInteger)index percent:(float)per
{
    self.selLabel.text = [NSString stringWithFormat:@"%2.2f%@",per*100,@"%"];
}


@end
