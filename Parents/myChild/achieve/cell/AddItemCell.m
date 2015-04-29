//
//  AddItemCell.m
//  Parents
//
//  Created by kfd on 14-12-2.
//  Copyright (c) 2014年 qzz. All rights reserved.
//

#import "AddItemCell.h"

@implementation AddItemCell

- (void)awakeFromNib {

}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    self = [[[NSBundle mainBundle] loadNibNamed:@"AddItemCell" owner:self options:nil]objectAtIndex:0];
    if (self) {
        
    }
    return self;
}

-(void)setDataSourceWithSubject:(Subject *)subject
               addTaskItemBlock:(void(^)(NSInteger btag))taskItemBlock{

    [_subjectNameLbl setText:subject.subject];
    [_addItemBtnOutlet setTag:[subject.subId intValue]];
    _addTaskItemBlock = taskItemBlock;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)addItemBtnAction:(id)sender {
    _addTaskItemBlock([sender tag]);
}
@end
