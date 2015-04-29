//
//  AddClassView.h
//  Parents
//
//  Created by kfd on 15-1-12.
//  Copyright (c) 2015年 qzz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddClassView : UIView

@property (weak, nonatomic) IBOutlet UITextField *clasNumTF;
- (IBAction)cancelBtnAction:(id)sender;
- (IBAction)comfirmBtnAction:(id)sender;

@property (nonatomic,copy) void (^addClsBlock)(NSString *clsNum);

-(void)setAddClassBlock:(void(^)(NSString *clsNum))addClassBlock;
@end
