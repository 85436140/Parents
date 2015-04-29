//
//  OneWeekCell.h
//  Parents
//
//  Created by kfd on 14-11-28.
//  Copyright (c) 2014年 qzz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OneWeek.h"

@interface OneWeekCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *weekLbl;
@property (weak, nonatomic) IBOutlet UILabel *taskCountLbl;
@property (weak, nonatomic) IBOutlet UILabel *planTimeLbl;
@property (weak, nonatomic) IBOutlet UILabel *usedTimeLbl;
@property (weak, nonatomic) IBOutlet UILabel *chabieLbl;

@property (assign, nonatomic) NSInteger sumSaveTime;

-(void)setDataSourceWithOneWeek:(OneWeek *)oneWeek;
@end
