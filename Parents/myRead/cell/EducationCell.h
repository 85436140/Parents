//
//  EducationCell.h
//  Parents
//
//  Created by kfd on 14-11-12.
//  Copyright (c) 2014年 qzz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EducationCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *educationSubjectLbl;
@property (weak, nonatomic) IBOutlet UIButton *checkDetailBtnOutlet;
@property (copy, nonatomic) void (^checkDetailBlock)(NSInteger bTag);

- (IBAction)checkDetailBtnAction:(id)sender;

-(void)setDataSourceWithEducationSubject:(NSString *)educationSubject
                            setButtonTag:(NSInteger)bTag
                     andCheckDetailBlock:(void(^)(NSInteger bTag))checkDetail;

@end
