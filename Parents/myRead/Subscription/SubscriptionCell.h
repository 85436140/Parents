//
//  SubscriptionCell.h
//  Parents
//
//  Created by 尹祥 on 14/11/15.
//  Copyright (c) 2014年 qzz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SubscriptionCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *subscriptionBtnOutlet;
@property (weak, nonatomic) IBOutlet UIButton *subscriptionBtnOutlet2;
- (IBAction)subscriptionBtnAction:(id)sender;

@end
