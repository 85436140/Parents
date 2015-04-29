//
//  TaskTypeCell.h
//  P_Child
//
//  Created by kfd on 14-11-5.
//  Copyright (c) 2014年 qzz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TaskNameCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *taskNameLbl;
@property (weak, nonatomic) IBOutlet UIButton *addTaskBtnOutlet;

- (IBAction)addTaskBtnAction:(id)sender;

@property(nonatomic, copy) void (^addTaskBlock)(NSInteger bTag);

-(void)setDataSourceTaskName:(NSString *)taskName
                setButtonTag:(NSInteger)bTag
                addTaskBlock:(void(^)(NSInteger bTag))addTask;

@end
