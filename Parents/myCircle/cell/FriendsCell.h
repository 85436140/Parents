//
//  FriendsCell.h
//  P_Child
//
//  Created by kfd on 14-10-29.
//  Copyright (c) 2014年 qzz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FriendsCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *headImg;
@property (weak, nonatomic) IBOutlet UILabel *nickNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *noteLbl;

@property (weak, nonatomic) IBOutlet UIButton *checkFriendsSpace;

- (IBAction)checkPersonInfoBtnAction:(id)sender;

@property (nonatomic, copy) void (^comeInSpaceBlock)(void);

-(void)setDataSourceWithHeadImg:(UIImage *)headImage
                       nickName:(NSString *)nickName
                           note:(NSString *)note
              comeInFriendSpace:(void(^)(void))comeInSpace;

@end
