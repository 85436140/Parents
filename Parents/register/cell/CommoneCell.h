//
//  CommoneCell.h
//  Parents
//
//  Created by kfd on 14-12-31.
//  Copyright (c) 2014年 qzz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommoneCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLbl;
@property (weak, nonatomic) IBOutlet UIButton *comeInBtnOutlet;

@property (strong, nonatomic) NSString *name;
@property (assign, nonatomic) NSString *idx;

@property (copy, nonatomic) void (^comeInBtnBlock)(NSString *idx);

- (IBAction)comeInBtnAction:(id)sender;

-(void)setDataSource:(NSString *)name
               andId:(NSString *)idx
  withComeInBtnBlock:(void(^)(NSString *idx))comeInBlock;
@end
