//
//  RewardSetCell.m
//  Parents
//
//  Created by kfd on 14-11-11.
//  Copyright (c) 2014年 qzz. All rights reserved.
//

#import "RewardSetCell.h"

@implementation RewardSetCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    self = [[[NSBundle mainBundle] loadNibNamed:@"RewardSetCell" owner:self options:nil]objectAtIndex:0];
    if (self) {
       
    }
    return self;
}

-(void)setDataSourceWithRewardDate:(Award *)award
                      goExchangeBlock:(void(^)(Award *award))goExchange{

    NSString *conditionStr = [NSString stringWithFormat:@"兑现条件：孩子积分%@分",award.condition];
    [_rewardNameLbl setText:award.content];
    [_exchangeConditionLbl setText:conditionStr];
    [_exchangeBtnOutlet setTag:(NSInteger)award.awardId];
    _goExchangeBlock = goExchange;
    _award = award;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (IBAction)exchangeBtnAction:(id)sender {
    _goExchangeBlock(_award);
}
@end
