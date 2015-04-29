//
//  ClassCell.h
//  Parents
//
//  Created by kfd on 15-1-6.
//  Copyright (c) 2015年 qzz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddClassView.h"

@interface ClassCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *addClassBtnOutlet;
@property (nonatomic,strong) NSString *clsId;
@property (nonatomic,strong) NSString *clsName;
@property (weak, nonatomic) IBOutlet UILabel *grideNameLbl;
@property (weak, nonatomic) IBOutlet UIView *clsRowView;
@property (weak, nonatomic) IBOutlet UIView *superView;

@property (nonatomic,copy) void (^addClassBlock)(NSString *clsId);
@property (nonatomic,copy) void (^classInfoBlock)(NSInteger grideId,NSString *clsNum);

- (IBAction)addClassBtnAction:(id)sender;

-(void)setDataSourceWithClass:(NSString *)clsName andClsId:(NSString *)clsId andAddClassBlock:(void(^)(NSString *clsId))addClassBlock;

-(void)setDataSourceWithClass:(NSString *)clsName
                     andClsId:(NSString *)clsId
                 andClassList:(NSArray *)classList
             andAddClassBlock:(void(^)(NSString *clsId))addClassBlock
         andClassInfoBlock:(void(^)(NSInteger clsId, NSString *clsNum))classInfoBlock;
@end
