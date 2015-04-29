//
//  EductionBriefVC.m
//  Parents
//
//  Created by kfd on 14/11/15.
//  Copyright (c) 2014年 qzz. All rights reserved.
//

#import "EductionBriefVC.h"

@interface EductionBriefVC (){

    UIView *setView;
    BOOL isSet;
}

@end

@implementation EductionBriefVC

-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ViewBorderRadius(_setBtnOutlet, 5, 1, [UIColor blackColor]);
    ViewBorderRadius(_backBtnOutlet, 0, 1, [UIColor blackColor]);
    ViewBorderRadius(_praiseBtnOutlet, 0, 1, [UIColor blackColor]);
    ViewBorderRadius(_collectBtnOutlet, 0, 1, [UIColor blackColor]);
    ViewBorderRadius(_shareBtnOutlet, 0, 1, [UIColor blackColor]);
    ViewBorderRadius(_commentBtnOutlet, 0, 1, [UIColor blackColor]);
    isSet = YES;
    
//    _setFontSliderView.continuous = YES;
    [_setFontSliderView addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
}

-(void)sliderValueChanged:(UISlider *)sender{

    float value = sender.value;
    [_fontSizeTextView setFont:[UIFont systemFontOfSize:150*value]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)setBtnAction:(id)sender {
    
    if (isSet) {
        isSet = NO;
        [UIView animateWithDuration:0.5 animations:^{
            [_setFontSizeView setFrame:CGRectMake(0, Y(_headView)+95, SCREEN_WIDTH, 80)];
        }];
    }else{
        isSet = YES;
        [UIView animateWithDuration:0.5 animations:^{
            [_setFontSizeView setFrame:CGRectMake(0, Y(_setFontSizeView)-80, SCREEN_WIDTH, 80)];
        }];
    }
}

- (IBAction)backBtnAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)praiseBtnAction:(id)sender {
}

- (IBAction)collectBtnAction:(id)sender {
}

- (IBAction)shareBtnAction:(id)sender {
}

- (IBAction)commentBtnAction:(id)sender {
}
@end
