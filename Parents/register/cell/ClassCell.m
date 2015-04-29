//
//  ClassCell.m
//  Parents
//
//  Created by kfd on 15-1-6.
//  Copyright (c) 2015年 qzz. All rights reserved.
//

#import "ClassCell.h"

@interface ClassCell(){

    NSMutableArray *clsList;
    NSMutableArray *rowBtnViews;
    CGRect btnRect;
    CGRect addBtnRect;
    CGRect rowViewRect;
    CGRect clsLblRect;
    CGRect studentLblRect;
    CGRect headTeacherLblRect;
    CGRect teacherLblRect;
    
    NSInteger count;
    
    UIButton *clsBtn;
    
    NSInteger currentCell;
}

@end

@implementation ClassCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    self = [[[NSBundle mainBundle] loadNibNamed:@"ClassCell" owner:self options:nil] objectAtIndex:0];
    if (self) {
        
    }
    return self;
}

-(void)setDataSourceWithClass:(NSString *)clsName andClsId:(NSString *)clsId andAddClassBlock:(void (^)(NSString *clsId))addClassBlock{
    _clsName = clsName;
    _clsId = clsId;
    [_grideNameLbl setText:clsName];
    _addClassBlock = addClassBlock;
}

-(void)setDataSourceWithClass:(NSString *)clsName
                     andClsId:(NSString *)clsId
                 andClassList:(NSArray *)classList
             andAddClassBlock:(void(^)(NSString *clsId))addClassBlock
            andClassInfoBlock:(void (^)(NSInteger clsId,NSString *clsNum))classInfoBlock{

    _clsName = clsName;
    _clsId = clsId;
    [_grideNameLbl setText:clsName];
    _addClassBlock = addClassBlock;
    _classInfoBlock = classInfoBlock;
    
    count = classList.count;
    NSInteger currentRow = 0;

    for (int i = 1; i <= count+1; i++) {
        currentCell ++;
        if (currentCell > 3) {
            currentCell = 1;
        }
        clsLblRect = CGRectMake(currentCell*35+(currentCell-1)*70, currentRow*90+10-(currentRow-1)*10, 100, 20);
        studentLblRect = CGRectMake(currentCell*30+(currentCell-1)*75, currentRow*90+10-(currentRow-1)*10+18, 100, 20);
        headTeacherLblRect = CGRectMake(currentCell*25+(currentCell-1)*80, currentRow*90+10-(currentRow-1)*10+31, 100, 20);
        teacherLblRect = CGRectMake(currentCell*20+(currentCell-1)*85, currentRow*90+10-(currentRow-1)*10+43, 100, 20);
        if(i > count){
            addBtnRect = CGRectMake((i%3-1)*(100+7), currentRow*80, 100, 100);
            if (i %3 == 0) {
                addBtnRect = CGRectMake((3-1)*(100+7), currentRow*80, 100, 100);
            }
        }else{
            btnRect = CGRectMake((i%3-1)*(100+7), currentRow*80, 100, 100);
            if (i % 3 == 0) {
                currentRow++;
                btnRect = CGRectMake((3-1)*(100+7), (currentRow-1)*80, 100, 100);
                rowViewRect = CGRectMake(X(_clsRowView), Y(_clsRowView), WIDTH(_clsRowView), (currentRow+1)*80);
                [_superView setFrame:CGRectMake(X(_superView), Y(_superView), WIDTH(_superView), (currentRow+1)*80)];
                [_clsRowView setFrame:rowViewRect];
            }
            if(classList.count != 0){
                
                UIColor *color = [[UIColor alloc] initWithRed:96/255.0 green:96/255.0 blue:96/255.0 alpha:1];
                
                ClassInfo *classInfo = [classList objectAtIndex:i-1];
                clsBtn = [[UIButton alloc] initWithFrame:btnRect];
                [clsBtn setImage:[UIImage imageNamed:@"class"] forState:UIControlStateNormal];
                [clsBtn setTag:[classInfo.classId intValue]];
                [clsBtn.titleLabel setText:classInfo.cname];
                [clsBtn.titleLabel setHidden:YES];
                [clsBtn addTarget:self action:@selector(classInfo:) forControlEvents:UIControlEventTouchUpInside];
                [_clsRowView addSubview:clsBtn];

                UILabel *clsNameLbl = [[UILabel alloc] initWithFrame:clsLblRect];
                [clsNameLbl setText:classInfo.cname];
                [clsNameLbl setTextColor:[UIColor blackColor]];
                [clsNameLbl setFont:[UIFont boldSystemFontOfSize:15]];
                [_clsRowView addSubview:clsNameLbl];
                
                UILabel *studentCountLbl = [[UILabel alloc] initWithFrame:studentLblRect];
                NSString *studentCount = [NSString stringWithFormat:@"%@个同学",classInfo.studentCount];
                [studentCountLbl setText:studentCount];
                [studentCountLbl setTextColor:color];
                [studentCountLbl setFont:[UIFont boldSystemFontOfSize:12]];
                [_clsRowView addSubview:studentCountLbl];
                
                UILabel *headTeacherCountLbl = [[UILabel alloc] initWithFrame:headTeacherLblRect];
                NSString *headTeacherCount = [NSString stringWithFormat:@"%@个班主任",classInfo.teacherCount];
                [headTeacherCountLbl setText:headTeacherCount];
                [headTeacherCountLbl setTextColor:color];
                [headTeacherCountLbl setFont:[UIFont boldSystemFontOfSize:12]];
                [_clsRowView addSubview:headTeacherCountLbl];
                
//                UILabel *teacherCountLbl = [[UILabel alloc] initWithFrame:teacherLblRect];
//                NSString *teacherCount = [NSString stringWithFormat:@"%d个任课老师",0];
//                [teacherCountLbl setText:teacherCount];
//                [teacherCountLbl setTextColor:color];
//                [teacherCountLbl setFont:[UIFont boldSystemFontOfSize:12]];
//                [_clsRowView addSubview:teacherCountLbl];
            }
        }
    }
    [_addClassBtnOutlet setFrame:addBtnRect];
}

- (IBAction)addClassBtnAction:(id)sender {
    
    AddClassView *addClsView = [[AddClassView alloc] init];
    [addClsView setFrame:CGRectMake(SCREEN_WIDTH/2-WIDTH(addClsView)/2, HEIGH(self)/2, WIDTH(addClsView), HEIGH(addClsView))];
    [self addSubview:addClsView];
    [addClsView setAddClassBlock:^(NSString *clsNum) {

        NSString *grideAndCls = [NSString stringWithFormat:@"%@,%@",_clsId,clsNum];
        _addClassBlock(grideAndCls);
    }];
}

- (void)awakeFromNib {
    rowBtnViews = [[NSMutableArray alloc] initWithCapacity:0];
    clsList = [[NSMutableArray alloc] initWithCapacity:0];
    currentCell = 0;
}

-(void)classInfo:(UIButton *)btn{
    _classInfoBlock(btn.tag,btn.titleLabel.text);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
