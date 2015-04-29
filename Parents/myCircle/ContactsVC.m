//
//  ContactsVC.m
//  Parents
//
//  Created by kfd on 14-11-13.
//  Copyright (c) 2014年 qzz. All rights reserved.
//

#import "ContactsVC.h"

@interface ContactsVC ()
{
    NSArray *friendsArr;
    NSArray *charIndexArr;
}
@end

@implementation ContactsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setBackButtonVisible:@"返回" andButtonFrame:NAVIGATION_RECT_MIN];
    self.navigationItem.title = @"我的好友";
    friendsArr = @[@"张三",@"李四",@"王武"];
    charIndexArr = @[@"A",@"B",@"C"];
    ViewBorderRadius(_searchBtnOutlet, 5, 1, [UIColor blackColor]);
    ViewBorderRadius(_ignoreBtnOutlet, 5, 1, [UIColor blackColor]);
    ViewBorderRadius(_acceptBtnOutlet, 5, 1, [UIColor blackColor]);
}

#pragma mark -- tableView Datasource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [charIndexArr count];
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return [charIndexArr objectAtIndex:section];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentify = @"CellIdentify";
    FriendsCell *cell = (FriendsCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (cell == nil) {
        
        cell = [[FriendsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
    }
    
    [cell setDataSourceWithHeadImg:[UIImage imageNamed:@"accout"] nickName:[friendsArr objectAtIndex:indexPath.row]
                              note:@""
                 comeInFriendSpace:^{
                     [self comeInFriendSpace];
                 }];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"--------------:%ld",(long)indexPath.row);
}

-(void)comeInFriendSpace{
    
    SpaceListVC *friendsSpaceVC = [[SpaceListVC alloc] init];
    [self.navigationController pushViewController:friendsSpaceVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)searchBtnAction:(id)sender {
}
- (IBAction)ignoreBtnAction:(id)sender {
}
- (IBAction)acceptBtnAction:(id)sender {
}
@end
