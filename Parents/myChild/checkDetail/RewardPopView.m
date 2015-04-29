//
//  RewardPopView.m
//  Parents
//
//  Created by kfd on 14-11-11.
//  Copyright (c) 2014年 qzz. All rights reserved.
//

#import "RewardPopView.h"

@interface RewardPopView(){
    NSArray *encourageArr;
    BOOL isExpansion;
    CGFloat scale;
    NSInteger starNum;
    NSString *ratingNote;
    NSInteger taskId;
}

@end

@implementation RewardPopView

+(void)showCheckDetailVCWithBlock:(void(^)(NSDictionary *dict))sccessBlock withVC:(UINavigationController *)vc{
    RewardPopView *rewardPopView = [[RewardPopView alloc] initWithSuccesBlock:sccessBlock];
    UIViewController *viewVc = [[UIViewController alloc] init];
    [viewVc.view addSubview:rewardPopView];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:viewVc];
    [vc.navigationController presentViewController:nav animated:YES completion:nil];
}

-(id)initWithSuccesBlock:(void(^)(NSDictionary *dict))successBlock
{
    self = [super init];
    if (self) {

    }
    return self;
}

-(void)initwithTaskId:(NSInteger)tid{
    taskId = tid;
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    _encourageNotePickerView.dataSource=self;
    _encourageNotePickerView.delegate=self;
    
    [self setBackgroundColor:[UIColor clearColor]];
    [_bottomView setBackgroundColor:[UIColor blackColor]];
    [_bottomView setAlpha:0.6];
    
    ViewBorderRadius(_encourageView, 5, 0.5, [UIColor grayColor]);
    
    isExpansion = NO;
    starNum = 0;
    
    encourageArr = @[@"和上次比有进步",@"鼓励短评2",@"鼓励短评3",@"鼓励短评4",@"鼓励短评5"];
}

-(instancetype)initWithFrame:(CGRect)frame{

    self = [[[NSBundle mainBundle] loadNibNamed:@"RewardPopView" owner:self options:nil]objectAtIndex:0];
    if (self) {
    }
    return self;
}

#pragma mark -- pickerView DataSource
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [encourageArr count];
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [encourageArr objectAtIndex:row];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{

    ratingNote = [NSString stringWithFormat:@"%ld",(long)row];
    [_selectValueTextField setText:[encourageArr objectAtIndex:row]];
    [CommonView animationWithPicker:NO andView:_dropdownList andSpacing:100];
    isExpansion = NO;
    [_encourageNotePickerView setHidden:YES];
}

//设置字体大小
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:[UIFont boldSystemFontOfSize:18]];
    }
    // Fill the label text here
    pickerLabel.text=[self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}

- (IBAction)commentDDLBtnAction:(id)sender {
    
    if (isExpansion) {
        [CommonView animationWithPicker:NO andView:_dropdownList andSpacing:100];
        isExpansion = NO;
        [_encourageNotePickerView setHidden:YES];
    }else{
        [CommonView animationWithPicker:YES andView:_dropdownList andSpacing:100];
        isExpansion = YES;
        [_encourageNotePickerView setHidden:NO];
    }
}

- (IBAction)cancleBtnAction:(id)sender {
    [self removeFromSuperview];
}

- (IBAction)addBtnAction:(id)sender {
    
    starNum ++;
    if (starNum > 5) {
        starNum = 5;
        [SVProgressHUD showErrorWithStatus:@"已达到顶级评价" duration:1];
        return;
    }
    [CommonView initWithRatingBar:starNum andView:_rankView];
}

- (IBAction)diffBtnAction:(id)sender {
    starNum --;
    if (starNum < 0) {
        starNum = 0;
    }
    NSArray *views = [_rankView subviews];
    for (UIView *v in views) {
        [v removeFromSuperview];
    }
    [CommonView initWithRatingBar:starNum andView:_rankView];
}

- (IBAction)sendBtnAction:(id)sender {
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:0];
    
    if ([ratingNote length] == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入评语" duration:1];
        return;
    }
    [dic setValue:[NSString stringWithFormat:@"%ld",(long)taskId] forKey:@"tid"];
    [dic setValue:[PC_Globle.shareUserDefaults valueForKey:@"uid_c"] forKey:@"uid"];
    [dic setValue:[NSString stringWithFormat:@"%ld",starNum] forKey:@"star_level"];
    [dic setValue:ratingNote forKey:@"comment"];
    
    __block NSDictionary *dicResult;
    
    [HTTPREQUEST requestWithPost:@"task/task_comment.php" requestParams:dic successBlock:^(NSData *data) {
        
        NSString *result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        if(![result isEqual:@"0"]){
            dicResult = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            NSLog(@"-------add success..%@",dicResult);
            [self removeFromSuperview];
            [[[CheckDetailVC alloc] init] initWithComment:dicResult];
        }
    } failedBlock:^(NSString *code, NSString *msg) {
        
    }];
}
@end
