//
//  DailyTaskCellTableViewCell.h
//  P_Child
//
//  Created by kfd on 14-11-5.
//  Copyright (c) 2014年 qzz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DailyTaskCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *addTaskBtnOutlet;
@property (weak, nonatomic) IBOutlet UILabel *taskNameLbl;
@property (weak, nonatomic) IBOutlet UIImageView *taskImage;
@property (weak, nonatomic) IBOutlet UILabel *timeLbl;
@property (weak, nonatomic) IBOutlet UIButton *checkTaskBtnOutlet;

@property (nonatomic, copy) void (^addDailyTaskBlock)(NSInteger btag);
@property (nonatomic, copy) void (^checkDailyTaskBlock)(NSInteger btag);

- (IBAction)addTaskBtnAction:(id)sender;
- (IBAction)checkTaskBtnAction:(id)sender;

-(void)setDataSourceDailyTaskName:(NSString *)taskName
             andTaskImg:(UIImage *)taskImg
             andTimeLbl:(NSString *)setTime
           setButtonTag:(NSInteger)buttonTag
      addDailyTaskBlock:(void(^)(NSInteger bTag))addDailyTask
      checkDailyTaskBlock:(void(^)(NSInteger bTag))checkDailyTask;

@end
