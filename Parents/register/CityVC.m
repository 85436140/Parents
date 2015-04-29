//
//  CityVC.m
//  Parents
//
//  Created by kfd on 15-1-5.
//  Copyright (c) 2015年 qzz. All rights reserved.
//

#import "CityVC.h"
#import "ZoneVC.h"

@interface CityVC ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>{

    NSArray *cityList;
    ClassInfo *_clsInfo;
}

@end

@implementation CityVC

-(instancetype)initWithCity:(ClassInfo *)clsInfo{
    _clsInfo = clsInfo;
    return [super initWithNibName:@"CityVC" bundle:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"选择市/县";
    [self setBackButtonVisible:@"返回" andButtonFrame:NAVIGATION_RECT_MIN];
    
    [self requestCityData];
}

-(void)requestCityData{
    
    [HTTPREQUEST requestWithPost:@"user/user_province_city.php" requestParams:@{@"pid":_clsInfo.province} successBlock:^(NSData *data) {
        NSString *resultCode = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        if (![resultCode isEqual:@"0"]) {
            cityList = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        }
        [_cityTB reloadData];
    } failedBlock:^(NSString *code, NSString *msg) {}];
}

#pragma mark -- datasource and delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [cityList count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentity = @"CellIdentity";
    CommoneCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentity];
    if (!cell) {
        cell = [[CommoneCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentity];
    }
    NSDictionary *dict = [cityList objectAtIndex:indexPath.row];
    [cell setDataSource:[dict valueForKey:@"city"] andId:[dict valueForKey:@"cid"]
     withComeInBtnBlock:^(NSString *idx) {
         _clsInfo.city = idx;
         _clsInfo.cityName = [dict valueForKey:@"city"];
         ZoneVC *zoneVc = [[ZoneVC alloc] initWithZone:_clsInfo];
         [self.navigationController pushViewController:zoneVc animated:YES];
     }];
    return cell;
}

- (void)searchBtnAction{
    [HTTPREQUEST requestWithPost:@"user/city_search.php" requestParams:@{@"key_word":[_cityKeyWordTF text]} successBlock:^(NSData *data) {
        NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        if (cityList.count != 0){
            cityList = nil;
        }
        if(array.count != 0){
            cityList = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        }
        [_cityTB reloadData];
    } failedBlock:^(NSString *code, NSString *msg) {
        
    }];
}

//监听键盘搜索事件
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (_cityKeyWordTF.text.length != 0) {
        [self searchBtnAction];
    }else{
        [self requestCityData];
    }
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
