//
//  AchieveCell.m
//  Parents
//
//  Created by kfd on 14-11-10.
//  Copyright (c) 2014年 qzz. All rights reserved.
//

#import "AchieveCell.h"

@implementation AchieveCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    self = [[[NSBundle mainBundle] loadNibNamed:@"AchieveCell" owner:self options:nil]objectAtIndex:0];
    if (self) {

    }
    return self;
}

-(void)setDataSourceWithData:(Subject *)subject
               andIsEditBtnBlock:(void(^)(NSInteger bTag))isEditBtn
                 withIsEditState:(BOOL)editState{
    [_subjectLbl setText:subject.subject];
    [_deleteBtnOutlet setTag:[subject.subId intValue]];
    _isEditBtnBlock = isEditBtn;
}

-(void)setBtnTitle:(NSString *)btnTitle isEditBtnBlock:(void(^)(NSInteger btag))isDditBtn{
    [_deleteBtnOutlet setTitle:btnTitle forState:UIControlStateNormal];
    _isEditBtnBlock = isDditBtn;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)deleteBtnAction:(id)sender {
    _isEditBtnBlock([sender tag]);
}
@end
