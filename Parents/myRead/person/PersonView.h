//
//  PersonView.h
//  Parents
//
//  Created by kfd on 14-11-13.
//  Copyright (c) 2014年 qzz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LecutureActivityListVC.h"

@interface PersonView : UIView

- (IBAction)lecutureActivity:(id)sender;

@property (copy, nonatomic) void (^comeInLecutureActivityBlock)(void);

-(void)comeInLecutureActivityBlock:(void(^)(void))comeInLecutureActivity;

@end
