//
//  LecutureActivityCell.m
//  Parents
//
//  Created by kfd on 14-11-12.
//  Copyright (c) 2014年 qzz. All rights reserved.
//

#import "LecutureActivityCell.h"

@implementation LecutureActivityCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    self = [[[NSBundle mainBundle] loadNibNamed:@"LecutureActivityCell" owner:self options:nil]objectAtIndex:0];
    if (self) {
        
    }
    return self;
}

-(void)setDataSourceWithTypeName:(NSString *)typeName
              andLecutureNameLbl:(NSString *)lecutureName
                  andActivityMoney:(NSString *)activityMoney
              andActivityAddress:(NSString *)activityAddress
              andActivityTimeLbl:(NSString *)activityTime{
    
    [_lecutureTypeIV setImage:[UIImage imageNamed:typeName]];
    [_lecutureNameLbl setText:lecutureName];
    [_activityMoneyLbl setText:activityMoney];
    [_activityAddressLbl setText:nil];
    [_activityTimeLbl setText:activityTime];

}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
