//
//  ShowAnimateVC.m
//  Parents
//
//  Created by kfd on 15-1-16.
//  Copyright (c) 2015年 qzz. All rights reserved.
//

#import "ShowAnimateVC.h"

@interface ShowAnimateVC ()
{
    UIView *ellipseView;
    NSArray *imgIVs;
    NSInteger currentPageIndex;
    UIButton *comeInBtn;
}

@end

@implementation ShowAnimateVC

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:YES];
    [self.view setBackgroundColor:[[UIColor alloc] initWithRed:252/255.0 green:252/255.0 blue:251/255.0 alpha:1]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _showScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [_showScrollView setBackgroundColor:[UIColor greenColor]];
    _showScrollView.delegate = self;
    [self.view addSubview:_showScrollView];
    
    [self initPageControl];
    _images = @[@"loading1",@"loading2",@"load3"];
    //调用 setuoPage方法
    [self setupPage];
    _currentPage = 0;
    currentPageIndex = 0;
    
    imgIVs = [ellipseView subviews];
    UIImageView *imgIV = [imgIVs objectAtIndex:0];
    [imgIV setImage:[UIImage imageNamed:@"ellipse"]];
    
    [self comeInButton];
}

-(void)setcurrentPageIndex:(NSInteger)page{
    
    UIImageView *img1 = [imgIVs objectAtIndex:0];
    UIImageView *img2 = [imgIVs objectAtIndex:1];
    UIImageView *img3 = [imgIVs objectAtIndex:2];
    if (page == 0) {
        [img1 setImage:[UIImage imageNamed:@"ellipse"]];
        [img2 setImage:[UIImage imageNamed:@"ellipsed"]];
        [img3 setImage:[UIImage imageNamed:@"ellipsed"]];
    }
    if (page == 1) {
        [img1 setImage:[UIImage imageNamed:@"ellipsed"]];
        [img2 setImage:[UIImage imageNamed:@"ellipse"]];
        [img3 setImage:[UIImage imageNamed:@"ellipsed"]];
    }
    if (page == 2) {
        [img1 setImage:[UIImage imageNamed:@"ellipsed"]];
        [img2 setImage:[UIImage imageNamed:@"ellipsed"]];
        [img3 setImage:[UIImage imageNamed:@"ellipse"]];
    }
}

-(void)initPageControl{
    
    ellipseView = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-25, HEIGH(_showScrollView)-100, 50, 10)];
    UIImage *image = [UIImage imageNamed:@"ellipsed"];
    for (int i = 0; i < 3; i++) {
        _myPageControl = [[UIImageView alloc] initWithFrame:CGRectMake(i*16+5, 1, 8, 8)];
        [_myPageControl setImage:image];
        _myPageControl.tag = i;
        [ellipseView addSubview:_myPageControl];
    }
    [self.view addSubview:ellipseView];
}

-(void)comeInButton{

    comeInBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-50, HEIGH(_showScrollView)-70, 100, 30)];
    UIColor *color = [[UIColor alloc] initWithRed:255/255.0 green:139/255.0 blue:158/255.0 alpha:1];
    [comeInBtn setTitle:@"立刻体验" forState:UIControlStateNormal];
    [comeInBtn setTitleColor:color forState:UIControlStateNormal];
    [comeInBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:16]];
    ViewBorderRadius(comeInBtn, 5, 1, color);
    [comeInBtn setHidden:YES];
    [self.view addSubview:comeInBtn];
    
    [comeInBtn addTarget:self action:@selector(forwardToShowVc) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark -- ScrollView
//改变滚动视图的方法实现
- (void)setupPage
{
    //设置取消触摸
    _showScrollView.canCancelContentTouches = NO;
    //设置滚动条类型
    _showScrollView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
    //是否自动裁切超出部分
    _showScrollView.clipsToBounds = YES;
    //设置是否可以缩放
    _showScrollView.scrollEnabled = YES;
    //设置是否可以进行画面切换
    _showScrollView.pagingEnabled = YES;
    _showScrollView.bounces = NO;
    //    //设置在拖拽的时候是否锁定其在水平或者垂直的方向
    //    _myScrollView.directionalLockEnabled = NO;
    //隐藏滚动条设置（水平、跟垂直方向）
    _showScrollView.alwaysBounceHorizontal = NO;
    _showScrollView.alwaysBounceVertical = NO;
    _showScrollView.showsHorizontalScrollIndicator = NO;
    _showScrollView.showsVerticalScrollIndicator = NO;
    //用来记录scrollView的x坐标
    int originX = 0;
    for(NSString *imagename in _images)
    {
        UIImage *image = [UIImage imageNamed:imagename];
        UIImageView *pImageView = [[UIImageView alloc] init];
        //设置视图的背景色
        pImageView.backgroundColor = [UIColor whiteColor];
        //设置imageView的背景图
        [pImageView setImage:image];
        //给imageView设置区域
        CGRect rect = _showScrollView.frame;
        rect.origin.x = originX;
        rect.origin.y = 0;
        rect.size.width = _showScrollView.frame.size.width;
        rect.size.height = _showScrollView.frame.size.height;
        pImageView.frame = rect;
        //把视图添加到当前的滚动视图中
        [_showScrollView addSubview:pImageView];
        //下一张视图的x坐标
        originX += _showScrollView.frame.size.width;
    }
    //设置滚动视图的位置
    [_showScrollView setContentSize:CGSizeMake(_images.count*_showScrollView.frame.size.width, _showScrollView.bounds.size.height)];
}

//改变页码的方法实现
- (void)changePage:(id)sender
{
    //获取当前视图的页码
    CGRect rect = _showScrollView.frame;
    //设置视图纵坐标为0
    rect.origin.y = 0;
    //scrollView可视区域
    [_showScrollView scrollRectToVisible:rect animated:YES];
}

#pragma mark-----UIScrollViewDelegate---------
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{

    CGPoint point = scrollView.contentOffset;
    NSInteger page = (NSUInteger)point.x/(NSUInteger)WIDTH(scrollView);
    if (page == imgIVs.count-1) {
        [comeInBtn setHidden:NO];
    }else{
        [comeInBtn setHidden:YES];
    }
    [self setcurrentPageIndex:page];
}

-(void)forwardToShowVc{
    HomeVC *homeVc = [[HomeVC alloc] init];
    [self.navigationController pushViewController:homeVc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
