//
//  UpComingSignUpCell.h
//  Parents
//
//  Created by kfd on 14-11-12.
//  Copyright (c) 2014年 qzz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UpComingSignUpCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *typeNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *lecutureTitleLbl;
@property (weak, nonatomic) IBOutlet UILabel *countdownLbl;

-(void)setDataSourceWithTypeName:(NSString *)typeName
             andLecutureTitleLbl:(NSString *)lecutureTitle
                 andCountDownLbl:(NSString *)countDown;

@end
