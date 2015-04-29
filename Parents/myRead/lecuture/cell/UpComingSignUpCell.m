//
//  UpComingSignUpCell.m
//  Parents
//
//  Created by kfd on 14-11-12.
//  Copyright (c) 2014年 qzz. All rights reserved.
//

#import "UpComingSignUpCell.h"

@implementation UpComingSignUpCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    self = [[[NSBundle mainBundle] loadNibNamed:@"UpComingSignUpCell" owner:self options:nil]objectAtIndex:0];
    if (self) {
        
    }
    return self;
}

-(void)setDataSourceWithTypeName:(NSString *)typeName
             andLecutureTitleLbl:(NSString *)lecutureTitle
                 andCountDownLbl:(NSString *)countDown{
    [_typeNameLbl setText:typeName];
    [_lecutureTitleLbl setText:lecutureTitle];
    [_countdownLbl setText:countDown];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
