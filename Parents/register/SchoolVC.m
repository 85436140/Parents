//
//  SchoolVC.m
//  Parents
//
//  Created by kfd on 15-1-6.
//  Copyright (c) 2015年 qzz. All rights reserved.
//

#import "SchoolVC.h"
#import "CommoneCell.h"
#import "ClassVC.h"

@interface SchoolVC ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>{

    ClassInfo *_clsInfo;
    
    NSArray *schoolList;
}

@end

@implementation SchoolVC

-(instancetype)initWithSchool:(ClassInfo *)clsInfo{
    _clsInfo = clsInfo;
    return [super initWithNibName:@"SchoolVC" bundle:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"选择学校";
    [self setBackButtonVisible:@"返回" andButtonFrame:NAVIGATION_RECT_MIN];
    
    [self requestSchoolData];
}

-(void)requestSchoolData{
    
    [HTTPREQUEST requestWithPost:@"user/user_zone_school.php" requestParams:@{@"zid":_clsInfo.zone,@"school_type":_clsInfo.schoolType} successBlock:^(NSData *data) {
        NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        if (array.count != 0) {
            schoolList = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        }
        [_schoolTB reloadData];
    } failedBlock:^(NSString *code, NSString *msg) {}];
}

#pragma mark -- datasource and delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [schoolList count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentity = @"CellIdentity";
    CommoneCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentity];
    if (!cell) {
        cell = [[CommoneCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentity];
    }
    NSDictionary *dict = [schoolList objectAtIndex:indexPath.row];
    [cell setDataSource:[dict valueForKey:@"school"] andId:[dict valueForKey:@"sid"] withComeInBtnBlock:^(NSString *idx) {
        _clsInfo.school = idx;
        _clsInfo.schoolName = [dict valueForKey:@"school"];
        ClassVC *clsVc = [[ClassVC alloc] initWithClass:_clsInfo];
        [self.navigationController pushViewController:clsVc animated:YES];
     }];
    return cell;
}

- (void)searchBtnAction {
    [HTTPREQUEST requestWithPost:@"user/school_search.php" requestParams:@{@"key_word":[_schoolKeyWordTF text]} successBlock:^(NSData *data) {
        NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        if (schoolList.count != 0) {
            schoolList = nil;
        }
        if(array.count != 0){
            schoolList = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        }
        [_schoolTB reloadData];
    } failedBlock:^(NSString *code, NSString *msg) {
        
    }];
}

//监听键盘搜索事件
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (_schoolKeyWordTF.text.length != 0) {
        [self searchBtnAction];
    }else{
        [self requestSchoolData];
    }
    return YES;
}

-(void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

@end
