//
//  EducationCell.m
//  Parents
//
//  Created by kfd on 14-11-12.
//  Copyright (c) 2014年 qzz. All rights reserved.
//

#import "EducationCell.h"

@implementation EducationCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
   
    self = [[[NSBundle mainBundle] loadNibNamed:@"EducationCell" owner:self options:nil]objectAtIndex:0];
    if (self) {
        
    }
    return self;
}

-(void)setDataSourceWithEducationSubject:(NSString *)educationSubject
                            setButtonTag:(NSInteger)bTag
                     andCheckDetailBlock:(void(^)(NSInteger bTag))checkDetail{
    [_educationSubjectLbl setText:educationSubject];
    [_checkDetailBtnOutlet setTag:bTag];
    _checkDetailBlock = checkDetail;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)checkDetailBtnAction:(id)sender {
    _checkDetailBlock([sender tag]);
}
@end
