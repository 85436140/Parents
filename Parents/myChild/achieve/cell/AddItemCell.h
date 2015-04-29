//
//  AddItemCell.h
//  Parents
//
//  Created by kfd on 14-12-2.
//  Copyright (c) 2014年 qzz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Subject.h"

@interface AddItemCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *addItemBtnOutlet;
@property (weak, nonatomic) IBOutlet UILabel *subjectNameLbl;
@property (strong, nonatomic) void (^addTaskItemBlock)(NSInteger btag);

- (IBAction)addItemBtnAction:(id)sender;

-(void)setDataSourceWithSubject:(Subject *)subject
                addTaskItemBlock:(void(^)(NSInteger btag))taskItemBlock;
@end
