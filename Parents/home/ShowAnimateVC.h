//
//  ShowAnimateVC.h
//  Parents
//
//  Created by kfd on 15-1-16.
//  Copyright (c) 2015年 qzz. All rights reserved.
//

#import "PCBaseVC.h"
#import "HomeVC.h"

@interface ShowAnimateVC : PCBaseVC<UIScrollViewDelegate>

//视图中小圆点，对应视图的页码
@property (retain, nonatomic) UIImageView *myPageControl;;

//动态存储数组，用于存放图片
@property (retain, nonatomic) NSArray *images;

//当前页计数
@property (assign, nonatomic) NSInteger currentPage;

@property (strong, nonatomic) UIScrollView *showScrollView;


@end
