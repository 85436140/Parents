//
//  FutureTaskCell.h
//  Parents
//
//  Created by kfd on 14-11-11.
//  Copyright (c) 2014年 qzz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Task.h"

@interface FutureTaskCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *WaitFinishTaskBtnOutlet;
@property (weak, nonatomic) IBOutlet UILabel *taskNameLbl;
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *finishTimeLbl;
@property (weak, nonatomic) IBOutlet UIButton *checkTaskBtnOutlet;

@property (copy, nonatomic) void (^checkDetailBlock)(NSInteger bTag);

- (IBAction)checkTaskBtnAction:(id)sender;

-(void)setDataSourceWithData:(Task *)task
                         checkDetailBlock:(void(^)(NSInteger bTag))checkDetail;

@end
