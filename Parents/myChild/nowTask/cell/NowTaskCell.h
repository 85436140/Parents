//
//  NowTaskCell.h
//  Parents
//
//  Created by kfd on 14-11-11.
//  Copyright (c) 2014年 qzz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Task.h"

@interface NowTaskCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *timeLbl;
@property (weak, nonatomic) IBOutlet UIImageView *foreHandImage;
@property (weak, nonatomic) IBOutlet UILabel *taskNameLbl;
@property (weak, nonatomic) IBOutlet UIView *rankView;
@property (weak, nonatomic) IBOutlet UILabel *restTimeLbl;

@property (weak, nonatomic) IBOutlet UIButton *checkDetailBtnOutlet;

@property (copy, nonatomic) void (^checkDetailBlock)(Task *task);
@property (strong, nonatomic) Task *task;
- (IBAction)checkDetailBtnAction:(id)sender;

-(void)setDataSourceWithObject:(Task *)task
               checkDetailBlock:(void(^)(Task *task))checkDetail;

@end
