//
//  AddAchieveMent.m
//  Parents
//
//  Created by kfd on 14-11-14.
//  Copyright (c) 2014年 qzz. All rights reserved.
//

#import "AddAchieveMentVC.h"

@interface AddAchieveMentVC (){

    NSArray *numArr;
    NSArray *sumScoreArr;
    NSArray *dateTimeArr;
    
    NSMutableArray *yearArr;
    NSMutableArray *monthArr;
    NSMutableArray *dayArr;
    
    NSString *subjectId;
    
    BOOL _isEdit;
}
@property (nonatomic,strong) void (^successBlock)();

@end

@implementation AddAchieveMentVC

-(instancetype)initWithSubject:(Subject *)subject{
    _subject = subject;
    return [super initWithNibName:@"AddAchieveMentVC" bundle:nil];
}

-(instancetype)initWithScore:(Score *)score whitIsEdit:(BOOL)isEdit{

    _score = score;
    _isEdit = isEdit;
    return [super initWithNibName:@"AddAchieveMentVC" bundle:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setBackButtonVisible:@"返回" andButtonFrame:NAVIGATION_RECT_MIN];
    
    if (_subject.subject.length != 0) {
        subjectId = _subject.subId;
        self.navigationItem.title = [NSString stringWithFormat:@"添加%@成绩",_subject.subject];
    }
    if (_score.subject.length != 0) {
        subjectId = [NSString stringWithFormat:@"%ld",_score.subId];
        self.navigationItem.title = [NSString stringWithFormat:@"修改%@成绩",_score.subject];
    }
    
    UIButton *rightBtn = [PCBaseVC initWithBtn:@"确定" andBtnFrame:NAVIGATION_RECT_MIN];
    [rightBtn addTarget: self action:@selector(comfirmAction) forControlEvents:UIControlEventTouchUpInside];
    [self setNavigationRightBtn:rightBtn];
    [self initData];
    numArr = @[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9"];
    
    _alertView = [[[NSBundle mainBundle] loadNibNamed:@"CustomAlertView" owner:self options:nil] objectAtIndex:0];
    
    if (_isEdit) {
        [_confirmBtnOutlet setHidden:YES];
        [_saveBtnOutlet setFrame:CGRectMake(X(_confirmBtnOutlet), Y(_confirmBtnOutlet), WIDTH(_confirmBtnOutlet), HEIGH(_confirmBtnOutlet))];
        [_saveBtnOutlet setHidden:NO];
        
        [_scoreTF setText:[NSString stringWithFormat:@"%ld",_score.score]];
        [_avgScoreTF setText:[NSString stringWithFormat:@"%.2f",_score.average]];
        [_sumScoreTF setText:[NSString stringWithFormat:@"%ld",_score.total]];
        [_dateTimeBtnOutlet setTitle:_score.examDate forState:UIControlStateNormal];
    }
}

-(void)initData{

    yearArr = [[NSMutableArray alloc] initWithCapacity:0];
    monthArr = [[NSMutableArray alloc] initWithCapacity:0];
    dayArr = [[NSMutableArray alloc] initWithCapacity:0];
    
    for (int i = 2010; i <= 2100; i++) {
        [yearArr addObject:[NSString stringWithFormat:@"%i",i]];
    }
    for (int i = 1; i <= 12; i++) {
        if (i < 10) {
            [monthArr addObject:[NSString stringWithFormat:@"%i",i]];
        }else{
            [monthArr addObject:[NSString stringWithFormat:@"%i",i]];
        }
    }
    for (int i = 1; i <= 31; i++) {
        if (i < 10) {
            [dayArr addObject:[NSString stringWithFormat:@"%i",i]];
        }else{
           [dayArr addObject:[NSString stringWithFormat:@"%i",i]];
        }
    }
}

+(void)showAchieveMentListWithBlock:(void(^)(void))successBlock withVC:(UIViewController *)viewController{

    AddAchieveMentVC *addAchieveMent = [[AddAchieveMentVC alloc] initWithSuccesBlock:successBlock];
    UINavigationController *navVc = [[UINavigationController alloc] initWithRootViewController:addAchieveMent];
    [viewController.navigationController presentViewController:navVc animated:YES completion:nil];
}

-(id)initWithSuccesBlock:(void(^)(void))successBlock
{
    self = [super init];
    if (self) {
        _successBlock = successBlock;
    }
    return self;
}

-(void)forwardToAchieveMentList{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    _successBlock();
}

-(void)comfirmAction{
    
    NSString *excuteMothed = @"";
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:0];
    NSString *uid = [[PC_Globle shareUserDefaults] valueForKey:@"uid_p"];
    if (_isEdit) {
        excuteMothed = @"score/score_edit.php";
        [dic setValue:[NSString stringWithFormat:@"%ld",_score.scoreId] forKey:@"score_id"];
    }else{
        excuteMothed = @"score/score_add.php";
        [dic setValue:uid forKey:@"uid"];
    }
    [dic setValue:[_scoreTF text] forKey:@"score"];
    [dic setValue:[_avgScoreTF text] forKey:@"average"];
    [dic setValue:[_sumScoreTF text] forKey:@"total"];
    [dic setValue:[_dateTimeBtnOutlet.titleLabel text] forKey:@"exam_date"];
    [dic setValue:subjectId forKey:@"sub_id"];
    
    [HTTPREQUEST requestWithPost:excuteMothed requestParams:dic
                    successBlock:^(NSData *data) {
        if (data != 0) {
             NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSLog(@"score_id::%@",[result valueForKey:@"score_id"]);
            [self.navigationController popViewControllerAnimated:YES];
        }
    } failedBlock:^(NSString *code, NSString *msg) {
                        
    }];
}

- (IBAction)confirmBtnAction:(id)sender {
    [self comfirmAction];
}

- (IBAction)saveBtnAction:(id)sender {
    [self comfirmAction];
}

- (IBAction)dateTimeBtnAction:(id)sender {
    [self touchesBegan:nil withEvent:nil];
    __block NSString *datetime;
    [_alertView setDataSource:yearArr withDataList2:monthArr withDataList3:dayArr withKey:nil cancelBlock:^{
        
    } sureBlock:^(NSString *row1, NSString *row1Str, NSString *row2, NSString *row2Str, NSString *row3, NSString *row3Str) {
        datetime = [NSString stringWithFormat:@"%@-%@-%@",row1Str,row2Str,row3Str];
        [_dateTimeBtnOutlet setTitle:datetime forState:UIControlStateNormal];
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
