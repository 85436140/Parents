//
//  MyCircleVC.m
//  Parents
//
//  Created by kfd on 14-11-10.
//  Copyright (c) 2014年 qzz. All rights reserved.
//

#import "MyCircleVC.h"

@interface MyCircleVC ()<UIAlertViewDelegate,UIScrollViewDelegate>{
    NSArray *groupNames;
    NSArray *headTitles;
    NSArray *friendsArr;
    NSArray *navTitles;
    NSInteger btnTag;
    
    UIImageView *animateLineIV;
}

@end

@implementation MyCircleVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setHidden:NO];
    [self setBackButtonVisible:@"首页" andButtonFrame:NAVIGATION_RECT_MIN];
    self.title = @"家校群";
    
    navTitles = @[@"家校群",@"我的好友"];
    groupNames = @[@"同班孩子家长",@"同级孩子家长"];
    headTitles = @[@"校内",@"校外"];
    friendsArr = @[@"张三",@"李四",@"王武"];
    
    animateLineIV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sliderline"]];
    [animateLineIV setFrame:CGRectMake(0, 1, SCREEN_WIDTH/2, 3)];
    [_bottomView addSubview:animateLineIV];
    [_myFriendsBtnOutlet.titleLabel setTextColor:[[UIColor alloc] initWithRed:154/255.0 green:154/255.0 blue:154/255.0 alpha:1]];
    
    [self setupPage];
}

#pragma mark -- dataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([tableView isEqual:_myFriendsTV]) {
        return [friendsArr count];
    }
    if ([tableView isEqual:_fsGroupTV]) {
        return [groupNames count];
    }
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentity = @"CellIdentity";
    if ([tableView isEqual:_myFriendsTV]) {
        FriendsCell *fridendsCell = (FriendsCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentity];
        if (!fridendsCell) {
            fridendsCell = [[FriendsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentity];
        }
        [fridendsCell setDataSourceWithHeadImg:[UIImage imageNamed:@"accout"] nickName:[friendsArr objectAtIndex:indexPath.row]
                                  note:@"呵呵，好啦有..."
                     comeInFriendSpace:^{
                         [self comeInFriendSpace];
                     }];
        return fridendsCell;
    }

    MyCircleCell *cell = (MyCircleCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentity];
    if (!cell) {
        cell = [[MyCircleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentity];
    }
    UIImage *headIcon = [UIImage imageNamed:[NSString stringWithFormat:@"jiazhang%ld",indexPath.row+1]];
    [cell setDataSourceWithHeadImage:headIcon andGroupNameLbl:[groupNames objectAtIndex:indexPath.row] andInfoCountLbl:nil setButtonTag:indexPath.row andComeInSpaceBlock:^(NSInteger bTag){
        [self comeInSapce:bTag];
    }];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

#pragma mark -- ScrollView
//改变滚动视图的方法实现
- (void)setupPage
{
    //设置取消触摸
    _mainScrollView.canCancelContentTouches = NO;
    //设置滚动条类型
    _mainScrollView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
    //是否自动裁切超出部分
    _mainScrollView.delegate=self;
    _mainScrollView.clipsToBounds = YES;
    //设置是否可以缩放
    _mainScrollView.scrollEnabled = YES;
    //设置是否可以进行画面切换
    _mainScrollView.pagingEnabled = YES;
    _mainScrollView.bounces=NO;
    //    //设置在拖拽的时候是否锁定其在水平或者垂直的方向
    //    _myScrollView.directionalLockEnabled = NO;
    //隐藏滚动条设置（水平、跟垂直方向）
    _mainScrollView.alwaysBounceHorizontal = NO;
    _mainScrollView.alwaysBounceVertical = NO;
    _mainScrollView.showsHorizontalScrollIndicator = NO;
    _mainScrollView.showsVerticalScrollIndicator = NO;
    //设置滚动视图的位置
    [_mainScrollView setContentSize:CGSizeMake(2*SCREEN_WIDTH, _mainScrollView.bounds.size.height)];
    [self initWithView];
}

-(void)initWithView{
    
    //家校群
    _fsGroupTV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, HEIGH(_mainScrollView))];
    _fsGroupTV.delegate = self;
    _fsGroupTV.dataSource = self;
    [_mainScrollView addSubview:_fsGroupTV];
    
    //我的好友
    _myFriendsTV = [[UITableView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, HEIGH(_mainScrollView))];
    _myFriendsTV.delegate = self;
    _myFriendsTV.dataSource = self;
    [_mainScrollView addSubview:_myFriendsTV];
}

//改变页码的方法实现
- (void)changePage:(id)sender
{
    //获取当前视图的页码
    CGRect rect = _mainScrollView.frame;
    //设置视图的横坐标，一幅图为320*460，横坐标一次增加或减少320像素
    rect.origin.x = _myPageControl.currentPage * _mainScrollView.frame.size.width;
    //设置视图纵坐标为0
    rect.origin.y = 0;
    //scrollView可视区域
    [_mainScrollView scrollRectToVisible:rect animated:YES];
    [_myPageControl setCurrentPageIndicatorTintColor:[UIColor greenColor]];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGPoint point = scrollView.contentOffset;
    NSInteger index = (NSUInteger)point.x/(NSUInteger)WIDTH(scrollView);
    self.title = [navTitles objectAtIndex:index];
    [animateLineIV setFrame:CGRectMake(index*SCREEN_WIDTH/2, 1, SCREEN_WIDTH/2, 3)];
}

-(void)comeInFriendSpace{
    ChatViewController *chatVc = [[ChatViewController alloc] initWithChatter:@"111111" isGroup:NO];
    [self.navigationController pushViewController:chatVc animated:YES];
}

-(void)comeInSapce:(NSInteger)bTag{

    NSString *classGroupId = [[PC_Globle shareUserDefaults] valueForKey:@"classGroupId"];
    NSString *grideGroupId = [[PC_Globle shareUserDefaults] valueForKey:@"grideGroupId"];
    ChatViewController *chatVc = [[ChatViewController alloc] initWithChatter:classGroupId isGroup:YES];
    ChatViewController *chatVc2 = [[ChatViewController alloc] initWithChatter:grideGroupId isGroup:YES];
    
    switch (bTag) {
        case 0:
            btnTag = bTag;
            if(classGroupId.length == 0){
                [self showAlert];
            }else{
                [self.navigationController pushViewController:chatVc animated:YES];
                chatVc.title = @"同班孩子家长";
                
                [[PC_Globle shareUserDefaults] setValue:@"c" forKey:@"groupType"];
            }
            break;
        case 1:
            btnTag = bTag;
            if(grideGroupId.length == 0){
                [self showAlert];
            }else{
                [self.navigationController pushViewController:chatVc2 animated:YES];
                chatVc2.title = @"同级孩子家长";
                [[PC_Globle shareUserDefaults] setValue:@"g" forKey:@"groupType"];
            }
            break;
    }
}

-(void)showAlert{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"尚未添加班级信息，是否完善信息" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    [alert show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex == 1){
        PersonInfoVC *personVc = [[PersonInfoVC alloc] initWithPersonInfo:btnTag];
        [self.navigationController pushViewController:personVc animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//视图滚动位置
-(void)viewScrollPoint:(NSInteger)bTag{
    [_mainScrollView setContentOffset:CGPointMake(bTag*WIDTH(_mainScrollView), 0) animated:YES];
}

- (IBAction)FSGroupBtnAction:(id)sender {
    [animateLineIV setFrame:CGRectMake(0, 1, SCREEN_WIDTH/2, 3)];
    [_FSGroupBtnOutlet.titleLabel setTextColor:[[UIColor alloc] initWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:1]];
    [_myFriendsBtnOutlet.titleLabel setTextColor:[[UIColor alloc] initWithRed:154/255.0 green:154/255.0 blue:154/255.0 alpha:1]];
    NSInteger index = [sender tag];
    [self viewScrollPoint:index];
    self.title = [navTitles objectAtIndex:index];;
}

- (IBAction)myFriendsBtnAction:(id)sender {
    [animateLineIV setFrame:CGRectMake(SCREEN_WIDTH/2, 1, SCREEN_WIDTH/2, 3)];
    [_myFriendsBtnOutlet.titleLabel setTextColor:[[UIColor alloc] initWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:1]];
    [_FSGroupBtnOutlet.titleLabel setTextColor:[[UIColor alloc] initWithRed:154/255.0 green:154/255.0 blue:154/255.0 alpha:1]];
    NSInteger index = [sender tag];
    [self viewScrollPoint:index];
    self.title = [navTitles objectAtIndex:index];
}
@end
