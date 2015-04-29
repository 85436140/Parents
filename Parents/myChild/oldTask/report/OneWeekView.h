//
//  OneWeekView.h
//  P_Child
//
//  Created by kfd on 14-11-3.
//  Copyright (c) 2014年 qzz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OneWeekCell.h"
#import "OneWeekView.h"
#import "OneWeek.h"
#import "HeadTitleView.h"
#import "SVProgressHUD.h"
#import "DBService.h"
#import "CommonView.h"

@interface OneWeekView : UIView{
    UIImageView *imageView;
    NSInteger saveTime;
}

@property (strong, nonatomic) NSMutableArray *oneWeekList;
@property (strong, nonatomic) UILabel *lblValue;
@end
