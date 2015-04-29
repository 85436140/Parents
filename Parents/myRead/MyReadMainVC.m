//
//  MyReadMainVC.m
//  Parents
//
//  Created by kfd on 14-11-12.
//  Copyright (c) 2014年 qzz. All rights reserved.
//

#import "MyReadMainVC.h"
#import "LoginVC.h"

@interface MyReadMainVC (){
    
    NSArray *eduHeadTitleArr;
    NSArray *LecheadTitleArr;
    NSArray *lecutureTypeNameArr;
    UIColor *typeNameLblBgColor;
    
    UIImageView *animateIV;
    
    NSString *uidP;
}
@end

@implementation MyReadMainVC

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的订阅";
    eduHeadTitleArr = @[@"编辑精选",@"我的订阅"];
    LecheadTitleArr = @[@"火热报名中",@"即将开启报名"];
    lecutureTypeNameArr = @[@"讲座",@"讲座",@"活动"];
    [self setBackButton];
    
    [self setupPage];
//    SubscriptionView *subView = [[SubscriptionView alloc] init];
//    NSLog(@"---------------%f",WIDTH(subView));
//    [subView setFrame:CGRectMake(0, 10, SCREEN_WIDTH, SCREEN_HEIGHT-50)];
//    [self.view addSubview:subView];
    UIButton *rightBtn = [PCBaseVC initWithBtn:@"我" andBtnFrame:NAVIGATION_RECT_MIN];
    [rightBtn addTarget:self action:@selector(forwardMeVC) forControlEvents:UIControlEventTouchUpInside];
    [self setNavigationRightBtn:rightBtn];
    
    animateIV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sliderline"]];
    [animateIV setFrame:CGRectMake(0, 48, SCREEN_WIDTH/2, 3)];
    [_topView addSubview:animateIV];
    
    uidP = [[PC_Globle shareUserDefaults] valueForKey:@"uid_p"];
    
}

-(void)setBackButton{

    UIButton *leftBtn = [PCBaseVC initWithBtn:@"首页" andBtnFrame:NAVIGATION_RECT_MIN];
    [leftBtn setImage:[UIImage imageNamed:@"arrow_left"] forState:UIControlStateNormal];
    [leftBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -20, 0, 0)];
    [leftBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -20, 0, 0)];
    [leftBtn addTarget:self action:@selector(forwardHomeVc) forControlEvents:UIControlEventTouchUpInside];
    [self setNavigationLeftBtn:leftBtn];
}

-(void)forwardHomeVc{
    HomeVC *homeVc = [[HomeVC alloc] init];
    [self.navigationController pushViewController:homeVc animated:YES];
}

#pragma mark -- ScrollView
//改变滚动视图的方法实现
- (void)setupPage
{
    _myReadMainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(X(_myReadMainScrollView), 50, SCREEN_WIDTH, SCREEN_HEIGHT-180)];
    //设置取消触摸
    _myReadMainScrollView.canCancelContentTouches = NO;
    //设置滚动条类型
    _myReadMainScrollView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
    //是否自动裁切超出部分
    _myReadMainScrollView.delegate=self;
    _myReadMainScrollView.clipsToBounds = YES;
    //设置是否可以缩放
    _myReadMainScrollView.scrollEnabled = YES;
    //设置是否可以进行画面切换
    _myReadMainScrollView.pagingEnabled = YES;
    _myReadMainScrollView.bounces = NO;
    //    //设置在拖拽的时候是否锁定其在水平或者垂直的方向
    //    _myScrollView.directionalLockEnabled = NO;
    //隐藏滚动条设置（水平、跟垂直方向）
    _myReadMainScrollView.alwaysBounceHorizontal = NO;
    _myReadMainScrollView.alwaysBounceVertical = NO;
    _myReadMainScrollView.showsHorizontalScrollIndicator = NO;
    _myReadMainScrollView.showsVerticalScrollIndicator = NO;
    //设置滚动视图的位置
    [_myReadMainScrollView setContentSize:CGSizeMake(2*SCREEN_WIDTH, _myReadMainScrollView.bounds.size.height)];
    [self initWithView];
}

-(void)initWithView{
    
    //教育专栏tableView
    _educationTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH(_myReadMainScrollView), HEIGH(_myReadMainScrollView))];
    _educationTableView.dataSource = self;
    _educationTableView.delegate = self;
    [_myReadMainScrollView addSubview:_educationTableView];
    
    
    //讲座活动tableView
    _lecturesTableView = [[UITableView alloc]initWithFrame:CGRectMake(WIDTH(_myReadMainScrollView), 0, WIDTH(_myReadMainScrollView), HEIGH(_myReadMainScrollView))];
    _lecturesTableView.dataSource = self;
    _lecturesTableView.delegate = self;
    [_myReadMainScrollView addSubview:_lecturesTableView];
    
    [self.view addSubview:_myReadMainScrollView];
}

//改变页码的方法实现
- (void)changePage:(id)sender
{
    //获取当前视图的页码
    CGRect rect = _myReadMainScrollView.frame;
    //设置视图的横坐标，一幅图为320*460，横坐标一次增加或减少320像素
    rect.origin.x = _myPageControl.currentPage * _myReadMainScrollView.frame.size.width;
    //设置视图纵坐标为0
    rect.origin.y = 0;
    //scrollView可视区域
    [_myReadMainScrollView scrollRectToVisible:rect animated:YES];
    [_myPageControl setCurrentPageIndicatorTintColor:[UIColor greenColor]];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGPoint point = scrollView.contentOffset;
    NSInteger index = (NSUInteger)point.x/(NSUInteger)WIDTH(scrollView);
    if(index == 0){
        [_educationBtnOutlet setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_lecutureBtnOutlet setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        if (point.x > 20) {
            [_myReadMainScrollView setFrame:CGRectMake(0, 50, SCREEN_WIDTH, SCREEN_HEIGHT-180)];
            [_editReadBtnOutlet setHidden:NO];
        }
    }
    if(index == 1){
        [_educationBtnOutlet setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_lecutureBtnOutlet setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        if (point.x > 20) {//设定必须横向滑动
            [_myReadMainScrollView setFrame:CGRectMake(0, 50, SCREEN_WIDTH, SCREEN_HEIGHT-100)];
            [_editReadBtnOutlet setHidden:YES];
        }
    }
    [animateIV setFrame:CGRectMake(index*SCREEN_WIDTH/2, 48, SCREEN_WIDTH/2, 3)];
}

#pragma mark
#pragma mark UITableView DataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    if ([tableView isEqual:_educationTableView]) {
        return [eduHeadTitleArr count];
    }
    return [eduHeadTitleArr count];
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if([tableView isEqual:_educationTableView]){
        return [eduHeadTitleArr objectAtIndex:section];
    }
    return [LecheadTitleArr objectAtIndex:section];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    if ([tableView isEqual:_educationTableView]) {
        return 3;
    }
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentiy = @"cellIdentity";
    
    if ([tableView isEqual:_educationTableView]) {
        
        if(indexPath.section == 1){
            
            EducationCell *cell = (EducationCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentiy];
            if (!cell) {
                cell = [[EducationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentiy];
            }
            [cell setDataSourceWithEducationSubject:@"教育专栏" setButtonTag:indexPath.row andCheckDetailBlock:^(NSInteger bTag){
                [self checkDetail:bTag];
            }];
            return cell;
        }
        if (indexPath.section == 0) {
            EditChoiceCell *editChoiceCell = (EditChoiceCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentiy];
            if (!editChoiceCell) {
                editChoiceCell = [[EditChoiceCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentiy];
            }
            [editChoiceCell setDataSourceWithHeadImage:[UIImage imageNamed:@"accout"] andEducationNameLbl:@"二胎妈妈真实剖白：生二胎前必须清楚的事情" andTimeLbl:@"10月17日" andAuthorName:@"尤佳" andPraiseCountLbl:@"0" andCommentCountLbl:@"0"];
            return editChoiceCell;
        }
    }
    
    if (indexPath.section == 0) {
        LecutureActivityCell *lecutureCell = (LecutureActivityCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentiy];
        if (!lecutureCell) {
            lecutureCell = [[LecutureActivityCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentiy];
        }
        if([[lecutureTypeNameArr objectAtIndex:indexPath.row] isEqual:@"讲座"]){
            typeNameLblBgColor = [UIColor yellowColor];
        }
        if([[lecutureTypeNameArr objectAtIndex:indexPath.row] isEqual:@"活动"]){
            typeNameLblBgColor = [UIColor greenColor];
        }
//        [lecutureCell setDataSourceWithTypeName:@"jiangzuo" andLecutureNameLbl:@"成为更好的父母系列之三" andActivityMoney:@"100/人" andActivityAddress:@"上海 浦东新区" andActivityTimeLbl:@""];

        return lecutureCell;
    }
    UpComingSignUpCell *upComingSignUpCell = (UpComingSignUpCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentiy];
    if (!upComingSignUpCell) {
        upComingSignUpCell = [[UpComingSignUpCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentiy];
    }
    [upComingSignUpCell setDataSourceWithTypeName:@"活动" andLecutureTitleLbl:@"沙滩乐园" andCountDownLbl:@"剩下3天 12:25"];
    return upComingSignUpCell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual:_educationTableView]) {
        if (indexPath.section == 0) {
            return 75;
        }
    }
    if ([tableView isEqual:_lecturesTableView]) {
        if (indexPath.section == 0) {
            return 100;
        }
    }
    return 50;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *headView;
    
    if ([tableView isEqual:_educationTableView]) {
        headView = [PCBaseVC customHeadView:[eduHeadTitleArr objectAtIndex:section]];
    }else{
        headView = [PCBaseVC customHeadView:[LecheadTitleArr objectAtIndex:section]];
    }

    if ([tableView isEqual:_lecturesTableView]) {
        
        if (section == 0) {
            
            UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(90, 10, 20, 20)];
            [icon setImage:[UIImage imageNamed:@"hot"]];
            [headView addSubview:icon];

            UIButton *choiceBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/4*3, 0, 100, 40)];
            [choiceBtn setTitle:@"更多>>" forState:UIControlStateNormal];
            [choiceBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [choiceBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
            [headView addSubview:choiceBtn];
            return headView;
        }
        
        UILabel *countDownLbl = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/4*3, 0, 100, 40)];
        [countDownLbl setText:@"倒计时中..."];
        [countDownLbl setTextColor:[UIColor grayColor]];
        [headView addSubview:countDownLbl];
    }
    return headView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if([tableView isEqual:_lecturesTableView] && indexPath.section == 0){
        [self lectutureDetail];
        NSLog(@"-------------------%ld",(long)indexPath.row);
    }
}

-(void)lectutureDetail{
    LecutureDetailVC *lecutureDetail = [[LecutureDetailVC alloc] init];
    [self.navigationController pushViewController:lecutureDetail animated:YES];
}

-(void)checkDetail:(NSInteger)bTag{

    EditChoiceDetailVC *editChoiceDetailVc = [[EditChoiceDetailVC alloc] init];
    [self.navigationController pushViewController:editChoiceDetailVc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)isLogin{
    if (uidP.length == 0) {
        [LoginVC showLoginVCWithSuccesBlock:^{
            MyReadMainVC *myReadMainVc = [[MyReadMainVC alloc] init];
            [self.navigationController pushViewController:myReadMainVc animated:YES];
        } withController:self];
        return NO;
    }
    return YES;
}

-(void)forwardMeVC{
    if ([self isLogin]) {
        PersonVC *personVc = [[PersonVC alloc] init];
        [self.navigationController pushViewController:personVc animated:YES];
    }
}

#pragma mark -- button Evnets
- (IBAction)educationBtnAction:(id)sender {
    
    NSInteger bTag = [sender tag];
    [_editReadBtnOutlet setHidden:NO];
    [_myReadMainScrollView setContentOffset:CGPointMake(bTag*WIDTH(_myReadMainScrollView), 0) animated:YES];
}

- (IBAction)lecutureBtnAction:(id)sender {
    
    [_editReadBtnOutlet setHidden:YES];
    NSInteger bTag = [sender tag];
    [_myReadMainScrollView setContentOffset:CGPointMake(bTag*WIDTH(_myReadMainScrollView), 0) animated:YES];
}

- (IBAction)editReadBtnAction:(id)sender {
    if ([self isLogin]) {
        ManageReadVC *manageReadVC = [[ManageReadVC alloc]init];
        [self.navigationController pushViewController:manageReadVC animated:YES];
    }
}
@end
