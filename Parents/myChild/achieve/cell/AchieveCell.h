//
//  AchieveCell.h
//  Parents
//
//  Created by kfd on 14-11-10.
//  Copyright (c) 2014年 qzz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Subject.h"

@interface AchieveCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *deditIcon;
@property (weak, nonatomic) IBOutlet UILabel *subjectLbl;

@property (weak, nonatomic) IBOutlet UIButton *deleteBtnOutlet;

@property(copy, nonatomic) void (^isEditBtnBlock)(NSInteger bTag);
//@property(copy, nonatomic) void (^isEditBtnBlock)(NSInteger bTag);

- (IBAction)deleteBtnAction:(id)sender;

-(void)setDataSourceWithData:(Subject *)subject
               andIsEditBtnBlock:(void(^)(NSInteger bTag))isEditBtn
                 withIsEditState:(BOOL)editState;

-(void)setBtnTitle:(NSString *)btnTitle isEditBtnBlock:(void(^)(NSInteger btag))isDditBtn;


@end
