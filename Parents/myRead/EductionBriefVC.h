//
//  EductionBriefVC.h
//  Parents
//
//  Created by kfd on 14/11/15.
//  Copyright (c) 2014年 qzz. All rights reserved.
//

#import "PCBaseVC.h"

@interface EductionBriefVC : PCBaseVC

@property (weak, nonatomic) IBOutlet UIButton *setBtnOutlet;
@property (weak, nonatomic) IBOutlet UIButton *backBtnOutlet;
@property (weak, nonatomic) IBOutlet UIButton *praiseBtnOutlet;
@property (weak, nonatomic) IBOutlet UIButton *collectBtnOutlet;
@property (weak, nonatomic) IBOutlet UIButton *shareBtnOutlet;
@property (weak, nonatomic) IBOutlet UIButton *commentBtnOutlet;

@property (weak, nonatomic) IBOutlet UIView *headView;
@property (weak, nonatomic) IBOutlet UIView *setFontSizeView;
@property (strong, nonatomic) IBOutlet UISlider *setFontSliderView;
@property (weak, nonatomic) IBOutlet UITextView *fontSizeTextView;

- (IBAction)setBtnAction:(id)sender;
- (IBAction)backBtnAction:(id)sender;
- (IBAction)praiseBtnAction:(id)sender;
- (IBAction)collectBtnAction:(id)sender;
- (IBAction)shareBtnAction:(id)sender;
- (IBAction)commentBtnAction:(id)sender;

@end
