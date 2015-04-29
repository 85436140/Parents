//
//  CheckDetailVC.h
//  Parents
//
//  Created by kfd on 14-11-11.
//  Copyright (c) 2014年 qzz. All rights reserved.
//

#import "PCBaseVC.h"
#import "RewardPopView.h"
#import "Task.h"

@interface CheckDetailVC : PCBaseVC
@property (weak, nonatomic) IBOutlet UILabel *costTimeLbl;
@property (weak, nonatomic) IBOutlet UILabel *restTimeLbl;
@property (weak, nonatomic) IBOutlet UITableView *CommentTB;
@property (weak, nonatomic) IBOutlet UIView *encourageView;

@property (strong, nonatomic) Task *task;

- (IBAction)encourangeBtnAction:(id)sender;
-(instancetype)initwithTaskId:(NSInteger)tid andTask:(Task *)task;
-(void)initWithComment:(NSDictionary *)dict;
@end
