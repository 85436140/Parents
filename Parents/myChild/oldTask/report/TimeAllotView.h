//
//  TimeAllotView.h
//  P_Child
//
//  Created by kfd on 14-11-3.
//  Copyright (c) 2014年 qzz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PieChartView.h"
#import "DBService.h"

@interface TimeAllotView : UIView<PieChartDelegate>
@property (nonatomic,strong) NSMutableArray *valueArray;
@property (nonatomic,strong) NSMutableArray *colorArray;
@property (nonatomic,strong) PieChartView *pieChartView;
@property (nonatomic,strong) UIView *pieContainer;
@property (nonatomic,strong) UILabel *selLabel;
@end
