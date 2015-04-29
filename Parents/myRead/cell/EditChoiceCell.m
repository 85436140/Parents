//
//  EditChoiceCell.m
//  Parents
//
//  Created by kfd on 14-11-12.
//  Copyright (c) 2014年 qzz. All rights reserved.
//

#import "EditChoiceCell.h"

@implementation EditChoiceCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    self = [[[NSBundle mainBundle]loadNibNamed:@"EditChoiceCell" owner:self options:nil]objectAtIndex:0];
    if (self) {
        
    }
    return self;
}

-(void)setDataSourceWithHeadImage:(UIImage *)headImage
              andEducationNameLbl:(NSString *)educactionName
                       andTimeLbl:(NSString *)time
                    andAuthorName:(NSString *)authorName
                andPraiseCountLbl:(NSString *)praiseCount
               andCommentCountLbl:(NSString *)commentCount{

    [_headImage setImage:headImage];
    [_educationNameLbl setText:educactionName];
    [_timeLbl setText:time];
    [_authorNameLbl setText:authorName];
    [_praiseCountLbl setText:praiseCount];
    [_commentCountLbl setText:commentCount];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
