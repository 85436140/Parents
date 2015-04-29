//
//  PtaskHeaderView.h
//  Parents
//
//  Created by kfd on 14/11/10.
//  Copyright (c) 2014年 qzz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PtaskHeaderView : UIView
@property (weak, nonatomic) IBOutlet UILabel *currentTimeLbl;
@property (weak, nonatomic) IBOutlet UILabel *finishedTaskCountLbl;
@property (weak, nonatomic) IBOutlet UIImageView *headIconIV;

-(void)setFinishedTaskCount:(NSString *)finishedTaskCount;
@end
