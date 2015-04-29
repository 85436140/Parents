//
//  FriendsCell.m
//  P_Child
//
//  Created by kfd on 14-10-29.
//  Copyright (c) 2014年 qzz. All rights reserved.
//

#import "FriendsCell.h"

@implementation FriendsCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    self = [[[NSBundle mainBundle] loadNibNamed:@"FriendsCell" owner:self options:nil] objectAtIndex:0];
    if(self){

    }
    return self;
}

- (IBAction)checkPersonInfoBtnAction:(id)sender {
    _comeInSpaceBlock();
}

-(void)setDataSourceWithHeadImg:(UIImage *)headImage
                       nickName:(NSString *)nickName
                           note:(NSString *)note
              comeInFriendSpace:(void(^)(void))comeInSpace{
    [_headImg setImage:headImage];
    [_nickNameLbl setText:nickName];
    if ([@"" isEqual:note]) {
        [_noteLbl setHidden:YES];
        [_nickNameLbl setFrame:CGRectMake(X(_nickNameLbl), Y(_nickNameLbl)+12, WIDTH(_nickNameLbl), HEIGH(_nickNameLbl))];
    }else{
        [_noteLbl setText:note];
    }
    _comeInSpaceBlock = comeInSpace;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
