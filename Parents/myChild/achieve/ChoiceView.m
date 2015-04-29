//
//  ChoiceView.m
//  Parents
//
//  Created by kfd on 14-11-14.
//  Copyright (c) 2014年 qzz. All rights reserved.
//

#import "ChoiceView.h"

@interface ChoiceView(){

    NSArray *dateTimeArr;
    BOOL isExpansion;
}

@end

@implementation ChoiceView

-(void)awakeFromNib{

    [super awakeFromNib];
    
    _startDateTimePickerView.delegate = self;
    _startDateTimePickerView.dataSource = self;
    _endDateTimePickerView.delegate = self;
    _endDateTimePickerView.dataSource = self;
    
    ViewBorderRadius(_confirmBtnOutlet, 0, 1, [UIColor blackColor]);
    dateTimeArr = @[@"2014/11/11",@"2014/11/12",@"2014/11/13",@"2014/11/14",@"2014/11/15"];
    isExpansion = NO;

    [self bundGesture];
}

-(instancetype)initWithFrame:(CGRect)frame{

    self = [[[NSBundle mainBundle] loadNibNamed:@"ChoiceView" owner:self options:nil] objectAtIndex:0];
    if (self) {
        
    }
    return self;
}

//给自定义DDL绑定手势
-(void)bundGesture{

    [_startDateTimeDDLView setUserInteractionEnabled:YES];
    UITapGestureRecognizer *startTimeGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startTimeClick)];
    [_startDateTimeDDLView addGestureRecognizer:startTimeGesture];
    
    [_endDateTimeDDLView setUserInteractionEnabled:YES];
    UITapGestureRecognizer *endTimeGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(endTimeClick)];
    [_endDateTimeDDLView addGestureRecognizer:endTimeGesture];

}

-(void)startTimeClick{

    if (isExpansion) {
        [CommonView animationWithPicker:NO andView:_startDateTimeDDLView andSpacing:100];
        isExpansion = NO;
        [_startDateTimePickerView setHidden:YES];
    }else{
        [CommonView animationWithPicker:YES andView:_startDateTimeDDLView andSpacing:100];
        isExpansion = YES;
        [_startDateTimePickerView setHidden:NO];
    }
}

-(void)endTimeClick{
    
    if (isExpansion) {
        [CommonView animationWithPicker:NO andView:_endDateTimeDDLView andSpacing:100];
        isExpansion = NO;
        [_endDateTimePickerView setHidden:YES];
    }else{
        [CommonView animationWithPicker:YES andView:_endDateTimeDDLView andSpacing:100];
        isExpansion = YES;
        [_endDateTimePickerView setHidden:NO];
    }
}


#pragma mark -- pickerView
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{

    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{

    return [dateTimeArr count];
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{

    return [dateTimeArr objectAtIndex:row];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{

    if ([pickerView isEqual:_startDateTimePickerView]) {
        [_startDateTimeTextFeild setText:[dateTimeArr objectAtIndex:row]];
        [CommonView animationWithPicker:NO andView:_startDateTimeDDLView andSpacing:100];
        isExpansion = NO;
        [_startDateTimePickerView setHidden:YES];

    }
    if ([pickerView isEqual:_endDateTimePickerView]) {
        [_endDateTimeTextFeild setText:[dateTimeArr objectAtIndex:row]];
        [CommonView animationWithPicker:NO andView:_endDateTimeDDLView andSpacing:100];
        isExpansion = NO;
        [_endDateTimePickerView setHidden:YES];

    }
}

-(void)confirmBtnBlock:(void(^)(void))confirmBtn{
    _confirmBlock = confirmBtn;
}

- (IBAction)confirmBtnAction:(id)sender {
    _confirmBlock();
}
@end
