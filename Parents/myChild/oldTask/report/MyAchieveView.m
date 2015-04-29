//
//  MyAchieveView.m
//  P_Child
//
//  Created by kfd on 14-11-3.
//  Copyright (c) 2014年 qzz. All rights reserved.
//

#import "MyAchieveView.h"

@interface MyAchieveView(){

    NSArray *medalArr;
    NSArray *titleArr;
    NSMutableArray *totalTimeArr;
    NSString *jifen;
    UILabel *titleView;
    UILabel *jifenLbl;
}

@end

@implementation MyAchieveView

-(instancetype)init{

    self = [[[NSBundle mainBundle] loadNibNamed:@"MyAchieveView" owner:self options:nil]objectAtIndex:0];
    if (self) {
        
    }
    return self;
}

-(void)awakeFromNib{

    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
    _myCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-145, 70, 320, 260) collectionViewLayout:layout];
    _myCollectionView.delegate = self;
    _myCollectionView.dataSource = self;
    [_myCollectionView setBackgroundColor:[UIColor whiteColor]];
    
    [self addSubview:_myCollectionView];
    [self.myCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"CollectionCell"];
    medalArr  = @[@"stydy",@"caiyi",@"jiawu",@"read",@"yule",@"sport"];
    titleArr = @[@"学有所成",@"多才多艺",@"家务能手",@"博览群书",@"游戏人生",@"运动健将"];
    totalTimeArr = [[NSMutableArray alloc] initWithCapacity:0];
    
    [self requestData];
//    [totalTimeArr addObject:@"0"];
//    [totalTimeArr addObject:@"100"];
//    [totalTimeArr addObject:@"500"];
//    [totalTimeArr addObject:@"1000"];
//    [totalTimeArr addObject:@"300"];
//    [totalTimeArr addObject:@"200"];
//    [self initView];
    [_jifenLbl setText:jifen];
}

//-(void)initView{
//
//    titleView = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-25, 20, 60, 30)];
//    [titleView setText:@"勋章馆"];
//    [titleView setTextColor:[[UIColor alloc] initWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1]];
//    [titleView setFont:[UIFont systemFontOfSize:15]];
//    [self addSubview:titleView];
//    
//    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-100, SCREEN_WIDTH, 30)];
//    [bottomView setBackgroundColor:[UIColor greenColor]];
//    [self addSubview:bottomView];
//    
//    UILabel *jifenNameLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-60, SCREEN_WIDTH, 30)];
//    [jifenNameLbl setText:@"小金库共有:"];
//    [jifenNameLbl setTextColor:[[UIColor alloc] initWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1]];
//    [jifenNameLbl setFont:[UIFont systemFontOfSize:15]];
//    [self addSubview:jifenNameLbl];
//    
//    jifenLbl = [[UILabel alloc] initWithFrame:CGRectMake(85, 5, 60, 20)];
//    [jifenLbl setText:[NSString stringWithFormat:@"%d枚金币",0]];
//    [jifenLbl setTextColor:[[UIColor alloc] initWithRed:255/255.0 green:0/255.0 blue:0/255.0 alpha:1]];
//    [jifenLbl setFont:[UIFont systemFontOfSize:15]];
//    [bottomView addSubview:jifenLbl];
//}

-(void)requestData{
    
    NSString *uid_c = [[PC_Globle shareUserDefaults] valueForKey:@"uid_c"];
    NSDictionary *dic = [NSDictionary dictionaryWithObject:uid_c forKey:@"uid"];
    [HTTPREQUEST requestWithPost:@"past/my_reflection.php" requestParams:dic successBlock:^(NSData *data){
        NSString *resultStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        if (![resultStr isEqual:@"0"]) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            jifen = [dict valueForKey:@"integral"];
            [totalTimeArr addObject:[dict valueForKey:@"study_total"]];
            [totalTimeArr addObject:[dict valueForKey:@"sports_total"]];
            [totalTimeArr addObject:[dict valueForKey:@"play_total"]];
            [totalTimeArr addObject:[dict valueForKey:@"life_total"]];
            [totalTimeArr addObject:[dict valueForKey:@"talent_total"]];
            [totalTimeArr addObject:[dict valueForKey:@"read_total"]];
        }
    } failedBlock:^(NSString *code, NSString *msg) {}];
}

-(NSString *)medalLeval:(NSInteger)rowId{

    NSString *totalTime = [totalTimeArr objectAtIndex:rowId];
    NSInteger time = [totalTime intValue];

    NSString *medalName;
    NSString *medalTypeName = [medalArr objectAtIndex:rowId];
   
    if (time == 0) {
        medalName = [NSString stringWithFormat:@"%@_no",medalTypeName];
    }
    if (time >= 100) {
        medalName = [NSString stringWithFormat:@"%@_bronze",medalTypeName];
    }
    if (time >= 500) {
        medalName = [NSString stringWithFormat:@"%@_silver",medalTypeName];
    }
    if (time >= 1000) {
        medalName = [NSString stringWithFormat:@"%@_gold",medalTypeName];
    }
    return medalName;
}

#pragma mark -- collectionView datasource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [medalArr count];
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentity = @"CollectionCell";
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentity forIndexPath:indexPath];
    for (UIView *view in cell.contentView.subviews) {
        if (view) {
            [view removeFromSuperview];
        }
    }
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
    NSString *imgName = [self medalLeval:indexPath.row];
    imgView.image = [UIImage imageNamed:imgName];
    UILabel *titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 70, 100, 20)];
    [titleLbl setText:[titleArr objectAtIndex:indexPath.row]];
    [titleLbl setTextColor:[[UIColor alloc] initWithRed:210/255.0 green:210/255.0 blue:210/255.0 alpha:1]];
    if (![[totalTimeArr objectAtIndex:indexPath.row] isEqual:@"0"]) {
        [titleLbl setTextColor:[[UIColor alloc] initWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1]];
    }
    [titleLbl setFont:[UIFont systemFontOfSize:15]];
    [cell.contentView addSubview:titleLbl];
    [cell.contentView addSubview:imgView];
    if (indexPath.row > 2) {
        [imgView setFrame:CGRectMake(0, 50, 60, 60)];
        [titleLbl setFrame:CGRectMake(0, 100, 100, 60)];
    }
    return  cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(90,90);
}

@end
