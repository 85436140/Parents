//
//  ManageReadCell.h
//  Parents
//
//  Created by kfd on 14-11-12.
//  Copyright (c) 2014年 qzz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ManageReadCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *groupNameLbl;
@property (weak, nonatomic) IBOutlet UIButton *readBtnOutlet;

@property (copy, nonatomic) void (^readBtnBlock)(NSInteger bTag);

- (IBAction)readBtnAction:(id)sender;

-(void)setDataSourceWithGroupName:(NSString *)groupName
                     setButtonTag:(NSInteger)bTag
                   setButtonTitle:(NSString *)btitle
                  andReadBtnBlock:(void(^)(NSInteger bTag))readBtn;
@end
