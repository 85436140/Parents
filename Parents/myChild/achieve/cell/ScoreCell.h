//
//  ScoreCell.h
//  Parents
//
//  Created by kfd on 14-12-30.
//  Copyright (c) 2014年 qzz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Score.h"
@interface ScoreCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *scoreLbl;
@property (weak, nonatomic) IBOutlet UILabel *avgScoreLbl;
@property (weak, nonatomic) IBOutlet UILabel *datetimeLbl;
@property (weak, nonatomic) IBOutlet UIButton *editBtnOutlet;

@property (copy, nonatomic) void (^editScoreBlock)(Score *score);
@property (strong, nonatomic) Score *score;
- (IBAction)editBtnAction:(id)sender;

-(void)setDataSourceWithScore:(Score *)score withEditScoreBlock:(void(^)(Score *score))editScoreBlock;
@end
