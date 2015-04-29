//
//  EditChoiceCell.h
//  Parents
//
//  Created by kfd on 14-11-12.
//  Copyright (c) 2014年 qzz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditChoiceCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UILabel *educationNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *timeLbl;
@property (weak, nonatomic) IBOutlet UILabel *authorNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *praiseCountLbl;
@property (weak, nonatomic) IBOutlet UILabel *commentCountLbl;

-(void)setDataSourceWithHeadImage:(UIImage *)headImage
              andEducationNameLbl:(NSString *)educactionName
                       andTimeLbl:(NSString *)time
                    andAuthorName:(NSString *)authorName
                andPraiseCountLbl:(NSString *)praiseCount
               andCommentCountLbl:(NSString *)commentCount;

@end
