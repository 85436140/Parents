//
//  SubscriptionView.h
//  Parents
//
//  Created by kfd on 14/11/15.
//  Copyright (c) 2014年 qzz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SubscriptionCell.h"

@interface SubscriptionView : UIView<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *subScriptionTableView;

@end
