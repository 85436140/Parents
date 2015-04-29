//
//  CustomTwoViewController.m
//  P_Child
//
//  Created by David on 14/10/27.
//  Copyright (c) 2014年 kfd. All rights reserved.
//

#import "CustomTwoVC.h"
#import "TaskCacheService.h"

@interface CustomTwoVC ()
{
    BOOL *showPubulicList;
    BOOL *showList;
    BOOL isExpansion;
    
    NSArray *taskTipeArr;
    NSArray *photoSateArr;
    NSArray *planTimeArr;
    NSArray *hourArr;
    NSArray *minuteArr;
    
    NSString *isRemind;
    
    NSString *planTimeStr;
    NSString *hourStr;
    NSString *minuteStr;
    NSString *photoSate;
    NSString *taskType;
    NSString *startTimeStr;
}
@property (strong ,nonatomic) CustomAlertView *alertView;
@end

@implementation CustomTwoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    isExpansion = NO;
    isRemind = @"0";
    photoSate = @"0";
    taskType = @"0";
    
    [self setBackButtonVisible:@"返回" andButtonFrame:NAVIGATION_RECT_MIN];
    [self setNavRightBtn];
    
    photoSateArr = [NSArray arrayWithObjects:@"不拍照",@"开始时",@"结束时",@"都要拍", nil];
    taskTipeArr =[NSArray arrayWithObjects:@"学习",@"运动",@"生活",@"才艺",@"阅读", nil];
    
     planTimeArr = @[@"00",@"05",@"10",@"15",@"20",@"25",@"30",@"35",@"40",@"45",@"50",@"55",@"60"];
     hourArr = @[@"00",@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23"];
     minuteArr = @[@"00",@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23",@"24",@"25",@"26",@"27",@"28",@"29",@"30",@"31",@"32",@"33",@"34",@"35",@"36",@"37",@"38",@"39",@"40",@"41",@"42",@"43",@"44",@"45",@"46",@"47",@"48",@"49",@"50",@"51",@"52",@"53",@"54",@"55",@"56",@"57",@"58",@"59"];
    
    _alertView = [[[NSBundle mainBundle] loadNibNamed:@"CustomAlertView" owner:self options:nil]objectAtIndex:0];
}

-(void)setNavRightBtn{

    UIButton *rightBtn = [PCBaseVC initWithBtn:@"确定" andBtnFrame:NAVIGATION_RECT_MIN];
    [rightBtn addTarget:self action:@selector(confirmAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
}

- (IBAction)onSwitch:(id)sender {
    
    [self touchesBegan:nil withEvent:nil];
    if ([sender isOn]) {
        [_setRemindTimeView setHidden:NO];
        [self animationWithAdd:YES];
        isRemind = @"1";
    }else{
        [_setRemindTimeView setHidden:YES];
        [self animationWithAdd:NO];
        isRemind = @"0";
    }
}

#pragma mark -- animate
//view展开、收缩动画
-(void)animationWithAdd:(BOOL)isAdd
{
    if (isAdd) {
        [UIView animateWithDuration:0.2 animations:^{
            [_startRemindView setFrame:CGRectMake(X(_startRemindView), Y(_startRemindView), WIDTH(_startRemindView), HEIGH(_startRemindView)+50)];
            [_bottomView setFrame:CGRectMake(X(_bottomView), Y(_bottomView)+50, WIDTH(_bottomView), HEIGH(_bottomView))];
        }];
    }
    else
    {
        [UIView animateWithDuration:0.2 animations:^{
            [_startRemindView setFrame:CGRectMake(X(_startRemindView), Y(_startRemindView), WIDTH(_startRemindView), HEIGH(_startRemindView)-50)];
            [_bottomView setFrame:CGRectMake(X(_bottomView), Y(_bottomView)-50, WIDTH(_bottomView), HEIGH(_bottomView))];
        }];
    }
}

-(void)confirmAction{
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:8];
    NSString *uid = [[PC_Globle shareUserDefaults] valueForKey:@"uid_c"];
    NSString *role = [[PC_Globle shareUserDefaults] valueForKey:@"role"];
    NSString *taskName = [_taskNameTF text];
    
    if (taskName.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入任务名称" duration:1];
        return;
    }
    __block NSString *name_type_id = [TaskCacheService QueryTaskTypeByTaskName:taskName andTaskType:taskType];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:0];
    [dict setValue:taskName forKey:@"task_name"];
    [dict setValue:taskType forKey:@"task_type"];
    
    if (name_type_id.length == 0) {
        [HTTPREQUEST requestWithPost:@"task/task_type_list.php" requestParams:dict successBlock:^(NSData *data) {
            if ([[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] != 0) {
                
                NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                NSLog(@"--------task_type_list success----%@",result);
                name_type_id = result[@"name_type_id"];
                [TaskCacheService insertTaskType:taskName andTaskType:[name_type_id intValue]];
            }
        } failedBlock:^(NSString *code, NSString *msg) {}];
    }
    
    [dic setValue:uid forKey:@"uid"];
    [dic setValue:name_type_id forKey:@"name_type_id"];
    [dic setValue:_planTimeBtnOutlet.titleLabel.text forKey:@"plan_time"];
    [dic setValue:isRemind forKey:@"needRemind"];
    [dic setValue:photoSate forKey:@"needPhoto"];
    [dic setValue:role forKey:@"role"];
    
    [HTTPREQUEST requestWithPost:@"task/task_add.php" requestParams:dic successBlock:^(NSData *data) {
        NSString *result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        if (![result isEqual:@"0"]) {
            NSLog(@"----tid:%@",result);
            [self dismissView];
        }
    } failedBlock:^(NSString *code, NSString *msg) {
        
    }];
}

- (IBAction)confirmAddBtnAction:(id)sender {
    [self confirmAction];
}

-(void)dismissView{
    NSArray *viewControlers=self.navigationController.viewControllers;
    [self.navigationController popToViewController:[viewControlers objectAtIndex:3] animated:YES];
}

- (IBAction)planTimeBtnAction:(id)sender {
    
    [self touchesBegan:nil withEvent:nil];
    [_alertView setDataSource:planTimeArr withDataList2:nil withDataList3:nil withKey:nil cancelBlock:^{
        
    } sureBlock:^(NSString *row1, NSString *row1Str, NSString *row2, NSString *row2Str, NSString *row3, NSString *row3Str) {
        planTimeStr = row1;
        [_planTimeBtnOutlet setTitle:row1Str forState:UIControlStateNormal];
    }];
    [_alertView showInView:self.view];

}

- (IBAction)photoBtnAction:(id)sender {
    [_alertView setDataSource:photoSateArr withDataList2:nil withDataList3:nil withKey:nil cancelBlock:^{
        
    } sureBlock:^(NSString *row1, NSString *row1Str, NSString *row2, NSString *row2Str, NSString *row3, NSString *row3Str) {
        photoSate = row1;
        [_photoBtnOutlet setTitle:row1Str forState:UIControlStateNormal];
    }];
    [_alertView showInView:self.view];
}

- (IBAction)taskTypeBtnAction:(id)sender {
    
    [self touchesBegan:nil withEvent:nil];
    [_alertView setDataSource:taskTipeArr withDataList2:nil withDataList3:nil withKey:nil cancelBlock:^{
        
    } sureBlock:^(NSString *row1, NSString *row1Str, NSString *row2, NSString *row2Str, NSString *row3, NSString *row3Str) {
        taskType = [NSString stringWithFormat:@"%d",[row1 intValue]+1];
        [_taskTypeBtnOutlet setTitle:row1Str forState:UIControlStateNormal];
    }];
    [_alertView showInView:self.view];
}

- (IBAction)startTimeBtnAction:(id)sender {
    [_alertView setDataSource:hourArr withDataList2:minuteArr withDataList3:nil withKey:nil cancelBlock:^{
        
    } sureBlock:^(NSString *row1, NSString *row1Str, NSString *row2, NSString *row2Str, NSString *row3, NSString *row3Str) {
        startTimeStr = [NSString stringWithFormat:@"%@:%@",row1Str,row2Str];
        [_startTimeBtnOutlet setTitle:startTimeStr forState:UIControlStateNormal];
    }];
    [_alertView showInView:self.view];
}

//隐藏键盘
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [[event allTouches] anyObject];
    if (![[touch view] isKindOfClass:[UITextField class]]) {
        [self.view endEditing:YES];
    }
    [super touchesBegan:touches withEvent:event];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
