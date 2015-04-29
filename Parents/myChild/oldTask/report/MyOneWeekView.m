//
//  MyOneWeekView.m
//  Parents
//
//  Created by kfd on 15-1-20.
//  Copyright (c) 2015年 qzz. All rights reserved.
//

#import "MyOneWeekView.h"
#import "OneWeekView.h"

@implementation MyOneWeekView

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

-(void)awakeFromNib{
    
    saveTime = 0;
    
    [self requestData];
    [self drawLine];
    [self initWithBottom];
    _lblValue.text = [NSString stringWithFormat:@"%ld分",saveTime];
}

-(void)initWithBottom{
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-90, SCREEN_HEIGHT-260, 180, 30)];
    [self addSubview:bottomView];
    
    UILabel *lblName = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 30)];
    [lblName setText:@"总计节省时间:"];
    [lblName setFont:[UIFont systemFontOfSize:18]];
    [bottomView addSubview: lblName];
    
    _lblValue = [[UILabel alloc] initWithFrame:CGRectMake(120, 0, 60, 30)];
    [_lblValue setText:@"0分钟"];
    [_lblValue setTextColor:[[UIColor alloc] initWithRed:255/255 green:0 blue:0 alpha:1]];
    [_lblValue setFont:[UIFont boldSystemFontOfSize:18]];
    [bottomView addSubview:_lblValue];
}

-(void)drawLine{
    
    imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 375, 400)];
    [imageView setBackgroundColor:[UIColor greenColor]];
    [self addSubview:imageView];
    self.backgroundColor = [UIColor whiteColor];
    
    UIGraphicsBeginImageContext(imageView.frame.size);
    [[UIColor whiteColor] set];
    CGContextFillRect(UIGraphicsGetCurrentContext(),imageView.bounds);
    [[UIColor blackColor] set];
    
    [imageView.image drawInRect:CGRectMake(0, 0, imageView.frame.size.width, imageView.frame.size.height)];
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 0.1);
    CGContextSetAllowsAntialiasing(UIGraphicsGetCurrentContext(), YES);
    CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 0.0, 0.0, 0.0, 1.0);
    CGContextBeginPath(UIGraphicsGetCurrentContext());
    
    int x = 10;
    int y = 20;
    int h = 40;
    int Ex = 375;
    //列的x点坐标
    int x1= 10,x2 = 80,x3 = 160,x4=240,x5 = 320,x6=373;
    
    //第一行
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), x, y);
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), Ex, y);
    
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:[UIFont boldSystemFontOfSize:15],NSFontAttributeName, nil];
    
    NSString *stringName = @"日期";
    [stringName drawInRect:CGRectMake(x1+20, y+15, 200, 200) withAttributes:dict];
    stringName = @"任务数";
    [stringName drawInRect:CGRectMake(x2+20, y+15, 200, 200) withAttributes:dict];
    stringName = @"计划投入";
    [stringName drawInRect:CGRectMake(x3+10, y+15, 200, 200) withAttributes:dict];
    stringName = @"实际用时";
    [stringName drawInRect:CGRectMake(x4+10, y+15, 200, 200) withAttributes:dict];
    stringName = @"差别";
    [stringName drawInRect:CGRectMake(x5+10, y+15, 200, 200) withAttributes:dict];
    
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
        [stringValue drawInRect:CGRectMake(x1+20, y+15, 200, 200) withAttributes:dict];
        
        stringValue = [NSString stringWithFormat:@"%ld",oneweek.taskCount];
        [stringValue drawInRect:CGRectMake(x2+20, y+15, 200, 200) withAttributes:dict];
        
        stringValue = [NSString stringWithFormat:@"%ld",oneweek.planTime];
        [stringValue drawInRect:CGRectMake(x3+20, y+15, 200, 200) withAttributes:dict];
        
        stringValue = [NSString stringWithFormat:@"%ld",oneweek.costTime];
        [stringValue drawInRect:CGRectMake(x4+20, y+15, 200, 200) withAttributes:dict];
        
        stringValue = [NSString stringWithFormat:@"%ld",oneweek.planTime-oneweek.costTime];
        [stringValue drawInRect:CGRectMake(x5+20, y+15, 200, 200) withAttributes:dict];
        
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
