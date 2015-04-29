//
//  NowTaskCell.m
//  Parents
//
//  Created by kfd on 14-11-11.
//  Copyright (c) 2014年 qzz. All rights reserved.
//

#import "NowTaskCell.h"

@implementation NowTaskCell{
    CGFloat scale;
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    self = [[[NSBundle mainBundle] loadNibNamed:@"NowTaskCell" owner:self options:nil]objectAtIndex:0];
    if (self) {
        scale = 1;
        if (IPHONE4||IPHONE5) {
            scale = 0.72;
        }
    }
    return self;
}

-(void)setDataSourceWithObject:(Task *)task
               checkDetailBlock:(void(^)(Task *task))checkDetail{
        
    NSString *restTime = [NSString stringWithFormat:@"休息了%@分钟",task.restTime];
    NSString *startTime = [CommonView changetimeStamp:task.startTime andFormatter:@"hh:mm"];
    [_timeLbl setText:startTime];
    [_foreHandImage setImage:[UIImage imageNamed:@"sports"]];
    [_taskNameLbl setText:task.taskName];
     [CommonView initWithRatingBar:[task.starLevel intValue] andView:_rankView];
    [_restTimeLbl setText:restTime];
    [_checkDetailBtnOutlet setTag:[task.taskId intValue]];
    _checkDetailBlock = checkDetail;
    _task = task;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)checkDetailBtnAction:(id)sender {
    _checkDetailBlock(_task);
}
@end
