//
//  RewardSetVC.h
//  Parents
//
//  Created by kfd on 14-11-11.
//  Copyright (c) 2014年 qzz. All rights reserved.
//

#import "PCBaseVC.h"
#import "RewardSetCell.h"
#import "AddRewardVC.h"
#import "Award.h"

@interface RewardSetVC : PCBaseVC<UITabBarDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIButton *addRewardBtnOutlet;
@property (weak, nonatomic) IBOutlet UITableView *awardTB;

- (IBAction)addRewardBtnAction:(id)sender;
@end
