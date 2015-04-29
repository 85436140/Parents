//
//  CommentCell.h
//  Parents
//
//  Created by kfd on 15-1-21.
//  Copyright (c) 2015年 qzz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *ratingView;
@property (weak, nonatomic) IBOutlet UILabel *commentLbl;

-(void)setDataSourceWithComment:(NSString *)starNum
                     andComment:(NSString *)comment;

@end
