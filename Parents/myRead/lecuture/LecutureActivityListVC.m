//
//  LecutureActivityListVC.m
//  Parents
//
//  Created by kfd on 14-11-13.
//  Copyright (c) 2014年 qzz. All rights reserved.
//

#import "LecutureActivityListVC.h"

@interface LecutureActivityListVC (){

    NSArray *headTitleArr;
    NSArray *lecutureTypeNameArr;
    UIColor *typeNameLblBgColor;
    NSArray *lecutureTitleArr;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation LecutureActivityListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setHidden:NO];
    headTitleArr = @[@"火热报名中",@"即将开启报名"];
    lecutureTypeNameArr = @[@"讲座",@"活动"];
    [self setBackButtonVisible:@"返回" andButtonFrame:NAVIGATION_RECT_MIN];
    self.navigationItem.title = @"我的讲座活动";
    lecutureTitleArr = @[@"最新报名",@"想参与的",@"曾经参与的"];
    
    _tableView.dataSource=self;
    _tableView.delegate=self;
}

#pragma mark -- dataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return [lecutureTitleArr objectAtIndex:section];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    static NSString *cellIdentiy = @"cellIdentity";
    LecutureActivityCell *lecutureCell = (LecutureActivityCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentiy];
    if (!lecutureCell) {
        lecutureCell = [[LecutureActivityCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentiy];
    }
    if([[lecutureTypeNameArr objectAtIndex:indexPath.row] isEqual:@"讲座"]){
        typeNameLblBgColor = [UIColor yellowColor];
    }
    if([[lecutureTypeNameArr objectAtIndex:indexPath.row] isEqual:@"活动"]){
        typeNameLblBgColor = [UIColor greenColor];
    }
    
//    [lecutureCell setDataSourceWithTypeName:[lecutureTypeNameArr objectAtIndex:indexPath.row] andDateTimeLbl:@"10月20日" andLecutureNameLbl:@"成为更好的父母系列之三" andActivityTimeLbl:@"活动时间:2014/10/25 from 9:00 to 17:00 活动费用:100/每人 活动地址:上海浦东" setTypeNameLblBackGroundColor:typeNameLblBgColor];
    return lecutureCell;

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
