//
//  AddAchieveMent.h
//  Parents
//
//  Created by kfd on 14-11-14.
//  Copyright (c) 2014年 qzz. All rights reserved.
//

#import "PCBaseVC.h"
#import "CommonView.h"
#import "Subject.h"
#import "Score.h"
#import "CustomAlertView.h"
#import "SubjectCacheService.h"

@interface AddAchieveMentVC : PCBaseVC

@property (weak, nonatomic) IBOutlet UIButton *dateTimeBtnOutlet;
@property (weak, nonatomic) IBOutlet UIButton *confirmBtnOutlet;
@property (weak, nonatomic) IBOutlet UIButton *saveBtnOutlet;

@property (strong, nonatomic) Subject *subject;
@property (strong, nonatomic) Score *score;
@property (strong, nonatomic) CustomAlertView *alertView;
@property (weak, nonatomic) IBOutlet UITextField *scoreTF;
@property (weak, nonatomic) IBOutlet UITextField *avgScoreTF;
@property (weak, nonatomic) IBOutlet UITextField *sumScoreTF;

- (IBAction)dateTimeBtnAction:(id)sender;
- (IBAction)confirmBtnAction:(id)sender;
- (IBAction)saveBtnAction:(id)sender;

-(instancetype)initWithSubject:(Subject *)subject;
-(instancetype)initWithScore:(Score *)score whitIsEdit:(BOOL)isEdit;
+(void)showAchieveMentListWithBlock:(void(^)(void))successBlock withVC:(UIViewController *)viewController;
@end
