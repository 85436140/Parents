//
//  CommentCell.m
//  Parents
//
//  Created by kfd on 15-1-21.
//  Copyright (c) 2015年 qzz. All rights reserved.
//

#import "CommentCell.h"

@implementation CommentCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    self = [[[NSBundle mainBundle] loadNibNamed:@"CommentCell" owner:self options:nil] objectAtIndex:0];
    if (self) {
        
    }
    return self;
}

-(void)setDataSourceWithComment:(NSString *)starNum
                     andComment:(NSString *)comment{
    [CommonView initWithRatingBar:[starNum intValue] andView:_ratingView];
    [_commentLbl setText:comment];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
