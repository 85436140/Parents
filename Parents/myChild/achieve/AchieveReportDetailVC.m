//
//  AchieveReportDetailVC.m
//  Parents
//
//  Created by kfd on 14-12-29.
//  Copyright (c) 2014年 qzz. All rights reserved.
//

#import "AchieveReportDetailVC.h"
#import "FilterTimeView.h"

@interface AchieveReportDetailVC ()<UITableViewDelegate,UITableViewDataSource>
{
    FilterTimeView *filterTimeView;
    
    NSDateComponents *comps;
    NSInteger year;
    NSInteger month;
    
    NSString *quertDateTime;
    NSString *startTime;
    NSString *endTime;
    
    Subject *_subject;
    BOOL isEditScore;
    BOOL isFilter;
}
@property (strong, nonatomic) NSMutableArray *scoreList;
@property (strong, nonatomic) NSArray *onlyScoreList;
@property (strong, nonatomic) UIView *myScoreView;
@end

@implementation AchieveReportDetailVC

-(instancetype)initWithAchievieReport:(Subject *)subjectReport{
    _subject = subjectReport;
    return [super initWithNibName:@"AchieveReportDetailVC" bundle:nil];
}

-(instancetype)initWithScoreReport:(NSMutableArray *)scoreList andOnlyScoreList:(NSArray *)onlyScoreList andSubject:(Subject *)subject{
    _scoreList = scoreList;
    _onlyScoreList = onlyScoreList;
    _subject = subject;
    return [super initWithNibName:@"AchieveReportDetailVC" bundle:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setBackButtonVisible:@"返回" andButtonFrame:NAVIGATION_RECT_MIN];
    
    [self requestScoreData];
    if (_scoreList.count == 0) {
        self.title = [NSString stringWithFormat:@"%@成绩曲线",_subject.subject];
    }else{
        Score *score = [_scoreList objectAtIndex:0];
        self.title = [NSString stringWithFormat:@"%@成绩曲线",score.subject];
        [_myAvgScoreLbl setText:[NSString stringWithFormat:@"%.2f",score.average]];
        [_myAvgScoreLbl setText:[self myAvgScore]];
    }
    
    isEditScore = NO;
    isFilter = NO;
    
    UIButton *filterBtn = [PCBaseVC initWithBtn:@"" andBtnFrame:NAVIGATION_RECT_MAX];
    [filterBtn setImage:[UIImage imageNamed:@"select"] forState:UIControlStateNormal];
    [filterBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 70, 0, 0)];
    [filterBtn addTarget:self action:@selector(filterAction) forControlEvents:UIControlEventTouchUpInside];
    [self setNavigationRightBtn:filterBtn];
    [self initWithLineChartView];
    [self initWithDateComponents];
    
    //时间选择器
    filterTimeView = [[[NSBundle mainBundle] loadNibNamed:@"FilterTimeView" owner:self options:nil] objectAtIndex:0];
    [filterTimeView setFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
    [filterTimeView setHidden:YES];
    [filterTimeView choiceFilterTimeBlock:^(NSString *startTimeStr, NSString *endTimeStr) {
        startTime = startTimeStr;
        endTime = endTimeStr;
        [self requestFilterScore:_subject.subId];
    }];
    [self.view addSubview:filterTimeView];
}

-(NSString *)myAvgScore{
    NSInteger sumScore;
    NSInteger count = _scoreList.count;
    for (int i = 0; i < count; i++) {
        Score *score = [_scoreList objectAtIndex:i];
        sumScore += score.score;
    }
    return [NSString stringWithFormat:@"%.2f",(CGFloat)sumScore/count];
}

#pragma mark -- dataSource and Delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_scoreList count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *cellIdentity = @"CellIdentity";
    ScoreCell *cell = (ScoreCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentity];
    if (!cell) {
        cell = [[ScoreCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentity];
    }
    Score *score = [_scoreList objectAtIndex:indexPath.row];
    [cell setDataSourceWithScore:score withEditScoreBlock:^(Score *score) {
        isEditScore = YES;
        AddAchieveMentVC *addAchieveVc = [[AddAchieveMentVC alloc] initWithScore:score whitIsEdit:YES];
        [self.navigationController pushViewController:addAchieveVc animated:YES];
    }];
    return cell;
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}

//滑动删除
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    isEditScore = YES;
    Score *score = [_scoreList objectAtIndex:indexPath.row];
    [self deleteScore:score.scoreId];
}

-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}

-(void)deleteScore:(NSInteger)scoreId{
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithCapacity:0];
    [dict setValue:[[PC_Globle shareUserDefaults] valueForKey:@"uid_p"] forKey:@"uid"];
    [dict setValue:_subject.subId forKey:@"sub_id"];
    [dict setValue:[NSString stringWithFormat:@"%ld",scoreId] forKey:@"score_id"];
    [HTTPREQUEST requestWithPost:@"score/score_del.php" requestParams:dict successBlock:^(NSData *data) {
        NSString *result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        if (![result isEqual:@"0"]) {
            NSLog(@"--------delete score success:%@",result);
            [self requestScoreData];
        }
    } failedBlock:^(NSString *code, NSString *msg) {
        
    }];
}

-(void)filterAction{
    if (!isFilter) {
        isFilter = YES;
        [UIView animateWithDuration:0.1 animations:^{
            [filterTimeView setHidden:NO];
            [filterTimeView setFrame:CGRectMake(0, 0, WIDTH(filterTimeView), 100)];
        }];
    }else{
        isFilter = NO;
        [UIView animateWithDuration:0.1 animations:^{
            [filterTimeView setHidden:YES];
            [filterTimeView setFrame:CGRectMake(0, 0, WIDTH(filterTimeView), 1)];
        }];
    }
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (isEditScore) {
        [self requestScoreData];
    }
}

-(void)initWithDateComponents{
    NSDate *nowdata = [[NSDate alloc] init];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit;
    comps = [calendar components:unitFlags fromDate:nowdata];
    year = [comps year];
    month = [comps month];
    NSString *datetime = [NSString stringWithFormat:@"%ld月,%ld",month,year];
    quertDateTime = [NSString stringWithFormat:@"%ld-%ld",year,month];
    [_monthLbl setText:datetime];
}

-(void)initWithLineChartView{
    
    PNLineChartView *lineChartView = [[PNLineChartView alloc] initWithFrame:CGRectMake(0, 0, 300, 200)];
    [lineChartView setBackgroundColor:[UIColor whiteColor]];
    _myScoreView = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-160, 0, 320, 150)];
    [_myScoreView addSubview:lineChartView];
    [_SocreReportView addSubview:_myScoreView];
    
    lineChartView.max = 100;
    lineChartView.min = 0;
    //设置间距
    lineChartView.interval = (lineChartView.max - lineChartView.min)/2;
    
    NSMutableArray *arrY = [@[] mutableCopy];
    for (int i = 0; i < 3; i++) {
        NSString *str = [NSString stringWithFormat:@"%.0f",lineChartView.min+lineChartView.interval*i];
        [arrY addObject:str];
    }
    lineChartView.xAxisValues = @[@"1", @"2", @"3",@"4", @"5", @"6",@"7"];
    
    lineChartView.yAxisValues = arrY;
    lineChartView.numberOfVerticalElements = arrY.count;
    lineChartView.axisLeftLineWidth = 35;
    lineChartView.pointerInterval = 35;
    
    if (_onlyScoreList.count != 0) {
        PNPlot *plot = [[PNPlot alloc] init];
        plot.plottingValues = _onlyScoreList;
        plot.lineColor = [UIColor redColor];
        plot.lineWidth = 1.0;
        [lineChartView addPlot:plot];
    }
}

-(void)requestScoreData{
    
    NSString *uid = [[PC_Globle shareUserDefaults] valueForKey:@"uid_p"];
    [HTTPREQUEST requestWithPost:@"score/score_list.php" requestParams:@{@"uid":uid,@"sub_id":_subject.subId} successBlock:^(NSData *data) {
        NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        if (array.count != 0) {
            if (_scoreList.count != 0) {
                [_scoreList removeAllObjects];
            }
            for (NSDictionary *dict in array) {
                Score *score = [Score boundDataWithScore:dict];
                [_scoreList addObject:score];
            }
        }
        [_scoreTB reloadData];
    } failedBlock:^(NSString *code, NSString *msg) {
        NSLog(@"---------code:%@,%@",code,msg);
    }];
}

-(void)requestScoreByMonth:(NSString *)subId{
    
    NSString *uid = [[PC_Globle shareUserDefaults] valueForKey:@"uid_p"];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithCapacity:0];
    [dict setValue:uid forKey:@"uid"];
    [dict setValue:subId forKey:@"sub_id"];
    [dict setValue:quertDateTime forKey:@"dateTime"];
    [HTTPREQUEST requestWithPost:@"score/score_monthList.php" requestParams:dict successBlock:^(NSData *data) {
        NSString *resultCode = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        if (![resultCode isEqual:@"0"]) {
            NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            if (_scoreList.count != 0) {
                [_scoreList removeAllObjects];
            }
            for (NSDictionary *dict in array) {
                Score *score = [Score boundDataWithScore:dict];
                [_scoreList addObject:score];
            }
            [self removeSubview:_SocreReportView];
            [self initWithLineChartView];
            [_scoreTB reloadData];
        }
    } failedBlock:^(NSString *code, NSString *msg) {
        
    }];
}

-(void)requestFilterScore:(NSString *)subId{
    
    NSString *uid = [[PC_Globle shareUserDefaults] valueForKey:@"uid_p"];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithCapacity:0];
    [dict setValue:uid forKey:@"uid"];
    [dict setValue:subId forKey:@"sub_id"];
    [dict setValue:startTime forKey:@"start"];
    [dict setValue:endTime forKey:@"end"];
    [HTTPREQUEST requestWithPost:@"score/score_filter.php" requestParams:dict successBlock:^(NSData *data) {
        NSString *resultCode = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        if (![resultCode isEqual:@"0"]) {
            NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            [_scoreList removeAllObjects];
            for (NSDictionary *dict in array) {
                Score *score = [Score boundDataWithScore:dict];
                [_scoreList addObject:score];
            }
            [self removeSubview:_SocreReportView];
            [self initWithLineChartView];
            [_scoreTB reloadData];
        }
    } failedBlock:^(NSString *code, NSString *msg) {
        
    }];
}

-(void)removeSubview:(UIView *)view{
    for (UIView *v in view.subviews) {
        if ([v isKindOfClass:[PNLineChartView class]]) {
            [v removeFromSuperview];
        }
    }
}

- (IBAction)preMonthBtnAction:(id)sender {

    month --;
    if (month < 1) {
        year --;
        month = 12;
    }
    NSString *datetime = [NSString stringWithFormat:@"%ld月,%ld",month,year];
    [_monthLbl setText:datetime];
    
    quertDateTime = [NSString stringWithFormat:@"%ld-%ld",year,month];
    [self requestScoreByMonth:_subject.subId];
    [_scoreTB reloadData];
}

- (IBAction)nextMonthBtnAction:(id)sender {
    
    month ++;
    if (month > 12) {
        year ++;
        month = 1;
    }
    NSString *datetime = [NSString stringWithFormat:@"%ld月,%ld",month,year];
    [_monthLbl setText:datetime];
    quertDateTime = [NSString stringWithFormat:@"%ld-%ld",year,month];
    [self requestScoreByMonth:_subject.subId];
    [_scoreTB reloadData];
}

- (IBAction)addAchieveBtnAction:(id)sender {
    AddAchieveMentVC *addAchieveVc = [[AddAchieveMentVC alloc] initWithSubject:_subject];
    [self.navigationController pushViewController:addAchieveVc animated:YES];
    isEditScore = YES;
//    [AddAchieveMentVC showAchieveMentListWithBlock:^{
//       
//    } withVC:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
