//
//  ReportViewController.m
//  P_Child
//
//  Created by kfd on 14/11/2.
//  Copyright (c) 2014年 qzz. All rights reserved.
//

#import "ReportMainVC.h"
#import <ShareSDK/ShareSDK.h>

@interface ReportMainVC (){
    NSArray *reportViews;
    NSArray *titleArr;
    NSInteger reportIndex;
    NSInteger preId;
    NSInteger nextId;
}

@end

@implementation ReportMainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    titleArr = @[@"时间分配",@"一周效率",@"我的成就",@"我的成长"];
    [self.navigationController.navigationBar setBackgroundColor:[UIColor grayColor]];
    [self.navigationController.navigationBar setHidden:NO];
    
    preId = 0;
    nextId = 0;
    
    [self setLeftButton:@"我的成长"];
    [self setRightButton:@"时间分配"];

    self.navigationItem.title = [titleArr objectAtIndex:reportIndex];
    
//    TimeControlView *timeControl = [[TimeControlView alloc] init];
    TimeAllotView *timeAllot = [[TimeAllotView alloc] init];
    OneWeekView *oneWeek = [[OneWeekView alloc] init];
    MyAchieveView *myAchieve = [[MyAchieveView alloc] init];
    MyGrownView *myGrown = [[MyGrownView alloc] init];
    reportViews = @[timeAllot,oneWeek,myAchieve,myGrown];
    [self setupPage:reportViews];
    
    [_reportMainScrolView setContentOffset:CGPointMake(reportIndex*SCREEN_WIDTH, 0) animated:YES];
}

-(void)setLeftButton:(NSString *)btnTitle{
    UIButton *leftBtn = [PCBaseVC initWithBtn:btnTitle andBtnFrame:NAVIGATION_RECT_MAX];
    [leftBtn setImage:[UIImage imageNamed:@"my_arrow_left"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(backToPreview) forControlEvents:UIControlEventTouchUpInside];
    [leftBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -40, 0, 0)];
    [leftBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -40, 0, 0)];
    UIBarButtonItem *backBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = backBarButtonItem;
}

-(void)setRightButton:(NSString *)btnTitle{
    UIButton *rightBtn = [PCBaseVC initWithBtn:btnTitle andBtnFrame:NAVIGATION_RECT_MAX];
    [rightBtn setImage:[UIImage imageNamed:@"my_arrow_right"] forState:UIControlStateNormal];
    [rightBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 90, 0, 0)];
    [rightBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 15, 0, 0)];
    [rightBtn addTarget:self action:@selector(nextToView) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = backBarButtonItem;
}

-(void)backToPreview{
    
    reportIndex--;
    if (reportIndex < 0) {
        reportIndex = [titleArr count]-1;
    }
    [_reportMainScrolView setContentOffset:CGPointMake(reportIndex*WIDTH(_reportMainScrolView), 0)];
    self.navigationItem.title = [titleArr objectAtIndex:reportIndex];
    [self setLeftButton:[titleArr objectAtIndex:preId]];
}

-(void)nextToView{
    
    reportIndex++;
    if (reportIndex > [titleArr count]-1) {
        reportIndex = 0;
    }
    [_reportMainScrolView setContentOffset:CGPointMake(reportIndex*WIDTH(_reportMainScrolView), 0)];
    self.navigationItem.title = [titleArr objectAtIndex:reportIndex];
    [self setRightButton:[titleArr objectAtIndex:nextId]];
}

-(instancetype)initWithReport:(NSInteger)index{
    reportIndex = index;
    return [super initWithNibName:@"ReportMainVC" bundle:nil];
}

#pragma mark -- ScrollView
//改变滚动视图的方法实现
- (void)setupPage:(id)sender
{
    //设置滚动显示的视图
    [_reportMainScrolView setFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-170)];
    //设置取消触摸
    _reportMainScrolView.canCancelContentTouches = NO;
    //设置滚动条类型
    _reportMainScrolView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
    //是否自动裁切超出部分
    _reportMainScrolView.delegate=self;
    _reportMainScrolView.clipsToBounds = YES;
    //设置是否可以缩放
    _reportMainScrolView.scrollEnabled = YES;
    //设置是否可以进行画面切换
    _reportMainScrolView.pagingEnabled = YES;
//    _reportMainScrolView.bounces=NO;
    //    //设置在拖拽的时候是否锁定其在水平或者垂直的方向
    //    _myScrollView.directionalLockEnabled = NO;
    //隐藏滚动条设置（水平、跟垂直方向）
    _reportMainScrolView.alwaysBounceHorizontal = NO;
    _reportMainScrolView.alwaysBounceVertical = NO;
    _reportMainScrolView.showsHorizontalScrollIndicator = NO;
    _reportMainScrolView.showsVerticalScrollIndicator = NO;
    //用来记录页数
    NSUInteger pages = 0;
    //用来记录scrollView的x坐标
    int originX = 0;
    for(int i=0;i<reportViews.count;i++)
    {
        UIView *reportView = [reportViews objectAtIndex:i];
        //给View设置区域
        CGRect rect = _reportMainScrolView.frame;
        rect.origin.x = originX;
        rect.origin.y = 24;
        rect.size.width = _reportMainScrolView.frame.size.width;
        reportView.frame = rect;
        //添加指定的view视图
        [_reportMainScrolView addSubview:reportView];
        //下一张视图的x坐标:offset为:self.scrollView.frame.size.width.
        originX += _reportMainScrolView.frame.size.width;
        //记录scrollView内View的个数
        pages++;
    }
    //设置页码控制器的响应方法
    [_myPageControl addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventValueChanged];
    [_myPageControl setCurrentPageIndicatorTintColor:[UIColor greenColor]];
    //设置总页数
    _myPageControl.numberOfPages = pages;
    //默认当前页为第一页
    _myPageControl.currentPage = 0;
    //为页码控制器设置标签
    _myPageControl.tag = 110;
    //设置滚动视图的位置
    [_reportMainScrolView setContentSize:CGSizeMake(reportViews.count*_reportMainScrolView.frame.size.width, _reportMainScrolView.bounds.size.height)];
}

//改变页码的方法实现
- (void)changePage:(id)sender
{
    //获取当前视图的页码
    CGRect rect = _reportMainScrolView.frame;
    //设置视图的横坐标，一幅图为320*460，横坐标一次增加或减少320像素
    rect.origin.x = _myPageControl.currentPage * _reportMainScrolView.frame.size.width;
    //设置视图纵坐标为0
    rect.origin.y = 0;
    //scrollView可视区域
    [_reportMainScrolView scrollRectToVisible:rect animated:YES];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{

    CGPoint point = scrollView.contentOffset;
    if (point.x<0) {
        [scrollView setContentOffset:CGPointMake((titleArr.count-1)*WIDTH(scrollView), 0)];
        self.navigationItem.title = [titleArr objectAtIndex:titleArr.count-1];
    }
    else if (point.x>WIDTH(scrollView)*(reportViews.count-1)) {
        [scrollView setContentOffset:CGPointMake(0, 0)];
        self.navigationItem.title = [titleArr objectAtIndex:0];
    }
    else
    {
 
        NSInteger scrollIndex = (NSUInteger)point.x/(NSUInteger)WIDTH(scrollView);
        if (scrollIndex-1<0) {
            preId = titleArr.count-1;
        }else{
            preId = scrollIndex - 1;
        }
        
        if(scrollIndex+1>titleArr.count-1){
            nextId = 0;
        }else{
            nextId = scrollIndex + 1;
        }
        self.navigationItem.title = [titleArr objectAtIndex:scrollIndex];
        [self setLeftButton:[titleArr objectAtIndex:preId]];
        [self setRightButton:[titleArr objectAtIndex:nextId]];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- click event action
- (IBAction)backBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)shareBtn:(id)sender {
    
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"ShareSDK" ofType:@"png"];
    //构造分享内容
    id<ISSContent> publishContent = [ShareSDK content:@"分享内容"
                                       defaultContent:@"测试一下"
                                                image:[ShareSDK imageWithPath:imagePath]
                                                title:@"ShareSDK"
                                                  url:@"http://www.mob.com"
                                          description:@"这是一条测试信息"
                                            mediaType:SSPublishContentMediaTypeNews];
    //创建弹出菜单容器
    id<ISSContainer> container = [ShareSDK container];
    [container setIPadContainerWithView:sender arrowDirect:UIPopoverArrowDirectionUp];
    
    //弹出分享菜单
    [ShareSDK showShareActionSheet:container
                         shareList:nil
                           content:publishContent
                     statusBarTips:YES
                       authOptions:nil
                      shareOptions:nil
                            result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                                
                                if (state == SSResponseStateSuccess)
                                {
                                    NSLog(NSLocalizedString(@"TEXT_ShARE_SUC", @"分享成功"));
                                }
                                else if (state == SSResponseStateFail)
                                {
                                    NSLog(NSLocalizedString(@"TEXT_ShARE_FAI", @"分享失败,错误码:%d,错误描述:%@"), [error errorCode], [error errorDescription]);
                                }
                            }];
}
@end
