//
//  PCBaseVC.m
//  P_Child
//
//  Created by kfd on 14/10/29.
//  Copyright (c) 2014年 qzz. All rights reserved.
//

#import "PCBaseVC.h"

@interface PCBaseVC ()

@end

@implementation PCBaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    #ifdef __IPHONE_7_0
       if (isIOS7Above) {
           //这个属性属于UIExtendedEdge类型，它可以单独指定矩形的四条边，也可以单独指定、指定全部、全部不指定。
           //指定视图的哪条边需要扩展，不用理会操作栏的透明度。这个属性的默认值是UIRectEdgeAll。
           self.edgesForExtendedLayout = UIRectEdgeNone;
           //如果你使用了不透明的操作栏，设置edgesForExtendedLayout的时候也请将 extendedLayoutIncludesOpaqueBars的值设置为No（默认值是YES）
           self.extendedLayoutIncludesOpaqueBars = NO;
           //如果你不想让scroll view的内容自动调整，将这个属性设为NO（默认值YES）。
           self.automaticallyAdjustsScrollViewInsets = NO;
       }
    #endif
    
    //设置导航栏标题
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithCapacity:0];
    UIColor *color = [[UIColor alloc] initWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1];
    [dict setValue:color forKey:UITextAttributeTextColor];
    [dict setValue:[UIFont boldSystemFontOfSize:17] forKey:UITextAttributeFont];
    self.navigationController.navigationBar.titleTextAttributes = dict;
}

-(void)reloadView;
{
    [self.view setFrame:CGRectMake(0, 30+1, SCREEN_WIDTH, SCREEN_HEIGHT)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

+(UIButton *)initWithBtn:(NSString *)titleName andBtnFrame:(CGRect)btnFrame{
    UIColor *color = [[UIColor alloc] initWithRed:254/255.0 green:206/255.0 blue:194/255.0 alpha:1];
    UIButton *btn = [[UIButton alloc] initWithFrame:btnFrame];
    [btn setTitle:titleName forState:UIControlStateNormal];
    btn.titleLabel.textAlignment = NSTextAlignmentRight;
    [btn setTitleColor:color forState:UIControlStateNormal];
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, 30, 0, 0)];
    [btn.titleLabel setFont:[UIFont boldSystemFontOfSize:14]];
    [btn setShowsTouchWhenHighlighted:YES];
    return btn;
}

// 设置返回键
- (void)setBackButtonVisible:(NSString *)titleName andButtonFrame:(CGRect)buttonFrame{
    UIColor *color = [[UIColor alloc] initWithRed:254/255.0 green:206/255.0 blue:194/255.0 alpha:1];
    UIButton *backBtn = [[UIButton alloc] initWithFrame:buttonFrame];
    [backBtn setImage:[UIImage imageNamed:@"arrow_left"] forState:UIControlStateNormal];
    [backBtn setTitle:titleName forState:UIControlStateNormal];
    [backBtn setTitleColor:color forState:UIControlStateNormal];
    [backBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:14]];
    [backBtn setShowsTouchWhenHighlighted:YES];
    [backBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -20, 0, 0)];
    [backBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -20, 0, 0)];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    [backBtn addTarget:self action:@selector(bsBackBarClicked) forControlEvents:UIControlEventTouchUpInside];
}

//设置navigation左边button
-(void)setNavigationLeftBtn:(UIButton *)btn{
    UIBarButtonItem *leftBBItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    [self.navigationItem setLeftBarButtonItem:leftBBItem];
}

//设置navigation右边button
-(void)setNavigationRightBtn:(UIButton *)btn{
    UIBarButtonItem *rightBBItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    [self.navigationItem setRightBarButtonItem:rightBBItem];
}

//设置navigation标题
-(void)setNavigationTitle:(UILabel *)titleLbl{
    CGRect titleFrame = CGRectMake(0, 0, 100, 30);
    UIView *titleView = [[UIView alloc] initWithFrame:titleFrame];
    [titleView addSubview:titleLbl];
    self.navigationItem.titleView = titleView;
}

+(UIView *)customHeadView:(NSString *)headTitle{

    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    [headView setBackgroundColor:[[UIColor alloc] initWithRed:246/255.0 green:244/255.0 blue:246/255.0 alpha:1]];
    
    UIView *topLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
    [topLineView setBackgroundColor:[[UIColor alloc] initWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1]];
    [headView addSubview:topLineView];
    
    UIView *bottomLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 39, SCREEN_WIDTH, 1)];
    [bottomLineView setBackgroundColor:[[UIColor alloc] initWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1]];
    [headView addSubview:bottomLineView];
    
    UILabel *titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH, 40)];
    [titleLbl setFont:[UIFont boldSystemFontOfSize:15]];
    [titleLbl setTextColor:[UIColor grayColor]];
    [titleLbl setText:headTitle];
    [headView addSubview:titleLbl];
    return headView;
}

#pragma mark - Action Method
- (void)bsBackBarClicked{
    [self.view endEditing:YES];
    if (self.navigationController.viewControllers.count == 1) {
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
