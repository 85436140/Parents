//
//  PersonInfoVC.m
//  Parents
//
//  Created by kfd on 14-12-15.
//  Copyright (c) 2014年 qzz. All rights reserved.
//

#import "PersonInfoVC.h"
#import "CustomAlertView.h"
#import "ClassInfoCacheService.h"

@interface PersonInfoVC ()<UIPickerViewDelegate,UIPickerViewDataSource>{

    BOOL isCheckedParentSex;
    BOOL isCheckedChildSex;
    BOOL isRegisterIMGroup;
    BOOL isExpansion;
    
    //data
    NSArray *yearArr;
    NSArray *monthArr;
    NSArray *dayArr;
    
    NSArray *roleArr;
    
    //birthday
    NSString *birthday;
    NSString *year;
    NSString *month;
    NSString *day;
    
    NSString *_grideGroupId;
    NSString *_classGroupId;
    NSString *roles;
    
    ClassInfo *_clsInfo;
    
    NSInteger _groupType;
    
}
@property (nonatomic,strong) CustomAlertView *alertView;

@end

@implementation PersonInfoVC

-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    _clsInfo = [ClassInfo shareClassInfo];
    if(_clsInfo.grideName.length != 0 && _clsInfo.className.length != 0){
        NSString *clsInfoStr = [NSString stringWithFormat:@"%@%@%@",_clsInfo.schoolName,_clsInfo.grideName,_clsInfo.className];
        NSLog(@"------==clsInfoStr:%@",clsInfoStr);
        [_addClassBtnOutlet setImage:nil forState:UIControlStateNormal];
        [_addClassBtnOutlet setTitle:clsInfoStr forState:UIControlStateNormal];
    }
}

-(instancetype)initWithPersonInfo:(NSInteger)groupType{
    _groupType = groupType;
    return [super initWithNibName:@"PersonInfoVC" bundle:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setBackButtonVisible:@"返回" andButtonFrame:NAVIGATION_RECT_MIN];
    
    self.navigationItem.title = @"填写信息";
    
    isCheckedParentSex = NO;
    isCheckedChildSex = NO;
    isRegisterIMGroup = YES;
    isExpansion = NO;
    
    UIButton *rightBtn = [PCBaseVC initWithBtn:@"完成" andBtnFrame:NAVIGATION_RECT_MIN];
    [rightBtn addTarget:self action:@selector(addPersonInfo) forControlEvents:UIControlEventTouchUpInside];
    [self setNavigationRightBtn:rightBtn];
    
    yearArr = @[@"1990",@"1991",@"1992",@"1993",@"1994",@"1995",@"1996",@"1997",@"1998",@"1999",@"2000",@"2001",@"2002",@"2003",@"2004",@"2005",@"2006"];
    monthArr = @[@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"10",@"11",@"12"];
    dayArr = @[@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"10",@"11",@"12",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23",@"24",@"25",@"26",@"27",@"28",@"29",@"30",@"31"];
    
    roleArr = @[@"爸爸",@"妈妈"];
    
    year = [yearArr objectAtIndex:0];
    month = [monthArr objectAtIndex:0];
    day = [dayArr objectAtIndex:0];

    [ClassInfoCacheService insertClassInfo];
    _alertView = [[[NSBundle mainBundle] loadNibNamed:@"CustomAlertView" owner:self options:nil]objectAtIndex:0];
}

#pragma mark -- pickerView DataSource and delegate
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [roleArr count];
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [roleArr objectAtIndex:row];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    roles = [roleArr objectAtIndex:row];
    [_roleTF setText:roles];
    [CommonView animationWithPicker:NO andView:_ddlView andSpacing:100];
    isExpansion = NO;
    [_rolePV setHidden:YES];    
}

//添加个人信息
- (IBAction)finishedBtnAction:(id)sender {
    [self addPersonInfo];
    ChatViewController *chatVc;
    if (_groupType == 0) {
        chatVc = [[ChatViewController alloc] initWithChatter:_classGroupId isGroup:YES];
        chatVc.title = @"同班孩子家长";
        [[PC_Globle shareUserDefaults] setValue:@"c" forKey:@"groupType"];
    }else{
        chatVc = [[ChatViewController alloc] initWithChatter:_grideGroupId isGroup:YES];
        chatVc.title = @"同级孩子家长";
        [[PC_Globle shareUserDefaults] setValue:@"g" forKey:@"groupType"];
    }
    [self.navigationController pushViewController:chatVc animated:YES];
}

-(void)addPersonInfo{

    HttpRequest *req = [[HttpRequest alloc] init];
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:0];
    NSString *real_name_P = [_uname_PTF text];
    NSString *real_name_C = [_uname_CTF text];
    NSString *role = [_roleTF text];
    
    if ([real_name_P isEqual:@""]) {
        [SVProgressHUD showErrorWithStatus:@"请输入真实姓名" duration:1];
        return;
    }
    if ([real_name_C isEqual:@""]) {
        [SVProgressHUD showErrorWithStatus:@"请输入孩子真实姓名" duration:1];
        return;
    }
    if ([role isEqual:@""]) {
        [SVProgressHUD showErrorWithStatus:@"请输入角色" duration:1];
        return;
    }
    
    NSInteger sex_p = 2;
    NSInteger sex_c = 1;
    if (isCheckedParentSex) {
        sex_p = 1;
    }
    
    if (isCheckedChildSex) {
        sex_c = 2;
    }
    
    [dic setValue:role forKey:@"rel"];
    [dic setValue:[[PC_Globle shareUserDefaults] valueForKey:@"role"] forKey:@"role"];
    [dic setValue:real_name_P forKey:@"real_name_p"];
    [dic setValue:real_name_C forKey:@"real_name_c"];
    [dic setValue:[NSString stringWithFormat:@"%ld",sex_p] forKey:@"sex_p"];
    [dic setValue:[NSString stringWithFormat:@"%ld",sex_c] forKey:@"sex_c"];
    [dic setValue:[_birthdayBtnOutlet.titleLabel text] forKey:@"birth"];
    [dic setValue:_clsInfo.province forKey:@"pid"];
    [dic setValue:_clsInfo.city forKey:@"cid"];
    [dic setValue:_clsInfo.zone forKey:@"zid"];
    [dic setValue:_clsInfo.school forKey:@"sid"];
    [dic setValue:_clsInfo.schoolType forKey:@"school_type"];
    [dic setValue:[[PC_Globle shareUserDefaults] valueForKey:@"uid_c"] forKey:@"uid_c"];
    [dic setValue:[[PC_Globle shareUserDefaults] valueForKey:@"regist_uid_p"] forKey:@"uid_p"];
    [dic setValue:_clsInfo.gride forKey:@"gid"];
    [dic setValue:_clsInfo.cls forKey:@"class_id"];
    
    [req requestWithPost:@"user/user_addInfo.php" requestParams:dic successBlock:^(NSData *data) {
        if ([[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] != 0) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            if ([[dict valueForKey:@"group_gid"] isEqualToString:@""]) {
                isRegisterIMGroup = NO;
            }
            NSUserDefaults *user = [PC_Globle shareUserDefaults];
            _grideGroupId = [dict valueForKey:@"to_groupGid"];
            _classGroupId = [dict valueForKey:@"to_groupClassId"];
            [user setValue:_grideGroupId forKey:@"grideGroupId"];
            [user setValue:_classGroupId forKey:@"classGroupId"];
            [user setValue:[dic valueForKey:@"real_name_p"] forKey:@"real_name_p"];
            [user setValue:[dic valueForKey:@"real_name_c"] forKey:@"real_name_c"];
            [user setValue:[dic valueForKey:@"group_gid"] forKey:@"group_gid"];
            [user setValue:[dic valueForKey:@"group_classid"] forKey:@"group_classid"];
            [user setValue:[dic valueForKey:@"sex_p"] forKey:@"sex_p"];
            [user setValue:[dic valueForKey:@"sex_c"] forKey:@"sex_c"];
            NSLog(@"----user_addInfo success-----%@",dict);
        }
    } failedBlock:^(NSString *code, NSString *msg) {
        
    }];
}

//出生日期
- (IBAction)birthdayBtnAction:(id)sender {
    
    [self touchesBegan:nil withEvent:nil];
    [_alertView setDataSource:yearArr withDataList2:monthArr withDataList3:dayArr withKey:nil cancelBlock:^{
        
    } sureBlock:^(NSString *row1, NSString *row1Str, NSString *row2, NSString *row2Str, NSString *row3, NSString *row3Str) {
        birthday = [NSString stringWithFormat:@"%@-%@-%@",row1Str,row2Str,row3Str];
        [_birthdayBtnOutlet setTitle:birthday forState:UIControlStateNormal];
    }];
    [_alertView showInView:self.view];
}

- (IBAction)pMaleBtnAction:(id)sender {
    [self touchesBegan:nil withEvent:nil];
    if (isCheckedParentSex) {
        [_pMaleBtnOutlet setImage:[UIImage imageNamed:@"radiobutton.png"] forState:UIControlStateNormal];
        [_pFemaleBtnOutlet setImage:[UIImage imageNamed:@"radiobutton_outline.png"] forState:UIControlStateNormal];
        isCheckedParentSex = NO;
    }
}

- (IBAction)pFemaleBtnAction:(id)sender {
    [self touchesBegan:nil withEvent:nil];
    if (!isCheckedParentSex) {
        [_pFemaleBtnOutlet setImage:[UIImage imageNamed:@"radiobutton.png"] forState:UIControlStateNormal];
        [_pMaleBtnOutlet setImage:[UIImage imageNamed:@"radiobutton_outline.png"] forState:UIControlStateNormal];
        isCheckedParentSex = YES;
    }
}

- (IBAction)cMaleBtnAction:(id)sender {
    [self touchesBegan:nil withEvent:nil];
    if (isCheckedChildSex) {
        [_cMaleBtnOutlet setImage:[UIImage imageNamed:@"radiobutton.png"] forState:UIControlStateNormal];
        [_cFemaleBtnOutlet setImage:[UIImage imageNamed:@"radiobutton_outline.png"] forState:UIControlStateNormal];
        isCheckedChildSex = NO;
    }
}

- (IBAction)cFemaleBtnAction:(id)sender {
    [self touchesBegan:nil withEvent:nil];
    if (!isCheckedChildSex) {
        [_cFemaleBtnOutlet setImage:[UIImage imageNamed:@"radiobutton.png"] forState:UIControlStateNormal];
        [_cMaleBtnOutlet setImage:[UIImage imageNamed:@"radiobutton_outline.png"] forState:UIControlStateNormal];
        isCheckedChildSex = YES;
    }
}

- (IBAction)addClassBtnAction:(id)sender {
    ProvinceVC *provinceVc = [[ProvinceVC alloc] init];
    [self.navigationController pushViewController:provinceVc animated:YES];
}

- (IBAction)roleDDL:(id)sender {
    [self touchesBegan:nil withEvent:nil];
    if (isExpansion) {
        [CommonView animationWithPicker:NO andView:_ddlView andSpacing:100];
        isExpansion = NO;
        [_rolePV setHidden:YES];
    }else{
        [CommonView animationWithPicker:YES andView:_ddlView andSpacing:100];
        isExpansion = YES;
        [_rolePV setHidden:NO];
    }
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
}

@end
