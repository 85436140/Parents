//
//  DailyTaskCellTableViewCell.m
//  P_Child
//
//  Created by kfd on 14-11-5.
//  Copyright (c) 2014年 qzz. All rights reserved.
//

#import "DailyTaskCell.h"

@implementation DailyTaskCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    self = [[[NSBundle mainBundle] loadNibNamed:@"DailyTaskCell" owner:self options:nil]objectAtIndex:0];
    if (self) {
     
    }
    return self;
}

-(void)setDataSourceDailyTaskName:(NSString *)taskName
             andTaskImg:(UIImage *)taskImg
             andTimeLbl:(NSString *)setTime
           setButtonTag:(NSInteger)buttonTag
      addDailyTaskBlock:(void(^)(NSInteger bTag))addDailyTask
      checkDailyTaskBlock:(void(^)(NSInteger bTag))checkDailyTask{

    [_taskNameLbl setText:taskName];
//    [_taskImage setImage:taskImg];
    [_timeLbl setText:setTime];
    [_addTaskBtnOutlet setTag:buttonTag];
    [_checkTaskBtnOutlet setTag:buttonTag];
    _addDailyTaskBlock = addDailyTask;
    _checkDailyTaskBlock = checkDailyTask;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)addTaskBtnAction:(id)sender {
    _addDailyTaskBlock([sender tag]);
}

- (IBAction)checkTaskBtnAction:(id)sender {
    _checkDailyTaskBlock([sender tag]);
}
@end
