//
//  ClassVC.m
//  Parents
//
//  Created by kfd on 15-1-6.
//  Copyright (c) 2015年 qzz. All rights reserved.
//

#import "ClassVC.h"
#import "ClassCell.h"

@interface ClassVC ()<UITableViewDelegate,UITableViewDataSource>{
    
    NSInteger rowCount;
    NSInteger cellCount;
    ClassInfo *_clsInfo;
    
    NSArray *grideArr1;
    NSArray *grideArr2;
    NSArray *grideArr3;
    
    NSMutableArray *gride1Arr;
    NSMutableArray *gride2Arr;
    NSMutableArray *gride3Arr;
    NSMutableArray *gride4Arr;
    NSMutableArray *gride5Arr;
    NSMutableArray *gride6Arr;
    NSMutableArray *gride7Arr;
    NSMutableArray *gride8Arr;
    NSMutableArray *gride9Arr;
    NSMutableArray *gride10Arr;
    NSMutableArray *gride11Arr;
    NSMutableArray *gride12Arr;
    
    NSArray *classGroupData;
}

@end

@implementation ClassVC

-(instancetype)initWithClass:(ClassInfo *)clsInfo{
    _clsInfo = clsInfo;
    return [super initWithNibName:@"ClassVC" bundle:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"选择班级";
    [self setBackButtonVisible:@"返回" andButtonFrame:NAVIGATION_RECT_MIN];
    
    grideArr1 = @[@"一年级",@"二年级",@"三年级",@"四年级",@"五年级",@"六年级"];
    grideArr2 = @[@"初一",@"初二",@"初三"];
    grideArr3 = @[@"高一",@"高二",@"高三"];
    
    gride1Arr = [[NSMutableArray alloc] initWithCapacity:0];
    gride2Arr = [[NSMutableArray alloc] initWithCapacity:0];
    gride3Arr = [[NSMutableArray alloc] initWithCapacity:0];
    gride4Arr = [[NSMutableArray alloc] initWithCapacity:0];
    gride5Arr = [[NSMutableArray alloc] initWithCapacity:0];
    gride6Arr = [[NSMutableArray alloc] initWithCapacity:0];
    gride7Arr = [[NSMutableArray alloc] initWithCapacity:0];
    gride8Arr = [[NSMutableArray alloc] initWithCapacity:0];
    gride9Arr = [[NSMutableArray alloc] initWithCapacity:0];
    gride10Arr = [[NSMutableArray alloc] initWithCapacity:0];
    gride11Arr = [[NSMutableArray alloc] initWithCapacity:0];
    gride12Arr = [[NSMutableArray alloc] initWithCapacity:0];
    
    [self requestClassData];
}

-(void)clearArray{
    for (NSMutableArray *arr in classGroupData) {
        [arr removeAllObjects];
    }
}

-(void)requestClassData{
    
    //清空数组
    [self clearArray];
    [HTTPREQUEST requestWithPost:@"user/school_class.php" requestParams:@{@"zid":_clsInfo.zone,@"sid":_clsInfo.school} successBlock:^(NSData *data) {
        NSString *resultCode = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        if (![resultCode isEqual:@"0"]) {
            NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            for (NSDictionary *dict in array) {
                ClassInfo *clsInfo = [ClassInfo boundDataWithClassInfo:dict];
                [self classGroupData:clsInfo];
            }
            classGroupData = @[gride1Arr,gride2Arr,gride3Arr,gride4Arr,gride5Arr,gride6Arr,gride7Arr,gride8Arr,gride9Arr,gride10Arr,gride11Arr,gride12Arr];
            [_classTB reloadData];
        }
    } failedBlock:^(NSString *code, NSString *msg) {}];
}

//处理班级分组数据
-(void)classGroupData:(ClassInfo *)clsInfo{

    switch ([clsInfo.grideId intValue]) {
        case 1:
            [gride1Arr addObject:clsInfo];
            break;
        case 2:
            [gride2Arr addObject:clsInfo];
            break;
        case 3:
            [gride3Arr addObject:clsInfo];
            break;
        case 4:
            [gride4Arr addObject:clsInfo];
            break;
        case 5:
            [gride5Arr addObject:clsInfo];
            break;
        case 6:
            [gride6Arr addObject:clsInfo];
            break;
        case 7:
            [gride7Arr addObject:clsInfo];
            break;
        case 8:
            [gride8Arr addObject:clsInfo];
            break;
        case 9:
            [gride9Arr addObject:clsInfo];
            break;
        case 10:
            [gride10Arr addObject:clsInfo];
            break;
        case 11:
            [gride11Arr addObject:clsInfo];
            break;
        case 12:
            [gride12Arr addObject:clsInfo];
            break;
    }
}

-(void)requestAddClass{

    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithCapacity:0];
    [dict setValue:_clsInfo.zone forKey:@"zid"];
    [dict setValue:_clsInfo.school forKey:@"sid"];
    [dict setValue:_clsInfo.gride forKey:@"gid"];
    [dict setValue:[NSString stringWithFormat:@"%@班",_clsInfo.cls] forKey:@"cname"];
    [HTTPREQUEST requestWithPost:@"user/create_class.php" requestParams:dict successBlock:^(NSData *data) {
        NSString *result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"------------classId:%@",result);
    } failedBlock:^(NSString *code, NSString *msg) {
        
    }];
}

#pragma mark -- datasource and delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if ([_clsInfo.schoolType isEqual:@"1"]) {
        return [grideArr1 count];
    }
    if ([_clsInfo.schoolType isEqual:@"2"]) {
        return [grideArr2 count];
    }
    if ([_clsInfo.schoolType isEqual:@"3"]) {
        return [grideArr3 count];
    }
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentity = @"CellIdentity";
    ClassCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentity];
    if (!cell) {
        cell = [[ClassCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentity];
    }
    NSArray *array;
    if ([_clsInfo.schoolType isEqual:@"1"]) {
        array = grideArr1;
    }
    if ([_clsInfo.schoolType isEqual:@"2"]) {
        array = grideArr2;
    }
    if ([_clsInfo.schoolType isEqual:@"3"]) {
        array = grideArr3;
    }
    NSString *gid = [NSString stringWithFormat:@"%ld",indexPath.row+1];
    [cell setDataSourceWithClass:[array objectAtIndex:indexPath.row] andClsId:gid andClassList:[classGroupData objectAtIndex:indexPath.row] andAddClassBlock:^(NSString *clsId) {

        if([clsId rangeOfString:@","].location != NSNotFound){
            NSArray *strArr = [clsId componentsSeparatedByString:@","];
            
            _clsInfo.gride = [strArr objectAtIndex:0];
            _clsInfo.cls = [strArr objectAtIndex:1];
            [self requestAddClass];
            [self requestClassData];
        }
    } andClassInfoBlock:^(NSInteger clsId,NSString *clsNum) {
        
        NSString *grideName;
        if ([_clsInfo.schoolType isEqual:@"1"]) {
            grideName = [grideArr1 objectAtIndex:indexPath.row];
        }
        if ([_clsInfo.schoolType isEqual:@"2"]) {
            grideName = [grideArr2 objectAtIndex:indexPath.row];
            _clsInfo.gride = [NSString stringWithFormat:@"%d",[_clsInfo.gride intValue]+6];
        }
        if ([_clsInfo.schoolType isEqual:@"3"]) {
            grideName = [grideArr3 objectAtIndex:indexPath.row];
            _clsInfo.gride = [NSString stringWithFormat:@"%d",[_clsInfo.gride intValue]+9];
        }
        
        _clsInfo.cls = [NSString stringWithFormat:@"%ld",clsId];
        _clsInfo.grideName = grideName;
        _clsInfo.className = clsNum;
        
        NSArray *vcArr = self.navigationController.viewControllers;
        for (int i = 0; i< vcArr.count; i++) {
            UIViewController *vc = [vcArr objectAtIndex:i];
            if ([vc isKindOfClass:[PersonInfoVC class]]) {
                [self.navigationController popToViewController:[vcArr objectAtIndex:i] animated:YES];
                return;
            }
        }
    }];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 500;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
