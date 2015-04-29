//
//  TaskTypeCell.m
//  P_Child
//
//  Created by kfd on 14-11-5.
//  Copyright (c) 2014年 qzz. All rights reserved.
//

#import "TaskNameCell.h"

@implementation TaskNameCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    self = [[[NSBundle mainBundle] loadNibNamed:@"TaskNameCell" owner:self options:nil]objectAtIndex:0];
    if (self) {
        
    }
    return self;
}

-(void)setDataSourceTaskName:(NSString *)taskName
                setButtonTag:(NSInteger)bTag
                addTaskBlock:(void(^)(NSInteger bTag))addTask{

    [_taskNameLbl setText:taskName];
    [_addTaskBtnOutlet setTag:bTag];
    _addTaskBlock = addTask;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)addTaskBtnAction:(id)sender {
    _addTaskBlock([sender tag]);
}
@end
