
//  TaskMainVC.m
//  Parents
//
//  Created by kfd on 14-11-7.
//  Copyright (c) 2014年 qzz. All rights reserved.
//

#import "TaskMainVC.h"
#import "PtaskHeaderView.h"
#import "JSONKit.h"

@interface TaskMainVC (){
    
    PtaskHeaderView *taskHeaderView;
    NSMutableArray *nTaskList;
    NSMutableArray *finishedTaskList;
    NSMutableArray *fTaskList;
    
    NSMutableArray *parentTaskList;
    NSMutableArray *teacherTaskList;
    
    NSArray *headTitleArr;
    
    NSArray *btnArr;
    NSInteger historyX;
    NSInteger finishedTaskCount;
    NSString *uid;
    NSString *role;
    
    BOOL isUpdate;
    
    UIImageView *animateLineIV;
}
@property (nonatomic,strong) UITableView *nTaskTableView;
@property (nonatomic,strong) UITableView *fTaskTableView;
@property (nonatomic,strong) UIView *oldView;
@property (strong,nonatomic) UIScrollView *taskMainScrollView;


@end

@implementation TaskMainVC

-(id)initWithService:(DBService *)taskService{
    self = [super init];
    if (self) {
        self.tService = taskService;
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:NO];
    [self requestFtaskData];
    [self requestData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    uid = [[PC_Globle shareUserDefaults] valueForKey:@"uid_c"];
    btnArr = @[_nowTaskBtnOutlet,_futureTaskBtnOutlet,_oldTaskBtnOutlet];
    headTitleArr = @[@"父母添加任务",@"老师添加任务"];
    finishedTaskCount = 0;
    [self setupPage];
    [self setNavigationBack];
    
    self.title = @"我的孩子";

    animateLineIV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sliderline"]];
    [animateLineIV setFrame:CGRectMake(0, 47, SCREEN_WIDTH/3, 3)];
    [_topView addSubview:animateLineIV];

    finishedTaskList = [[NSMutableArray alloc] initWithCapacity:0];
    
    //向服务端请求任务列表数据
    [self requestData];
    [self requestFtaskData];

    //缓存数据到本地
//    [DBCacheService deleteTaskType];
    [TaskCacheService insertTaskType:nil andTaskType:nil];
    NSArray *array = [TaskCacheService QueryTaskType];
}

-(void)setNavigationBack{

    UIButton *backBtn = [PCBaseVC initWithBtn:@"首页" andBtnFrame:NAVIGATION_RECT_MIN];
    [backBtn setImage:[UIImage imageNamed:@"arrow_left"] forState:UIControlStateNormal];
    [backBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -20, 0, 0)];
    [backBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -20, 0, 0)];
    [backBtn addTarget:self action:@selector(forwardHome) forControlEvents:UIControlEventTouchUpInside];
    [self setNavigationLeftBtn:backBtn];
}

-(void)forwardHome{
    HomeVC *homeVc = [[HomeVC alloc] init];
    [self.navigationController pushViewController:homeVc animated:YES];
}

#pragma request Data
-(void)requestData{

    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:0];
    [dic setValue:uid forKey:@"uid"];
    [dic setValue:@"1" forKey:@"role"];
    finishedTaskCount = 0;
    [HTTPREQUEST requestWithPost:@"task/task_list.php" requestParams:dic successBlock:^(NSData *data) {
        NSError *error;
        NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        nTaskList = [[NSMutableArray alloc] init];
        if (!error) {
            for (NSDictionary *dict in array) {
                NSLog(@"---Data:%@",dict);
                Task *task = [Task boundTaskDataWithdict:dict];
//                if([task.status isEqual:@"3"]){
                    finishedTaskCount ++;
                    [TaskCacheService insertFinishedTask:task];
                if (finishedTaskList.count != 0) {
                    [finishedTaskList removeAllObjects];
                }
                [finishedTaskList addObject:task];
//                }else{
//                    [nTaskList addObject:task];
//                }
            }
        }
        [_nTaskTableView reloadData];
        NSLog(@"=====finishedTaskCount:%lu",(unsigned long)finishedTaskCount);
        
    } failedBlock:^(NSString *code, NSString *msg) {
        
    }];
}

-(void)requestFtaskData{
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:0];
    [dic setValue:uid forKey:@"uid"];
    [dic setValue:@"1" forKey:@"role"];
    [HTTPREQUEST requestWithPost:@"task/task_nostart_list.php" requestParams:dic successBlock:^(NSData *data) {
        NSError *error;
        NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        fTaskList = [[NSMutableArray alloc] init];
        parentTaskList = [[NSMutableArray alloc] init];
        teacherTaskList = [[NSMutableArray alloc] init];
        if (!error) {
            for (NSDictionary *dict in array) {
                Task *task = [Task boundTaskDataWithdict:dict];
                if ([task.role isEqual:@"1"]) {
                    [parentTaskList addObject:task];
                }
                if ([task.role isEqual:@"3"]) {
                    [teacherTaskList addObject:task];
                }
            }
        }
        [_fTaskTableView reloadData];
//        NSLog(@"=====count:%lu",(unsigned long)nTaskList.count);
    } failedBlock:^(NSString *code, NSString *msg) {
        
    }];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [taskHeaderView setFinishedTaskCount:[NSString stringWithFormat:@"%ld",(long)finishedTaskCount]];
}

#pragma mark -- ScrollView
//改变滚动视图的方法实现
- (void)setupPage
{
    _taskMainScrollView = [[UIScrollView alloc]init];
    //设置滚动显示的视图
    [_taskMainScrollView setFrame:CGRectMake(X(_taskMainScrollView), 49, SCREEN_WIDTH, SCREEN_HEIGHT-160)];
    //设置取消触摸
    _taskMainScrollView.canCancelContentTouches = NO;
    //设置滚动条类型
    _taskMainScrollView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
    //是否自动裁切超出部分
    _taskMainScrollView.delegate=self;
    _taskMainScrollView.clipsToBounds = YES;
    //设置是否可以缩放
    _taskMainScrollView.scrollEnabled = YES;
    //设置是否可以进行画面切换
    _taskMainScrollView.pagingEnabled = YES;
    _taskMainScrollView.bounces=NO;
    //    //设置在拖拽的时候是否锁定其在水平或者垂直的方向
    //    _myScrollView.directionalLockEnabled = NO;
    //隐藏滚动条设置（水平、跟垂直方向）
    _taskMainScrollView.alwaysBounceHorizontal = NO;
    _taskMainScrollView.alwaysBounceVertical = NO;
    _taskMainScrollView.showsHorizontalScrollIndicator = NO;
    _taskMainScrollView.showsVerticalScrollIndicator = NO;
    //设置滚动视图的位置
    [_taskMainScrollView setContentSize:CGSizeMake(3*SCREEN_WIDTH, _taskMainScrollView.bounds.size.height)];
    [self initWithView];
}

-(void)initWithView{
    
    //现在任务tableView
    _nTaskTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH(_taskMainScrollView), HEIGH(_taskMainScrollView))];
    _nTaskTableView.dataSource = self;
    _nTaskTableView.delegate = self;
    _nTaskTableView.tag = 0;
    [_taskMainScrollView addSubview:_nTaskTableView];
    taskHeaderView = [[[NSBundle mainBundle] loadNibNamed:@"PtaskHeaderView" owner:self options:nil] objectAtIndex:0];
    _nTaskTableView.tableHeaderView = taskHeaderView;
    
    //将来任务tableView
    _fTaskTableView = [[UITableView alloc]initWithFrame:CGRectMake(WIDTH(_taskMainScrollView), 0, WIDTH(_taskMainScrollView), HEIGH(_taskMainScrollView))];
    _fTaskTableView.dataSource = self;
    _fTaskTableView.delegate = self;
    _fTaskTableView.tag = 1;
    [_taskMainScrollView addSubview:_fTaskTableView];
    
    //过去任务
    OldTaskView *oldView = [[OldTaskView alloc] init];
    [oldView comeInReportBlock:^(NSInteger bTag){
        [self checkReport:bTag];
    }];
    [oldView setFrame:CGRectMake(WIDTH(_taskMainScrollView)*2, 0, WIDTH(_taskMainScrollView), HEIGH(_taskMainScrollView))];
    [_taskMainScrollView addSubview:oldView];
    
    [self.view addSubview:_taskMainScrollView];
}

-(void)checkReport:(NSInteger)btag{
    ReportMainVC *reportMainVc = [[ReportMainVC alloc] initWithReport:btag];
    [self.navigationController pushViewController:reportMainVc animated:YES];
}

//改变页码的方法实现
- (void)changePage:(id)sender
{
    //获取当前视图的页码
    CGRect rect = _taskMainScrollView.frame;
    //设置视图的横坐标，一幅图为320*460，横坐标一次增加或减少320像素
    rect.origin.x = _myPageControl.currentPage * _taskMainScrollView.frame.size.width;
    //设置视图纵坐标为0
    rect.origin.y = 0;
    //scrollView可视区域
    [_taskMainScrollView scrollRectToVisible:rect animated:YES];
    [_myPageControl setCurrentPageIndicatorTintColor:[UIColor greenColor]];
}

//视图滚动位置
-(void)viewScrollPoint:(NSInteger)bTag{
    [_taskMainScrollView setContentOffset:CGPointMake(bTag*WIDTH(_taskMainScrollView), 0) animated:YES];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGPoint point = scrollView.contentOffset;
    NSInteger index = (NSUInteger)point.x/(NSUInteger)WIDTH(scrollView);
    if(index == 0){
        [_nowTaskBtnOutlet setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_futureTaskBtnOutlet setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_oldTaskBtnOutlet setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    }
    if(index == 1){
        [_nowTaskBtnOutlet setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_futureTaskBtnOutlet setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_oldTaskBtnOutlet setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    }
    if(index == 2){
        [_nowTaskBtnOutlet setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_futureTaskBtnOutlet setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_oldTaskBtnOutlet setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    [animateLineIV setFrame:CGRectMake(index*SCREEN_WIDTH/3, 47, SCREEN_WIDTH/3, 3)];
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    historyX = scrollView.contentOffset.x;
}

#pragma mark
#pragma mark UITableView DataSource 
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if ([tableView isEqual:_fTaskTableView]) {
        return 2;
    }
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if([tableView isEqual:_nTaskTableView]){
        return [finishedTaskList count];
    }
    if ([tableView isEqual:_fTaskTableView] && section == 0) {
        return [parentTaskList count];
    }
    if ([tableView isEqual:_fTaskTableView] && section == 1) {
        return [teacherTaskList count];
    }
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentity = @"UITableViewCell";
    tableView.showsVerticalScrollIndicator = NO;
    if ([tableView isEqual:_fTaskTableView]) {
        FutureTaskCell *cell = (FutureTaskCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentity];
        if (!cell) {
            cell=[[FutureTaskCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentity];
        }
        
        if (indexPath.section == 0) {
            Task *fptask = [parentTaskList objectAtIndex:indexPath.row];
            [cell setDataSourceWithData:fptask checkDetailBlock:^(NSInteger bTag){
                [self editTask:fptask];
            }];
        }
        if (indexPath.section == 1) {
            Task *fttask = [teacherTaskList objectAtIndex:indexPath.row];
            [cell setDataSourceWithData:fttask checkDetailBlock:^(NSInteger bTag){
                [self editTask:fttask];
            }];
        }
        return cell;
    }
    
    Task *ntask = [finishedTaskList objectAtIndex:indexPath.row];
    NowTaskCell *nowTaskCell = (NowTaskCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentity];
    if (!nowTaskCell) {
        nowTaskCell = [[NowTaskCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentity];
    }
    
    [nowTaskCell setDataSourceWithObject:ntask checkDetailBlock:^(Task *task){
        [self checkDetail:task];
    }];
    return nowTaskCell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if([tableView isEqual:_nTaskTableView]){
        return 100;
    }
    return 70;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
     return [PCBaseVC customHeadView:[headTitleArr objectAtIndex:section]];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if ([tableView isEqual:_nTaskTableView]) {
        [self checkDetail:[nTaskList objectAtIndex:indexPath.row]];
    }
    
    if ([tableView isEqual:_fTaskTableView]) {
        if (indexPath.section == 0) {
            [self editTask:[parentTaskList objectAtIndex:indexPath.row]];
        }
        if (indexPath.section == 1) {
            [self editTask:[teacherTaskList objectAtIndex:indexPath.row]];
        }
    }
}

#pragma mark -- button Event
-(void)checkDetail:(Task *)task{
    CheckDetailVC *checkDetail = [[CheckDetailVC alloc] initwithTaskId:[task.taskId intValue] andTask:task];
    [self.navigationController pushViewController:checkDetail animated:YES];
}

-(void)editTask:(Task *)ftask{
    DetailTaskTwoVC *updateVc = [[DetailTaskTwoVC alloc] initWithUpdateParams:ftask isUpdate:YES];
    [self.navigationController pushViewController:updateVc animated:YES];
}

- (IBAction)addTaskBtnAction:(id)sender {
    AddTaskVC *addTaskVc = [[AddTaskVC alloc] init];
    [self.navigationController pushViewController:addTaskVc animated:YES];
}

- (IBAction)rewardSetBtnAction:(id)sender {
    RewardSetVC *rewardVc = [[RewardSetVC alloc] init];
    [self.navigationController pushViewController:rewardVc animated:YES];
}

- (IBAction)msgBtnAction:(id)sender {
    NSString *uidC = [[PC_Globle shareUserDefaults] valueForKey:@"uid_c"];
    ChatViewController *chatVc = [[ChatViewController alloc] initWithChatter:uidC isGroup:NO];
    chatVc.title = @"孩子";
    [self.navigationController pushViewController:chatVc animated:YES];
}

- (IBAction)achievementBtnAction:(id)sender {
    AchieveMentVC *achieveVC = [[AchieveMentVC alloc] init];
    [self.navigationController pushViewController:achieveVC animated:YES];
}

- (IBAction)nowTaskBtnAction:(id)sender {
    NSInteger bTag = [sender tag];
    [self viewScrollPoint:bTag];
}

- (IBAction)futureTaskBtnAction:(id)sender {
    NSInteger bTag = [sender tag];
    [self viewScrollPoint:bTag];
    [_fTaskTableView reloadData];
}

- (IBAction)oldTaskBtnAction:(id)sender {
    NSInteger bTag = [sender tag];
    [self viewScrollPoint:bTag];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
