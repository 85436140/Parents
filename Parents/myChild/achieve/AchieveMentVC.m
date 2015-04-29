//
//  AchieveMent.m
//  Parents
//
//  Created by kfd on 14-11-10.
//  Copyright (c) 2014年 qzz. All rights reserved.
//

#import "AchieveMentVC.h"
#import "UIScrollView+MJRefresh.h"

NSString *const MJTableViewCellIdentifier = @"CellIdentity";

@interface AchieveMentVC (){

    BOOL isEdit;
    
    NSInteger idx;
    Subject *subObj;
    
    NSMutableArray *subjectList;
    NSMutableArray *addSubjectLit;
    NSMutableArray *diffSubjectList;
    NSMutableArray *scoreList;
    NSMutableArray *onlyScoreList;
    
    NSArray *subHeadTitleArr;
    
    UIButton *addAwardBtn;
    UIView *createSubjectView;
    UIImageView *animateLineIV;
    
    NSDateComponents *comps;
    NSInteger year;
    NSInteger month;
    
    NSString *quertDateTime;
    
    UIButton *monthBtn;
    UIButton *yearBtn;
}
@property (strong, nonatomic) UITextField *subjectTF;
@property (strong, nonatomic) NSMutableArray *allScoreList;
@property (strong, nonatomic) NSMutableArray *allList;

@end
@implementation AchieveMentVC

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    subject = [subjectList objectAtIndex:idx];
//    [self requestScoreData:subject.subId];
}

-(void)loadView{
    [super loadView];
    
    _achieveTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _achieveTableView.delegate = self;
    _achieveTableView.dataSource = self;
    [self.view addSubview:_achieveTableView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setHidden:NO];
    self.navigationItem.title = @"成绩曲线";
    [self setBackButtonVisible:@"返回" andButtonFrame:NAVIGATION_RECT_MIN];
    [self initNavRightBtn:@"编辑科目"];
    [self initAddSubjectBtn];
    
    isEdit = NO;
    idx = 0;
    subHeadTitleArr = @[@"已添加的科目",@"待添加的科目"];
    addSubjectLit = [[NSMutableArray alloc] initWithCapacity:0];
    diffSubjectList = [[NSMutableArray alloc] initWithCapacity:0];
    scoreList = [[NSMutableArray alloc] initWithCapacity:0];
    onlyScoreList = [[NSMutableArray alloc] initWithCapacity:0];
    _allScoreList = [[NSMutableArray alloc] initWithCapacity:0];
    _allList = [[NSMutableArray alloc] initWithCapacity:0];
    
    //[SubjectCacheService deleteTable:@"Subject"];
    [SubjectCacheService insertSubject:1 andSubjectName:@"语文" andState:@"1"];
    [SubjectCacheService insertSubject:2 andSubjectName:@"数学" andState:@"1"];
    [SubjectCacheService insertSubject:3 andSubjectName:@"英语" andState:@"1"];
    [SubjectCacheService insertSubject:4 andSubjectName:@"物理" andState:@"0"];
    [SubjectCacheService insertSubject:5 andSubjectName:@"化学" andState:@"0"];
    [SubjectCacheService insertSubject:6 andSubjectName:@"生物" andState:@"0"];
    [SubjectCacheService insertSubject:7 andSubjectName:@"历史" andState:@"0"];
    [SubjectCacheService insertSubject:8 andSubjectName:@"地理" andState:@"0"];
    [SubjectCacheService insertSubject:9 andSubjectName:@"政治" andState:@"0"];
    [SubjectCacheService insertSubject:10 andSubjectName:@"口语英语" andState:@"0"];
    
    [self requstLocalSubject];
    [self initWithDateComponents];
    subObj = [subjectList objectAtIndex:idx];
    [self requestScoreData:subObj.subId];
    //刷新
    [self setupRefresh];
}

//刷新
- (void)setupRefresh
{
    [self.achieveTableView addFooterWithTarget:self action:@selector(footerRereshing)];
    self.achieveTableView.footerPullToRefreshText = @"上拉可以加载更多数据了";
    self.achieveTableView.footerReleaseToRefreshText = @"松开马上加载更多数据了";
    self.achieveTableView.footerRefreshingText = @"正在加载中...";
}

#pragma mark 开始进入刷新状态
- (void)footerRereshing
{
    idx++;
    // 1.添加数据
    subObj = [subjectList objectAtIndex:idx];
    [self requestScoreData:subObj.subId];
    
    // 2.2秒后刷新表格UI
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [self.achieveTableView reloadData];
        //调用endRefreshing可以结束刷新状态
        [self.achieveTableView footerEndRefreshing];
    });
}

-(void)requstLocalSubject{
    subjectList = [SubjectCacheService QuerySubject];
    [diffSubjectList removeAllObjects];
    [addSubjectLit removeAllObjects];
    for (Subject *sub in subjectList) {
        if ([sub.state isEqual:@"0"]) {
            [diffSubjectList addObject:sub];
        }else{
            [addSubjectLit addObject:sub];
        }
    }
}

-(void)requestScoreData:(NSString *)subId{
    
    NSString *uid = [[PC_Globle shareUserDefaults] valueForKey:@"uid_p"];
    [HTTPREQUEST requestWithPost:@"score/score_list.php" requestParams:@{@"uid":uid,@"sub_id":subId} successBlock:^(NSData *data) {
        NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        if (array.count != 0) {
            if (scoreList.count != 0) {
                [scoreList removeAllObjects];
            }
            if (onlyScoreList.count != 0) {
                [onlyScoreList removeAllObjects];
            }
            for (NSDictionary *dict in array) {
                Score *score = [Score boundDataWithScore:dict];
                [scoreList addObject:score];
                [onlyScoreList addObject:dict[@"score"]];
            }
            [_allScoreList addObject:onlyScoreList];
            [_allList addObject:scoreList];
        }
    } failedBlock:^(NSString *code, NSString *msg) {
        
    }];
}

-(void)initNavRightBtn:(NSString *)btnTitle{
    UIButton *rightBtn = [PCBaseVC initWithBtn:btnTitle andBtnFrame:NAVIGATION_RECT_MAX];
    [rightBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 40, 0, 0)];
    [rightBtn addTarget:self action:@selector(edit) forControlEvents:UIControlEventTouchUpInside];
    [self setNavigationRightBtn:rightBtn];
}

-(void)initAddSubjectBtn{
    
    createSubjectView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-60, SCREEN_WIDTH, 50)];
    [self.view addSubview:createSubjectView];
    
    _subjectTF = [[UITextField alloc] initWithFrame:CGRectMake(20, 0, SCREEN_WIDTH-120, 30)];
    _subjectTF.placeholder = @"创建一个科目";
    [_subjectTF setBackground:[UIImage imageNamed:@"textbox"]];
    _subjectTF.borderStyle = UITextBorderStyleNone;
    _subjectTF.adjustsFontSizeToFitWidth = YES;
    _subjectTF.clearsOnBeginEditing = YES;
    [createSubjectView addSubview:_subjectTF];
    
    addAwardBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [addAwardBtn setFrame:CGRectMake(SCREEN_WIDTH-40, 0, 30, 30)];
    [addAwardBtn setImage:[UIImage imageNamed:@"kemu_add"] forState:UIControlStateNormal];
    [createSubjectView addSubview:addAwardBtn];
    [addAwardBtn addTarget:self action:@selector(addSubjectAction) forControlEvents:UIControlEventTouchUpInside];
}

-(void)addSubjectAction{
    
    __block NSString *subId;
    NSString *subjectName = [_subjectTF text];
    if (subjectName.length != 0) {
        HttpRequest *req = [[HttpRequest alloc] init];
        NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:0];
        [dict setValue:[[PC_Globle shareUserDefaults] valueForKey:@"uid_p"] forKey:@"uid"];
        [dict setValue:subjectName forKey:@"subject"];
        [req requestWithPost:@"score/subject_add.php" requestParams:dict successBlock:^(NSData *data) {
            NSString *result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            if (![result isEqual:@"0"]) {
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                subId = [dic valueForKey:@"sub_id"];
                [SubjectCacheService insertSubject:[subId intValue] andSubjectName:subjectName andState:@"1"];
                [self requstLocalSubject];
                [_achieveTableView reloadData];
                [SVProgressHUD showErrorWithStatus:@"科目创建成功" duration:1];
                NSLog(@"------add subject success---%@",result);
            }
        } failedBlock:^(NSString *code, NSString *msg) {}];
    }
}

#pragma mark -- DataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0 && isEdit){
        return [addSubjectLit count];
    }
    if (section == 1 && !isEdit) {
        return [_allScoreList count];
    }
    if (section == 2 && isEdit){
        return [diffSubjectList count];
    }
    if (section == 3 && !isEdit){
        return [addSubjectLit count];
    }
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentity = @"CellIdentity";
    tableView.showsVerticalScrollIndicator = NO;
    
    if (indexPath.section == 0 && isEdit) {
        
        AchieveCell *cell = (AchieveCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentity];
        if (!cell) {
            cell = [[AchieveCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentity];
        }
        Subject *subject = [addSubjectLit objectAtIndex:indexPath.row];
        [cell setDataSourceWithData:subject andIsEditBtnBlock:^(NSInteger bTag){
            [self diffSubjectItem:subject];
        } withIsEditState:isEdit];
        return cell;
    }
    
    if (indexPath.section == 1 && !isEdit){
        AchieveReportCell *achieveReportCell = [tableView dequeueReusableCellWithIdentifier:cellIdentity];
        if (!achieveReportCell) {
            achieveReportCell = [[AchieveReportCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentity];
        }
        NSInteger index = indexPath.row;
        NSArray *scores = [_allList objectAtIndex:indexPath.row];
        [achieveReportCell setDataSourceWithAchieveReport:[scores objectAtIndex:index]
                                         andLineChartView:[_allScoreList objectAtIndex:index]
                              withCheckAchieveDetailBlock:^(Subject *subject) {
        AchieveReportDetailVC *achieveReportDetailVc = [[AchieveReportDetailVC alloc] initWithScoreReport:scoreList andOnlyScoreList:onlyScoreList andSubject:subject];
        [self.navigationController pushViewController:achieveReportDetailVc animated:YES];
       }];
       return achieveReportCell;
    }

    if (indexPath.section == 2 && isEdit) {
        AddItemCell *addItemCell = [tableView dequeueReusableCellWithIdentifier:cellIdentity];
        if (!addItemCell) {
            addItemCell = [[AddItemCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentity];
        }
        Subject *subject = [diffSubjectList objectAtIndex:indexPath.row];
        [addItemCell setDataSourceWithSubject:subject addTaskItemBlock:^(NSInteger btag){
            [self addSubjectItem:subject];
        }];
        return addItemCell;
    }
    if (indexPath.section == 3 && !isEdit){
        AddScoreReportSubjectCell *subjectReportCell = [tableView dequeueReusableCellWithIdentifier:cellIdentity];
        if (!subjectReportCell) {
            subjectReportCell = [[AddScoreReportSubjectCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentity];
        }
        Subject *sub = [addSubjectLit objectAtIndex:indexPath.row];
        [subjectReportCell setDataSourceWithAchieveReport:sub withCheckAchieveDetailBlock:^(Subject *subject) {
            AchieveReportDetailVC *achieveReportDetailVc = [[AchieveReportDetailVC alloc] initWithAchievieReport:sub];
            [self.navigationController pushViewController:achieveReportDetailVc animated:YES];
        }];
        return subjectReportCell;
    }
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1 || indexPath.section == 3) {
        return 230;
    }
    return 44;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section == 0 && !isEdit) {
        return @"-";
    }
    return @"";
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0 && !isEdit) {
        return 50;
    }
    if ((section == 0 && isEdit) || (section == 2 && isEdit)) {
        return 40;
    }
    return 0;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 50, SCREEN_WIDTH, 50)];
    if (section == 0 && !isEdit) {
        monthBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, 15, SCREEN_WIDTH/2-30, 25)];
        [monthBtn setTitle:@"月" forState:UIControlStateNormal];
        [monthBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [monthBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];

        [monthBtn addTarget:self action:@selector(monthSelectAction) forControlEvents:UIControlEventTouchUpInside];
        [headView addSubview:monthBtn];
        
        UIColor *color = [[UIColor alloc] initWithRed:209/255.0 green:209/255.0 blue:209/255.0 alpha:1];
        UIView *hLineView = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2, 10, 1, 30)];
        
        [hLineView setBackgroundColor:color];
        [headView addSubview:hLineView];
        
        yearBtn = [[UIButton alloc] initWithFrame:CGRectMake(X(monthBtn)+WIDTH(monthBtn)+30, 15, SCREEN_WIDTH/2-40, 25)];
        [yearBtn setTitle:@"学期" forState:UIControlStateNormal];
        [yearBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [yearBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [yearBtn addTarget:self action:@selector(yearSelectAction) forControlEvents:UIControlEventTouchUpInside];
        [headView addSubview:yearBtn];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 49, SCREEN_WIDTH, 1)];
        [lineView setBackgroundColor:color];
        [headView addSubview:lineView];
        
        animateLineIV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sliderline"]];
        [animateLineIV setFrame:CGRectMake(0, 47, SCREEN_WIDTH/2, 3)];
        [headView addSubview:animateLineIV];
        
        return headView;
    }
    if (isEdit){
        [headView setBackgroundColor:[[UIColor alloc] initWithRed:246/255.0 green:244/255.0 blue:246/255.0 alpha:1]];
        UIView *topLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
        [topLineView setBackgroundColor:[[UIColor alloc] initWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1]];
        [headView addSubview:topLineView];
        
        UIView *bottomLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 39, SCREEN_WIDTH, 1)];
        [bottomLineView setBackgroundColor:[[UIColor alloc] initWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1]];
        [headView addSubview:bottomLineView];
        
        if (section == 0) {
            UILabel *titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 150, 20)];
            [titleLbl setText:@"已添加的科目"];
            [titleLbl setTextColor:[[UIColor alloc] initWithRed:96/255.0 green:96/255.0 blue:96/255.0 alpha:1]];
            [titleLbl setFont:[UIFont boldSystemFontOfSize:15]];
            [headView addSubview:titleLbl];
            return headView;
        }
        
        if (section == 2) {
            UILabel *titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 150, 20)];
            [titleLbl setText:@"待添加的科目"];
            [titleLbl setTextColor:[[UIColor alloc] initWithRed:96/255.0 green:96/255.0 blue:96/255.0 alpha:1]];
            [titleLbl setFont:[UIFont boldSystemFontOfSize:15]];
            [headView addSubview:titleLbl];
            return headView;
        }
    }
    return nil;
}

-(void)initWithDateComponents{
    NSDate *nowdata = [[NSDate alloc] init];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit;
    comps = [calendar components:unitFlags fromDate:nowdata];
    year = [comps year];
    month = [comps month];
    quertDateTime = [NSString stringWithFormat:@"%ld-%ld",year,month];
}

#pragma mark -- button event
-(void)addSubjectItem:(Subject *)subject{
    subject.state = @"1";
    [SubjectCacheService updateSubject:subject];
    [self requstLocalSubject];
    [_achieveTableView reloadData];
}

-(void)diffSubjectItem:(Subject *)subject{
    subject.state = @"0";
    [SubjectCacheService updateSubject:subject];
    [self requstLocalSubject];
    [_achieveTableView reloadData];
}

-(void)monthSelectAction{
    [animateLineIV setFrame:CGRectMake(0, 47, SCREEN_WIDTH/2, 3)];
    
    NSString *uid = [[PC_Globle shareUserDefaults] valueForKey:@"uid_p"];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithCapacity:0];
    [dict setValue:uid forKey:@"uid"];
    [dict setValue:@"1" forKey:@"sub_id"];
    [dict setValue:quertDateTime forKey:@"dateTime"];
    [HTTPREQUEST requestWithPost:@"score/score_monthList.php" requestParams:dict successBlock:^(NSData *data) {
        NSString *resultCode = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        if (![resultCode isEqual:@"0"]) {
            NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            [scoreList removeAllObjects];
            for (NSDictionary *dict in array) {
                Score *score = [Score boundDataWithScore:dict];
                [scoreList addObject:score];
            }
            [_achieveTableView reloadData];
        }
    } failedBlock:^(NSString *code, NSString *msg) {
        
    }];
}

-(void)yearSelectAction{
    NSString *uid = [[PC_Globle shareUserDefaults] valueForKey:@"uid_p"];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithCapacity:0];
    [dict setValue:uid forKey:@"uid"];
    [dict setValue:@"1" forKey:@"sub_id"];
    [HTTPREQUEST requestWithPost:@"score/score_list.php" requestParams:dict successBlock:^(NSData *data) {
        NSString *resultCode = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        if (![resultCode isEqual:@"0"]) {
            NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            [scoreList removeAllObjects];
            for (NSDictionary *dict in array) {
                Score *score = [Score boundDataWithScore:dict];
                [scoreList addObject:score];
            }
            [_achieveTableView reloadData];
        }
    } failedBlock:^(NSString *code, NSString *msg) {
        
    }];
    [animateLineIV setFrame:CGRectMake(SCREEN_WIDTH/2, 47, SCREEN_WIDTH/2, 3)];
}

//编辑任务
-(void)edit
{
    if (isEdit) {
        isEdit = NO;
        [self initNavRightBtn:@"编辑科目"];
        self.navigationItem.title = @"成绩曲线";
        [CommonView animationWithSapceing:NO andView:createSubjectView andSpacing:104];
        [createSubjectView setFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 40)];
        [_achieveTableView setFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    }else{
        isEdit = YES;
        [self initNavRightBtn:@"确认"];
        self.navigationItem.title = @"编辑科目";
        [createSubjectView setFrame:CGRectMake(0, SCREEN_HEIGHT-104, SCREEN_WIDTH, 40)];
        [_achieveTableView setFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-115)];
        [_achieveTableView endEditing:YES];
    }
    [_achieveTableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
