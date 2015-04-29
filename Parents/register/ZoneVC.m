//
//  ZoneVC.m
//  Parents
//
//  Created by kfd on 15-1-6.
//  Copyright (c) 2015年 qzz. All rights reserved.
//

#import "ZoneVC.h"
#import "CommoneCell.h"
#import "SchoolTypeVC.h"

@interface ZoneVC ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>{

    ClassInfo *_clsInfo;
    
    NSArray *zoneList;
}

@end

@implementation ZoneVC

-(instancetype)initWithZone:(ClassInfo *)clsInfo{
    _clsInfo = clsInfo;
    return [super initWithNibName:@"ZoneVC" bundle:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"选择区";
    [self setBackButtonVisible:@"返回" andButtonFrame:NAVIGATION_RECT_MIN];
    [self requestZoneData];
}

-(void)requestZoneData{
    
    [HTTPREQUEST requestWithPost:@"user/user_city_zone.php" requestParams:@{@"cid":_clsInfo.city} successBlock:^(NSData *data) {
        NSString *resultCode = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        if (zoneList.count != 0) {
            zoneList = nil;
        }
        if (![resultCode isEqual:@"0"]) {
            zoneList = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        }
        [_zoneTB reloadData];
    } failedBlock:^(NSString *code, NSString *msg) {}];
}

#pragma mark -- datasource and delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [zoneList count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentity = @"CellIdentity";
    CommoneCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentity];
    if (!cell) {
        cell = [[CommoneCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentity];
    }
    NSDictionary *dict = [zoneList objectAtIndex:indexPath.row];
    [cell setDataSource:[dict valueForKey:@"zone"] andId:[dict valueForKey:@"zid"]
     withComeInBtnBlock:^(NSString *idx) {
         _clsInfo.zone = idx;
         SchoolTypeVC *schoolVc = [[SchoolTypeVC alloc] initWithSchoolType:_clsInfo];
         [self.navigationController pushViewController:schoolVc animated:YES];
     }];
    return cell;
}

- (void)searchBtnAction {
    [HTTPREQUEST requestWithPost:@"user/zone_search.php" requestParams:@{@"key_word":[_zoneKeyWordTF text]} successBlock:^(NSData *data) {
        NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        if (zoneList.count != 0) {
            zoneList = nil;
        }
        if(array.count != 0){
            zoneList = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        }
        [_zoneTB reloadData];
    } failedBlock:^(NSString *code, NSString *msg) {
        
    }];
}

//监听键盘搜索事件
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (_zoneKeyWordTF.text.length != 0) {
        [self searchBtnAction];
    }else{
        [self requestZoneData];
    }
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
