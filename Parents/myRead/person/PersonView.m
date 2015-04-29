//
//  PersonView.m
//  Parents
//
//  Created by kfd on 14-11-13.
//  Copyright (c) 2014年 qzz. All rights reserved.
//

#import "PersonView.h"

@implementation PersonView

-(instancetype)initWithFrame:(CGRect)frame{
 
    self = [[[NSBundle mainBundle] loadNibNamed:@"PersonView" owner:self options:nil]objectAtIndex:0];
    if (self) {
        
    }
    return self;
}

-(void)comeInLecutureActivityBlock:(void(^)(void))comeInLecutureActivity{
    _comeInLecutureActivityBlock = comeInLecutureActivity;
}

- (IBAction)lecutureActivity:(id)sender {
    _comeInLecutureActivityBlock();
}
@end
