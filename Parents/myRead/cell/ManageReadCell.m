//
//  ManageReadCell.m
//  Parents
//
//  Created by kfd on 14-11-12.
//  Copyright (c) 2014年 qzz. All rights reserved.
//

#import "ManageReadCell.h"

@implementation ManageReadCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    self = [[[NSBundle mainBundle] loadNibNamed:@"ManageReadCell" owner:self options:nil]objectAtIndex:0];
    if(self){
        UIColor *color = [[UIColor alloc] initWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1];
        ViewBorderRadius(_readBtnOutlet, 5, 1, color);
    }
    return self;
}

-(void)setDataSourceWithGroupName:(NSString *)groupName
                     setButtonTag:(NSInteger)bTag
                   setButtonTitle:(NSString *)btitle
                  andReadBtnBlock:(void(^)(NSInteger bTag))readBtn{
    [_groupNameLbl setText:groupName];
    [_readBtnOutlet setTag:bTag];
    if ([btitle isEqual:@"订阅"]) {
        [_readBtnOutlet setTitleColor:[[UIColor alloc] initWithRed:255/255.0 green:139/255.0 blue:158/255.0 alpha:1] forState:UIControlStateNormal];
    }
    [_readBtnOutlet setTitle:btitle forState:UIControlStateNormal];
    _readBtnBlock = readBtn;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)readBtnAction:(id)sender {
    _readBtnBlock([sender tag]);
}
@end
