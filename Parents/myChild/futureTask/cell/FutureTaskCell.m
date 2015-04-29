//
//  FutureTaskCell.m
//  Parents
//
//  Created by kfd on 14-11-11.
//  Copyright (c) 2014年 qzz. All rights reserved.
//

#import "FutureTaskCell.h"

@implementation FutureTaskCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    self = [[[NSBundle mainBundle] loadNibNamed:@"FutureTaskCell" owner:self options:nil]objectAtIndex:0];
    if (self) {

    }
    return self;
}

-(void)setDataSourceWithData:(Task *)task
                         checkDetailBlock:(void(^)(NSInteger bTag))checkDetail{
    if ([task.isRemind isEqual:@"1"]) {
        [_image setHidden:NO];
    }
    [_taskNameLbl setText:task.taskName];
    [_finishTimeLbl setText:[NSString stringWithFormat:@"%@m",task.planTime]];
    [_WaitFinishTaskBtnOutlet setTag:[task.taskId intValue]];
    _checkDetailBlock = checkDetail;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)checkTaskBtnAction:(id)sender {
    _checkDetailBlock([sender tag]);
}
@end
