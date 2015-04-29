//
//  RewardSetCell.h
//  Parents
//
//  Created by kfd on 14-11-11.
//  Copyright (c) 2014年 qzz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Award.h"

@interface RewardSetCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *rewardNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *exchangeConditionLbl;
@property (weak, nonatomic) IBOutlet UIButton *exchangeBtnOutlet;
- (IBAction)exchangeBtnAction:(id)sender;

@property (copy, nonatomic) void (^goExchangeBlock)(Award *award);
@property (strong, nonatomic) Award *award;

-(void)setDataSourceWithRewardDate:(Award *)award
                   goExchangeBlock:(void(^)(Award *award))goExchange;

@end
