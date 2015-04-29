//
//  MyCircleCell.h
//  Parents
//
//  Created by kfd on 14-11-10.
//  Copyright (c) 2014年 qzz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyCircleCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UILabel *groupNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *infoCountLbl;

@property (weak, nonatomic) IBOutlet UIButton *comeInSpaceBtnOutlet;
@property (copy, nonatomic) void (^comeInSpaceBlock)(NSInteger bTag);

- (IBAction)comeInSpaceBtnAction:(id)sender;

-(void)setDataSourceWithHeadImage:(UIImage *)headImage
                  andGroupNameLbl:(NSString *)groupName
                  andInfoCountLbl:(NSString *)infoCount
                     setButtonTag:(NSInteger)bTag
              andComeInSpaceBlock:(void(^)(NSInteger bTag))comeInSpace;

@end
