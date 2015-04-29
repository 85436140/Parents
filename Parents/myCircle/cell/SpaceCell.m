//
//  FriendsSpaceCell.m
//  P_Child
//
//  Created by kfd on 14-10-31.
//  Copyright (c) 2014年 qzz. All rights reserved.
//

#import "SpaceCell.h"

@implementation SpaceCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [[[NSBundle mainBundle] loadNibNamed:@"SpaceCell" owner:self options:nil] objectAtIndex:0];
    if(self){
        ViewBorderRadius(_textViewInfo1, 5, 1, [UIColor blackColor]);
        ViewBorderRadius(_textViewInfo2, 5, 1, [UIColor blackColor]);
    }
    return self;
}


-(void)setDataSourceWithHeadImg:(UIImage *)headImg
                  andHeadImage2:(UIImage *)headImg2
                           note:(NSString *)info
                       andNote2:(NSString *)info2{

    [_headImage setImage:headImg];
    [_headImage2 setImage:headImg2];
    [_infoTextView setText:info];
    [_infoTextView2 setText:info2];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
