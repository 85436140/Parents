//
//  RewardSetVC.m
//  Parents
//
//  Created by kfd on 14-11-11.
//  Copyright (c) 2014年 qzz. All rights reserved.
//

#import "RewardSetVC.h"

@interface RewardSetVC ()
{
    NSMutableArray *awardList;
}
@end

@implementation RewardSetVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setHidden:NO];
    [self setBackButtonVisible:@"返回" andButtonFrame:NAVIGATION_RECT_MIN];
    self.navigationItem.title = @"奖励设置";
    [self requestData];
}

#pragma request Data
-(void)requestData{
    
    NSString *uid = [[PC_Globle shareUserDefaults] valueForKey:@"uid_p"];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:uid,@"uid",@"1",@"role", nil];
    [HTTPREQUEST requestWithPost:@"task/task_award_list.php" requestParams:dic successBlock:^(NSData *data) {
        NSError *error;
        NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        awardList = [[NSMutableArray alloc] init];
        if (!error) {
            for (NSDictionary *dict in array) {
                Award *award=[Award boundAwardDataWithdict:dict];
                [awardList addObject:award];
            }
        }
        [_awardTB reloadData];
        NSLog(@"=====count:%lu",(unsigned long)awardList.count);
    } failedBlock:^(NSString *code, NSString *msg) {
        
    }];
}

#pragma mark -- dataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return [awardList count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *cellIdetity = @"CellIdentity";
    tableView.showsVerticalScrollIndicator = NO;
    RewardSetCell *cell = (RewardSetCell *)[tableView dequeueReusableCellWithIdentifier:cellIdetity];
    if (!cell) {
        cell = [[RewardSetCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdetity];
    }
    Award *award = [awardList objectAtIndex:indexPath.row];
    [cell setDataSourceWithRewardDate:award goExchangeBlock:^(Award *award) {
        [self goExchangeAward:award];
    }];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)goExchangeAward:(Award *)award{

    HttpRequest *req = [[HttpRequest alloc] init];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:0];
    [dic setValue:[PC_Globle.shareUserDefaults valueForKey:@"uid_p"] forKey:@"uid"];
    [dic setValue:award.awardId forKey:@"award_id"];
    [dic setValue:award.condition forKey:@"factor"];
    [req requestWithPost:@"task/task_award_true.php" requestParams:dic successBlock:^(NSData *data) {
        NSString *result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        if(![result isEqual:@"0"]){
            NSLog(@"=====兑换积分成功======%@",result);
        }
    } failedBlock:^(NSString *code, NSString *msg) {
        
    }];

}

- (IBAction)addRewardBtnAction:(id)sender {
    [AddRewardVC showAddRewardWithSuccesBlock:^{
        [self requestData];
    } withController:self];
}
@end
