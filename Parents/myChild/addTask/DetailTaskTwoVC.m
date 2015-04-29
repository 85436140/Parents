//
//  DetailTaskTwoViewController.m
//  P_Child
//
//  Created by David on 14/10/27.
//  Copyright (c) 2014年 kfd. All rights reserved.
//

#import "DetailTaskTwoVC.h"
#import "CommonView.h"

@interface DetailTaskTwoVC ()
{
    BOOL isExpansion;
    BOOL isUpdate;
    
    NSString *isRemind;
    NSInteger _taskTypeId;
    
    NSArray *planTimeArr;
    NSArray *hourArr;
    NSArray *minuteArr;
    NSArray *photoStateArr;
    
    NSString *_taskName;
    NSString *hourStr;
    NSString *minuteStr;
    NSString *photoSate;
    NSString *assessTime;
    NSString *startTime;
    
    Task *_task;
}
@property (strong ,nonatomic) CustomAlertView *alertView;
@end

@implementation DetailTaskTwoVC

-(instancetype)initwithTaskTypeId:(NSInteger)taskTypeId andTaskName:(NSString *)taskName{
    _taskTypeId = taskTypeId;
    _taskName = taskName;
    return [super initWithNibName:@"DetailTaskTwoVC" bundle:nil];
}

-(instancetype)initWithUpdateParams:(Task *)task isUpdate:(BOOL)flag{
    _task = task;
    isUpdate = flag;
    return [super initWithNibName:@"DetailTaskTwoVC" bundle:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setBackButtonVisible:@"返回" andButtonFrame:NAVIGATION_RECT_MIN];
    [self.navigationController.navigationBar setHidden:NO];
    self.navigationItem.title = _taskName;

    isExpansion = NO;
    isRemind = @"0";//0表示不提醒
    photoSate = @"0";
    
    UIButton *rightBtn = [PCBaseVC initWithBtn:@"确定" andBtnFrame:NAVIGATION_RECT_MIN];
    [rightBtn addTarget:self action:@selector(comfirmAction) forControlEvents:UIControlEventTouchUpInside];
    [self setNavigationRightBtn:rightBtn];
    
    photoStateArr = [NSArray arrayWithObjects:@"不拍照",@"开始时",@"结束时",@"都要拍", nil];
    planTimeArr = @[@"00",@"05",@"10",@"15",@"20",@"25",@"30",@"35",@"40",@"45",@"50",@"55",@"60"];
    hourArr = @[@"00",@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23"];
    minuteArr = @[@"00",@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23",@"24",@"25",@"26",@"27",@"28",@"29",@"30",@"31",@"32",@"33",@"34",@"35",@"36",@"37",@"38",@"39",@"40",@"41",@"42",@"43",@"44",@"45",@"46",@"47",@"48",@"49",@"50",@"51",@"52",@"53",@"54",@"55",@"56",@"57",@"58",@"59"];
    
    if (isUpdate) {
        [_confirmAddBtnOutlet setTitle:@"确认修改" forState:UIControlStateNormal];
        NSString *time = [CommonView changetimeStamp:_task.planStartTime andFormatter:@"hh:mm"];
        [_planTimeBtnOutlet setTitle:_task.planTime forState:UIControlStateNormal];
        if (_task.planStartTime.length != 0) {
            [_startTimeButOutlet setTitle:time forState:UIControlStateNormal];
        }
        [_photoBtnOutlet setTitle:[photoStateArr objectAtIndex:[_task.photoStatus intValue]] forState:UIControlStateNormal];
    }
    
    _alertView = [[[NSBundle mainBundle] loadNibNamed:@"CustomAlertView" owner:self options:nil]objectAtIndex:0];
}

//是否设置提醒
- (IBAction)onSwitch:(id)sender {
    
    if(_isRemindSwitch.isOn){
        isRemind = @"1";
        [_setRemindView setHidden:NO];
        [self animationWithDiff:NO];
    }else{
        isRemind = @"0";
        [_setRemindView setHidden:YES];
        [self animationWithDiff:YES];
    }
}

-(void)comfirmAction{

    NSString *excuteMethod = [[NSString alloc] init];
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:0];
    
    NSString *taskType = [NSString stringWithFormat:@"%ld",(long)_taskTypeId];
    NSString *uid = [[PC_Globle shareUserDefaults] valueForKey:@"uid_c"];
    NSString *role = [[PC_Globle shareUserDefaults] valueForKey:@"role"];
    __block NSString *name_type_id;
    
    if (isUpdate) {
        excuteMethod = @"task/task_edit.php";
        [_planTimeBtnOutlet setTitle:_task.planTime forState:UIControlStateNormal];
        [_startTimeButOutlet setTitle:_task.startTime forState:UIControlStateNormal];
        [_photoBtnOutlet setTitle:_task.photoStatus forState:UIControlStateNormal];
        [dic setValue:_task.taskId forKey:@"tid"];
    }else{
        excuteMethod = @"task/task_add.php";
        name_type_id = [TaskCacheService QueryTaskTypeByTaskName:_taskName andTaskType:_taskTypeId];
        
        NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:0];
        [dict setValue:_taskName forKey:@"task_name"];
        [dict setValue:taskType forKey:@"task_type"];
        
        if (name_type_id.length == 0) {
            [HTTPREQUEST requestWithPost:@"task/task_type_list.php" requestParams:dict successBlock:^(NSData *data) {
                if ([[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] != 0) {
                    NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                    NSLog(@"--------task_type_list success----%@",result);
                    name_type_id = result[@"name_type_id"];
                    [TaskCacheService insertTaskType:_taskName andTaskType:[name_type_id intValue]];
                }
            } failedBlock:^(NSString *code, NSString *msg) {}];
        }
    }
    
    [dic setValue:uid forKey:@"uid"];
    [dic setValue:name_type_id forKey:@"name_type_id"];
    [dic setValue:_planTimeBtnOutlet.titleLabel.text forKey:@"plan_time"];
    [dic setValue:isRemind forKey:@"needRemind"];
    
    NSString *time = _startTimeButOutlet.titleLabel.text;
    NSLog(@"-----------%@",time);
    
    NSDate *date = [[NSDate alloc] init];
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd"];
    NSString *dateStr = [NSString stringWithFormat:@"%@ %@:00",[df stringFromDate:date],time];
    NSString *planStartTimeSTP = [CommonView changeDateToTimeStamp:dateStr];
    
    [dic setValue:planStartTimeSTP forKey:@"plan_startTime"];
    [dic setValue:photoSate forKey:@"needPhoto"];
    [dic setValue:role forKey:@"role"];
    
    [HTTPREQUEST requestWithPost:excuteMethod requestParams:dic successBlock:^(NSData *data) {
        
        NSString *result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        if (![result isEqual:@"0"]) {
            [self dismissView];
            NSLog(@"==+++==%@",result);
            [self pushTask];
        }
    } failedBlock:^(NSString *code, NSString *msg) {
    }];
}

- (IBAction)confirmBtnAction:(id)sender {
    [self comfirmAction];
}

//推送任务
-(void)pushTask{

    HttpRequest *req = [[HttpRequest alloc] init];
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:0];
    NSUserDefaults *user = [PC_Globle shareUserDefaults];
    [dict setValue:[user valueForKey:@"uid_p"] forKey:@"uid"];
    [dict setValue:@"2" forKey:@"role"];
    [dict setValue:@"新任务来了,请及时查看" forKey:@"msg"];
    [req requestWithPost:@"push/push_test.php" requestParams:dict successBlock:^(NSData *data) {
        NSString *result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        if (![result isEqual:@"0"]) {
            NSLog(@"====push task success====%@",result);
        }
    } failedBlock:^(NSString *code, NSString *msg) {
        
    }];
}

-(void)dismissView{
    NSArray *viewControlers = self.navigationController.viewControllers;
    [self.navigationController popToViewController:[viewControlers objectAtIndex:2] animated:YES];
}

#pragma mark -- animate
-(void)animationWithDiff:(BOOL)isDiff
{
    if (isDiff) {
        [UIView animateWithDuration:0.2 animations:^{
            [_remindView setFrame:CGRectMake(X(_remindView), Y(_remindView), WIDTH(_remindView), HEIGH(_remindView)-50)];
            [_bottomView setFrame:CGRectMake(X(_bottomView), Y(_bottomView)-50, WIDTH(_bottomView), HEIGH(_bottomView))];
        }];
    }
    else
    {
        [UIView animateWithDuration:0.2 animations:^{
            [_remindView setFrame:CGRectMake(X(_remindView), Y(_remindView), WIDTH(_remindView), HEIGH(_remindView)+50)];
            [_bottomView setFrame:CGRectMake(X(_bottomView), Y(_bottomView)+50, WIDTH(_bottomView), HEIGH(_bottomView))];
        }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)planTimeBtnAction:(id)sender {
    
    [_alertView setDataSource:planTimeArr withDataList2:nil withDataList3:nil withKey:nil cancelBlock:^{
        
    } sureBlock:^(NSString *row1, NSString *row1Str, NSString *row2, NSString *row2Str, NSString *row3, NSString *row3Str) {
        [_planTimeBtnOutlet setTitle:row1Str forState:UIControlStateNormal];
    }];
    [_alertView showInView:self.view];
}

- (IBAction)confirmBtnDeleteAction:(id)sender {
    
    
}

- (IBAction)photoBtnAction:(id)sender {
    [_alertView setDataSource:photoStateArr withDataList2:nil withDataList3:nil withKey:nil cancelBlock:^{
        
    } sureBlock:^(NSString *row1, NSString *row1Str, NSString *row2, NSString *row2Str, NSString *row3, NSString *row3Str) {
        photoSate = row1;
        [_photoBtnOutlet setTitle:row1Str forState:UIControlStateNormal];
    }];
    [_alertView showInView:self.view];
}

- (IBAction)startTimeAction:(id)sender {
    [_alertView setDataSource:hourArr withDataList2:minuteArr withDataList3:nil withKey:nil cancelBlock:^{
        
    } sureBlock:^(NSString *row1, NSString *row1Str, NSString *row2, NSString *row2Str, NSString *row3, NSString *row3Str) {
        startTime = [NSString stringWithFormat:@"%@:%@",row1Str,row2Str];
        [_startTimeButOutlet setTitle:startTime forState:UIControlStateNormal];
    }];
    [_alertView showInView:self.view];
}
@end
