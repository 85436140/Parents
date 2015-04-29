//
//  FriendsSpaceCell.h
//  P_Child
//
//  Created by kfd on 14-10-31.
//  Copyright (c) 2014年 qzz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SpaceCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UITextView *infoTextView;
@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UIImageView *headImage2;
@property (weak, nonatomic) IBOutlet UITextView *infoTextView2;
@property (weak, nonatomic) IBOutlet UITextView *textViewInfo1;
@property (weak, nonatomic) IBOutlet UITextView *textViewInfo2;

-(void)setDataSourceWithHeadImg:(UIImage *)headImg
                  andHeadImage2:(UIImage *)headImg2
                           note:(NSString *)info
                       andNote2:(NSString *)info2;

@end
