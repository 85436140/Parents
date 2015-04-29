//
//  AddClassView.m
//  Parents
//
//  Created by kfd on 15-1-12.
//  Copyright (c) 2015年 qzz. All rights reserved.
//

#import "AddClassView.h"

@implementation AddClassView

-(id)initWithFrame:(CGRect)frame{

    self = [[[NSBundle mainBundle] loadNibNamed:@"AddClassView" owner:self options:nil] objectAtIndex:0];
    if (self) {

    }
    return self;
}

-(void)setAddClassBlock:(void (^)(NSString *))addClassBlock{
    _addClsBlock = addClassBlock;
}

- (IBAction)cancelBtnAction:(id)sender {
    [self setHidden:YES];
}

- (IBAction)comfirmBtnAction:(id)sender {
    _addClsBlock([_clasNumTF text]);
    [self setHidden:YES];
}
@end
