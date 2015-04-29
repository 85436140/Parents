//
//  CommoneCell.m
//  Parents
//
//  Created by kfd on 14-12-31.
//  Copyright (c) 2014年 qzz. All rights reserved.
//

#import "CommoneCell.h"

@implementation CommoneCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    self = [[[NSBundle mainBundle] loadNibNamed:@"CommoneCell" owner:self options:nil] objectAtIndex:0];
    return self;
}

-(void)setDataSource:(NSString *)name andId:(NSString *)idx withComeInBtnBlock:(void(^)(NSString *idx))comeInBlock{
    
    _name = name;
    _idx = idx;
    [_nameLbl setText:name];
    [_comeInBtnOutlet setTag:[idx intValue]];
    _comeInBtnBlock = comeInBlock;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)comeInBtnAction:(id)sender {
    _comeInBtnBlock(_idx);
}
@end
