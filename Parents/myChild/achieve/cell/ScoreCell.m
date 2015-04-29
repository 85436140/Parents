//
//  ScoreCell.m
//  Parents
//
//  Created by kfd on 14-12-30.
//  Copyright (c) 2014年 qzz. All rights reserved.
//

#import "ScoreCell.h"

@implementation ScoreCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    self = [[[NSBundle mainBundle] loadNibNamed:@"ScoreCell" owner:self options:nil] objectAtIndex:0];
    if (self) {
        
    }
    return self;
}

-(void)setDataSourceWithScore:(Score *)score withEditScoreBlock:(void(^)(Score *score))editScoreBlock{

    if(score != nil){
        _score = score;
        [_scoreLbl setText:[NSString stringWithFormat:@"%ld",score.score]];
        [_avgScoreLbl setText:[NSString stringWithFormat:@"%.2f",score.average]];
        [_datetimeLbl setText:score.examDate];
        [_editBtnOutlet setTag:_score.scoreId];
    }
    _editScoreBlock = editScoreBlock;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)editBtnAction:(id)sender {
    _editScoreBlock(_score);
}
@end
