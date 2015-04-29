//
//  ChoiceClassVC.m
//  Parents
//
//  Created by kfd on 14-12-31.
//  Copyright (c) 2014年 qzz. All rights reserved.
//

#import "ProvinceVC.h"
#import "CityVC.h"

@interface ProvinceVC ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    NSArray *provinceList;
}
@end

@implementation ProvinceVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"选择省市";
    [self setBackButtonVisible:@"返回" andButtonFrame:NAVIGATION_RECT_MIN];
    [self requestProvinceData];
}

-(void)requestProvinceData{

    [HTTPREQUEST requestWithPost:@"user/user_province.php" requestParams:nil successBlock:^(NSData *data) {
        NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        if (array.count != 0) {
            provinceList = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        }
        [_provinceTB reloadData];
    } failedBlock:^(NSString *code, NSString *msg) {}];
}

#pragma mark -- datasource and delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [provinceList count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *cellIdentity = @"CellIdentity";
    CommoneCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentity];
    if (!cell) {
        cell = [[CommoneCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentity];
    }
    NSDictionary *dict = [provinceList objectAtIndex:indexPath.row];
    [cell setDataSource:[dict valueForKey:@"province"] andId:[dict valueForKey:@"pid"]
     withComeInBtnBlock:^(NSString *idx) {
         ClassInfo *clsInfo = [ClassInfo shareClassInfo];
         clsInfo.province = idx;
         CityVC *cityVc = [[CityVC alloc] initWithCity:clsInfo];
         [self.navigationController pushViewController:cityVc animated:YES];
    }];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)searchBtnAction {
    [HTTPREQUEST requestWithPost:@"user/pro_search.php" requestParams:@{@"key_word":[_provinceKeyWordTF text]} successBlock:^(NSData *data) {
        NSString *resultCode = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        if (![resultCode isEqual:@"0"]) {
            provinceList = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        }
        [_provinceTB reloadData];
    } failedBlock:^(NSString *code, NSString *msg) {
        
    }];
}

//监听键盘搜索事件
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if(_provinceKeyWordTF.text.length != 0){
        [self searchBtnAction];
    }else{
        [self requestProvinceData];
    }
    return YES;
}

@end
