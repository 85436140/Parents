//
//  SubscriptionView.m
//  Parents
//
//  Created by kfd on 14/11/15.
//  Copyright (c) 2014年 qzz. All rights reserved.
//

#import "SubscriptionView.h"

@implementation SubscriptionView

-(void)awakeFromNib{
    
    UILabel *titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-SCREEN_WIDTH/4, 10, SCREEN_WIDTH/2*3, 20)];
    [titleLbl setText:@"选择需要订阅的栏目"];
    [titleLbl setFont:[UIFont boldSystemFontOfSize:18]];
    [self addSubview:titleLbl];
    
    _subScriptionTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH,SCREEN_HEIGHT-50)];
    [self addSubview:_subScriptionTableView];
    _subScriptionTableView.delegate = self;
    _subScriptionTableView.dataSource = self;
    
    UIButton *confirmBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/9, SCREEN_HEIGHT-80, SCREEN_WIDTH/5*4, 40)];
    [confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
    [confirmBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [confirmBtn setBackgroundColor:[UIColor purpleColor]];
    ViewBorderRadius(confirmBtn, 5, 1, [UIColor blackColor]);
    [confirmBtn addTarget:self action:@selector(confirmBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:confirmBtn];
}

-(instancetype)initWithFrame:(CGRect)frame{

    self = [[[NSBundle mainBundle] loadNibNamed:@"SubscriptionView" owner:self options:nil]objectAtIndex:0];
    if (self) {
       
    }
    return self;
}

#pragma mark -- dataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *cellIdentity = @"cellIdentity";
    SubscriptionCell *cell = (SubscriptionCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentity];
    if (!cell) {
        cell = [[SubscriptionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentity];
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 200;
}
-(void)confirmBtnClick{
    [self setHidden:YES];
}

@end
