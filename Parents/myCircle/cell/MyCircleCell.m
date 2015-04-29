//
//  MyCircleCell.m
//  Parents
//
//  Created by kfd on 14-11-10.
//  Copyright (c) 2014年 qzz. All rights reserved.
//

#import "MyCircleCell.h"

@implementation MyCircleCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    self = [[[NSBundle mainBundle] loadNibNamed:@"MyCircleCell" owner:self options:nil]objectAtIndex:0];
    if (self) {
        
    }
    return self;
}

-(void)setDataSourceWithHeadImage:(UIImage *)headImage
                  andGroupNameLbl:(NSString *)groupName
                  andInfoCountLbl:(NSString *)infoCount
                     setButtonTag:(NSInteger)bTag
              andComeInSpaceBlock:(void(^)(NSInteger bTag))comeInSpace{

    [_headImage setImage:headImage];
    [_groupNameLbl setText:groupName];
    if (infoCount == nil) {
        [_infoCountLbl setHidden:YES];
    }else{
        [_infoCountLbl setText:infoCount];
    }
    [_comeInSpaceBtnOutlet setTag:bTag];
    _comeInSpaceBlock = comeInSpace;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)comeInSpaceBtnAction:(id)sender {
    _comeInSpaceBlock([sender tag]);
}
@end
