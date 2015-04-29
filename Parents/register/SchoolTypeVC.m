//
//  SchoolVC.m
//  Parents
//
//  Created by kfd on 15-1-6.
//  Copyright (c) 2015年 qzz. All rights reserved.
//

#import "SchoolTypeVC.h"
#import "CommoneCell.h"
#import "SchoolVC.h"

@interface SchoolTypeVC ()<UITableViewDelegate,UITableViewDataSource>{

    NSArray *shoolTypeList;
    ClassInfo *_clsInfo;
}

@end

@implementation SchoolTypeVC

-(instancetype)initWithSchoolType:(ClassInfo *)clsInfo{
    _clsInfo = clsInfo;
    return [super initWithNibName:@"SchoolTypeVC" bundle:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"选择学校类别";
    [self setBackButtonVisible:@"返回" andButtonFrame:NAVIGATION_RECT_MIN];
    shoolTypeList = @[@"小学",@"中学",@"高中"];
}

#pragma mark -- datasource and delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [shoolTypeList count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentity = @"CellIdentity";
    CommoneCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentity];
    if (!cell) {
        cell = [[CommoneCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentity];
    }
    NSString *rowid = [NSString stringWithFormat:@"%ld",indexPath.row+1];
    [cell setDataSource:[shoolTypeList objectAtIndex:indexPath.row] andId:rowid
     withComeInBtnBlock:^(NSString *idx) {
         _clsInfo.schoolType = rowid;
         SchoolVC *schoolVc = [[SchoolVC alloc] initWithSchool:_clsInfo];
         [self.navigationController pushViewController:schoolVc animated:YES];
     }];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
