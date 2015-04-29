//
//  LecutureActivityCell.h
//  Parents
//
//  Created by kfd on 14-11-12.
//  Copyright (c) 2014年 qzz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LecutureActivityCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *lecutureTypeIV;
@property (weak, nonatomic) IBOutlet UILabel *lecutureNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *activityMoneyLbl;
@property (weak, nonatomic) IBOutlet UILabel *activityAddressLbl;
@property (weak, nonatomic) IBOutlet UILabel *activityTimeLbl;

-(void)setDataSourceWithTypeName:(NSString *)typeName
              andLecutureNameLbl:(NSString *)lecutureName
                andActivityMoney:(NSString *)activityMoney
              andActivityAddress:(NSString *)activityAddress
              andActivityTimeLbl:(NSString *)activityTime;

@end
