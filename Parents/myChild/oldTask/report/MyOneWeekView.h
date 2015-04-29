//
//  MyOneWeekView.h
//  Parents
//
//  Created by kfd on 15-1-20.
//  Copyright (c) 2015年 qzz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyOneWeekView : UIView{
    UIImageView *imageView;
    NSInteger saveTime;
}

@property (strong, nonatomic) NSMutableArray *oneWeekList;
@property (strong, nonatomic) UILabel *lblValue;

@end
