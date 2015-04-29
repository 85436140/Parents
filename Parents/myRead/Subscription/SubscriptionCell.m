//
//  SubscriptionCell.m
//  Parents
//
//  Created by 尹祥 on 14/11/15.
//  Copyright (c) 2014年 qzz. All rights reserved.
//

#import "SubscriptionCell.h"

@implementation SubscriptionCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    self = [[[NSBundle mainBundle] loadNibNamed:@"SubscriptionCell" owner:self options:nil]objectAtIndex:0];
    if (self) {
        ViewBorderRadius(_subscriptionBtnOutlet, 5, 1, [UIColor blackColor]);
        ViewBorderRadius(_subscriptionBtnOutlet2, 5, 1, [UIColor blackColor]);
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)subscriptionBtnAction:(id)sender {
}

@end
