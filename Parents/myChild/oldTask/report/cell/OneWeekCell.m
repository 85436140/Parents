//
//  OneWeekCell.m
//  Parents
//
//  Created by kfd on 14-11-28.
//  Copyright (c) 2014年 qzz. All rights reserved.
//

#import "OneWeekCell.h"

@implementation OneWeekCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [[[NSBundle mainBundle] loadNibNamed:@"OneWeekCell" owner:self options:nil] objectAtIndex:0];
    if (self) {
        
    }
    return self;
}
- (void)awakeFromNib {
    // Initialization code
}

-(void)setDataSourceWithOneWeek:(OneWeek *)oneWeek{
    _weekLbl.text = [NSString stringWithFormat:@"%ld",oneWeek.weekday];
    _taskCountLbl.text = [NSString stringWithFormat:@"%ld",oneWeek.taskCount];
    _planTimeLbl.text = [NSString stringWithFormat:@"%ld",oneWeek.planTime];
    _usedTimeLbl.text = [NSString stringWithFormat:@"%ld",oneWeek.costTime];
    _chabieLbl.text = [NSString stringWithFormat:@"%ld",oneWeek.chabie];
    _sumSaveTime += oneWeek.chabie;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
