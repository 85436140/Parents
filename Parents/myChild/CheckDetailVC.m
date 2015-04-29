//
//  CheckDetailVC.m
//  Parents
//
//  Created by kfd on 14-11-11.
//  Copyright (c) 2014年 qzz. All rights reserved.
//

#import "CheckDetailVC.h"
#import "CommentCell.h"

@interface CheckDetailVC ()<ReFreshViewDelegate,UITableViewDelegate,UITableViewDataSource>
{
    NSInteger taskId;
    NSArray *encourageArr;
    NSDictionary *dic;
    
    NSString *costTime;
    NSString *restTime;
    NSInteger starLeval;
    NSString *rationgNote;
}
@end

@implementation CheckDetailVC

-(instancetype)initwithTaskId:(NSInteger)tid andTask:(Task *)task{
    taskId = tid;
    [[PC_Globle shareUserDefaults] setValue:[NSString stringWithFormat:@"%ld",taskId] forKey:@"taskId"];
    _task = task;
    return [super initWithNibName:@"CheckDetailVC" bundle:nil];
}

-(void)refreshView{
    [self requestData];
}

-(void)initWithComment:(NSDictionary *)dict{
    dic = dict;
    [self requestData];
    [_CommentTB reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setHidden:NO];
    [self setBackButtonVisible:@"返回" andButtonFrame:NAVIGATION_RECT_MIN];
    self.navigationItem.title = _task.taskName;
    
    ViewBorderRadius(_encourageView, 5, 0, [[UIColor alloc] initWithRed:255/255.0 green:205/255.0 blue:38/255.0 alpha:1]);
    
    encourageArr = @[@"和上次比有进步",@"鼓励短评2",@"鼓励短评3",@"鼓励短评4",@"鼓励短评5"];
}

#pragma request Data
-(void)requestData{
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithCapacity:0];
    [dict setValue:[[PC_Globle shareUserDefaults] valueForKey:@"uid_c"] forKey:@"uid"];
    [dict setValue:[[PC_Globle shareUserDefaults] valueForKey:@"taskId"] forKey:@"tid"];
    [dict setValue:@"1" forKey:@"role"];
    
    [HTTPREQUEST requestWithPost:@"task/task_completed_detail.php" requestParams:dict successBlock:^(NSData *data) {
        NSError *error;
        NSDictionary *dicResult = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        if (!error) {
            NSLog(@"---dicResult:%@",dicResult);
            dic = dicResult;
        }
    } failedBlock:^(NSString *code, NSString *msg) {}];
}

#pragma mark -- datasource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    [tableView setUserInteractionEnabled:NO];
    static NSString *cellIdentity = @"CellIdentity";
    CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentity];
    if (!cell) {
        cell = [[CommentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentity];
    }
    if(dic != nil){
        [cell setDataSourceWithComment:[dic valueForKey:@"star_level"] andComment:[encourageArr objectAtIndex:[dic[@"comment"] intValue]]];
    }else{
        [cell setDataSourceWithComment:_task.starLevel andComment:[encourageArr objectAtIndex:[_task.comment intValue]]];
    }
    return cell;
}

- (IBAction)encourangeBtnAction:(id)sender {
    
    RewardPopView *rewardPopView = [[[NSBundle mainBundle] loadNibNamed:@"RewardPopView" owner:self options:nil] objectAtIndex:0];
    [rewardPopView setFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [rewardPopView initwithTaskId:taskId];
    [self.view addSubview:rewardPopView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
