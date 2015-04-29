//
//  OneWeekView.m
//  P_Child
//
//  Created by kfd on 14-11-3.
//  Copyright (c) 2014年 qzz. All rights reserved.
//

#import "OneWeekView.h"

@interface OneWeek(){

}
@end

@implementation OneWeekView

-(void)requestData{

    NSString *uid_c = [[PC_Globle shareUserDefaults] valueForKey:@"uid_c"];
    NSDictionary *dic = [NSDictionary dictionaryWithObject:uid_c forKey:@"uid"];
    [HTTPREQUEST requestWithPost:@"past/week_efficiency.php" requestParams:dic successBlock:^(NSData *data){
        NSString *resultStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        if (![resultStr isEqual:@"0"]) {
            NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            for (NSDictionary *dict in array) {
                OneWeek *oneWeek = [OneWeek boundDataWithOneWeek:dict];
                [_oneWeekList addObject:oneWeek];
            }
        }
    } failedBlock:^(NSString *code, NSString *msg) {
        
    }];
}

-(id)init{
    self = [super init];
    if (self) {
        saveTime = 0;
        [self requestData];
        [self drawLine];
        [self initWithBottom];
        _lblValue.text = [NSString stringWithFormat:@"%ld分",saveTime];
    }
    return self;
}

-(void)initWithBottom{

    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-68, SCREEN_HEIGHT-260, 136, 30)];
    [self addSubview:bottomView];
    
    UILabel *lblName = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    [lblName setText:@"总计节省时间:"];
    [lblName setFont:[UIFont systemFontOfSize:15]];
    [bottomView addSubview: lblName];
    
    _lblValue = [[UILabel alloc] initWithFrame:CGRectMake(100, 0, 36, 30)];
    [_lblValue setText:@"0分钟"];
    [_lblValue setTextColor:[[UIColor alloc] initWithRed:255/255 green:0 blue:0 alpha:1]];
    [_lblValue setFont:[UIFont boldSystemFontOfSize:15]];
    [bottomView addSubview:_lblValue];
}

-(void)drawLine{
    
    imageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-160, 0, 310, 300)];
//    [imageView setBackgroundColor:[UIColor greenColor]];
    [self addSubview:imageView];
    
    
    UIGraphicsBeginImageContext(imageView.frame.size);
    [[UIColor whiteColor] set];
    CGContextFillRect(UIGraphicsGetCurrentContext(),imageView.bounds);
    [[UIColor blackColor] set];
    
    [imageView.image drawInRect:CGRectMake(0, 0, imageView.frame.size.width, imageView.frame.size.height)];
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 0.1);
    CGContextSetAllowsAntialiasing(UIGraphicsGetCurrentContext(), YES);
    CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 204/255.0, 204/255.0, 204/255.0, 0.1);
    CGContextBeginPath(UIGraphicsGetCurrentContext());
    
    int x = 10;
    int y = 20;
    int h = 35;
    int Ex = 375;
    //列的x点坐标
    int x1= 10,x2 = 70,x3 = 130,x4=190,x5 = 250,x6=310;
    
    //第一行
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), x, y);
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), Ex, y);
    
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:[UIFont boldSystemFontOfSize:14],NSFontAttributeName, nil];
    
    NSString *stringName = @"日期";
    [stringName drawInRect:CGRectMake(x1+15, y+10, 200, 200) withAttributes:dict];
    stringName = @"任务数";
    [stringName drawInRect:CGRectMake(x2+10, y+10, 200, 200) withAttributes:dict];
    stringName = @"计划投入";
    [stringName drawInRect:CGRectMake(x3+3, y+10, 200, 200) withAttributes:dict];
    stringName = @"实际用时";
    [stringName drawInRect:CGRectMake(x4+3, y+10, 200, 200) withAttributes:dict];
    stringName = @"差别";
    [stringName drawInRect:CGRectMake(x5+15, y+10, 200, 200) withAttributes:dict];

    y = y+h;
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), x, y);
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), Ex, y);

    NSString *stringValue;
    //填充数据
    for (int i = 0 ; i<7; i++,y=y+h) {
        CGContextMoveToPoint(UIGraphicsGetCurrentContext(), x, y);
        CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), Ex, y);
        
        OneWeek *oneweek = [_oneWeekList objectAtIndex:i];
        
        stringValue = [NSString stringWithFormat:@"%ld",oneweek.weekday];
        [stringValue drawInRect:CGRectMake(x1+20, y+10, 200, 200) withAttributes:dict];
        
        stringValue = [NSString stringWithFormat:@"%ld",oneweek.taskCount];
        [stringValue drawInRect:CGRectMake(x2+20, y+10, 200, 200) withAttributes:dict];
        
        stringValue = [NSString stringWithFormat:@"%ld",oneweek.planTime];
        [stringValue drawInRect:CGRectMake(x3+20, y+10, 200, 200) withAttributes:dict];
        
        stringValue = [NSString stringWithFormat:@"%ld",oneweek.costTime];
        [stringValue drawInRect:CGRectMake(x4+20, y+10, 200, 200) withAttributes:dict];
        
        stringValue = [NSString stringWithFormat:@"%ld",oneweek.planTime-oneweek.costTime];
        [stringValue drawInRect:CGRectMake(x5+20, y+10, 200, 200) withAttributes:dict];
        
        saveTime += oneweek.planTime-oneweek.costTime;
    }
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), x, y);
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), Ex, y);
    
    //画列
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), x1, 20);
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), x1, y);
    
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), x2, 20);
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), x2, y);
    
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), x3, 20);
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), x3, y);
    
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), x4, 20);
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), x4, y);
    
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), x5, 20);
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), x5, y);
    
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), x6, 20);
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), x6, y);
  
    CGContextStrokePath(UIGraphicsGetCurrentContext());
    imageView.image=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
}

@end
