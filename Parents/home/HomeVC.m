//
//  HomeVC.m
//  Parents
//
//  Created by kfd on 14-11-7.
//  Copyright (c) 2014年 qzz. All rights reserved.
//

#import "HomeVC.h"
#import "ZBarSDK.h"

@interface HomeVC ()<ZBarReaderDelegate>{

    NSString *uid_p;
    NSString *uid_c;
}

@end

@implementation HomeVC

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setHidden:YES];
    NSUserDefaults *user = [PC_Globle shareUserDefaults];
    uid_p = [user valueForKey:@"uid_p"];
    uid_c = [user valueForKey:@"uid_c"];
    
    if(IPHONE6){
        [_nameLbl setFrame:CGRectMake(X(_nameLbl), Y(_nameLbl)+15, WIDTH(_nameLbl), HEIGH(_nameLbl))];
        [_loginBtnOutlet setFrame:CGRectMake(X(_loginBtnOutlet), Y(_loginBtnOutlet)-30, WIDTH(_loginBtnOutlet), HEIGH(_loginBtnOutlet))];
    }
    
    if (uid_p.length != 0) {
        [_loginBtnOutlet setHidden:YES];
        [_loginHeadBtnOutlet setImage:[UIImage imageNamed:@"head"] forState:UIControlStateNormal];
        [_nameLbl setHidden:NO];
        NSString *real_name_p = [user valueForKey:@"real_name_p"];
        if(real_name_p.length != 0){
            [_nameLbl setText:real_name_p];
        }
    }
    NSLog(@"===%@===phone:%@",[user valueForKey:@"real_name_p"],[user valueForKey:@"phone"]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)forwardLoginVc{
    [LoginVC showLoginVCWithSuccesBlock:^{
        TaskMainVC *taskMainVc = [[TaskMainVC alloc] init];
        [self.navigationController pushViewController:taskMainVc animated:YES];
    } withController:self];
}

- (IBAction)loginHeadBtnAction:(id)sender {
    MeVC *meVc = [[MeVC alloc] init];
    [self.navigationController pushViewController:meVc animated:YES];
}

//登录
- (IBAction)loginBtnAction:(id)sender {
    [self forwardLoginVc];
}

- (IBAction)myChildBtnAction:(id)sender {
    if(uid_p.length == 0){
        [self forwardLoginVc];
        return;
    }
    if (uid_c.length == 0) {
        [self qrCode];
        return;
    }
    TaskMainVC *taskMainVc = [[TaskMainVC alloc] init];
    [self.navigationController pushViewController:taskMainVc animated:YES];
}

- (IBAction)childLoctionBtnAction:(id)sender {
    if(uid_p.length == 0){
        [self forwardLoginVc];
        return;
    }
    if (uid_c.length == 0) {
        [self qrCode];
        return;
    }
    ChildLocation *childLocation = [[ChildLocation alloc] init];
    [self.navigationController pushViewController:childLocation animated:YES];
}

- (IBAction)myReadBtnAction:(id)sender {
    MyReadMainVC *readVc = [[MyReadMainVC alloc] init];
    [self.navigationController pushViewController:readVc animated:YES];
}

- (IBAction)myCircleBtnAction:(id)sender {
    if(uid_p.length == 0){
        [self forwardLoginVc];
        return;
    }
    MyCircleVC *myCircle = [[MyCircleVC alloc] init];
    [self.navigationController pushViewController:myCircle animated:YES];
}

//二维码扫描
-(void)qrCode{
    ZBarReaderViewController *reader = [ZBarReaderViewController new];
    reader.readerDelegate = self;
    reader.supportedOrientationsMask = ZBarOrientationMaskAll;
    ZBarImageScanner *scanner = reader.scanner;
    [scanner setSymbology:ZBAR_I25
                   config:ZBAR_CFG_ENABLE
                       to:0];
    [self presentModalViewController:reader animated:YES];
}

-(void)imagePickerController:(UIImagePickerController*)reader didFinishPickingMediaWithInfo:(NSDictionary*)info
{
    id<NSFastEnumeration> results = [info objectForKey:ZBarReaderControllerResults];
    ZBarSymbol *symbol = nil;
    for(symbol in results)
        break;
    [reader dismissModalViewControllerAnimated:YES];
    
    NSString *code_key = symbol.data;
    NSLog(@"---------------------label.text:%@",code_key);
    if (![code_key isEqual:@"0"]) {
        [self requestLinkData:code_key];
    }
}

//P端关联C端数据
-(void)requestLinkData:(NSString *)codeKey{

    [HTTPREQUEST requestWithPost:@"user/code_p.php" requestParams:@{@"uid_p":uid_p,@"code_key":codeKey} successBlock:^(NSData *data) {
        NSString *resultCode = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        if (![resultCode isEqual:@"0"]) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSString *uidC = [dict valueForKey:@"uid_c"];
            if (uidC.length != 0) {
                [[PC_Globle shareUserDefaults] setValue:uidC forKey:@"uid_c"];
            }
        }
    } failedBlock:^(NSString *code, NSString *msg) {}];
}

- (IBAction)qrCodeBtnAction:(id)sender {
    [self qrCode];
}

@end
