//
//  PersonDatasView.m
//  Parents
//
//  Created by kfd on 14/12/17.
//  Copyright (c) 2014年 qzz. All rights reserved.
//

#import "CustomAlertView.h"

@implementation CustomAlertView
-(void)awakeFromNib
{
    [super awakeFromNib];
    _pickView.delegate = self;
    _pickView.dataSource = self;
    
    if (IPHONE6) {
        _FixedSpacePx.width = _FixedSpacePx.width * 1.25;
    }
}

- (IBAction)ClickCancelbar:(id)sender {
    [UIView animateWithDuration:0.2 animations:^{
        [_pickerBottomView setFrame:CGRectMake(0, HEIGH(self), WIDTH(self), HEIGH(_pickerBottomView))];
        [_bottomView setAlpha:1];
        [_bottomView setBackgroundColor:[UIColor whiteColor]];
        [self removeFromSuperview];
    }];
    _CancelBlock();
}

- (IBAction)ClickSureBar:(id)sender {
    [UIView animateWithDuration:0.2 animations:^{
        [_pickerBottomView setFrame:CGRectMake(0, HEIGH(self), WIDTH(self), HEIGH(_pickerBottomView))];
        [_bottomView setAlpha:1];
        [_bottomView setBackgroundColor:[UIColor whiteColor]];
        [self removeFromSuperview];
    }];
    _sureBlock(_row1,_row1Str,_row2,_row2Str,_row3,_row3Str);
}

-(void)setDataSource:(NSArray *)dataList1
       withDataList2:(NSArray *)dataList2
       withDataList3:(NSArray *)dataList3
             withKey:(NSDictionary *)dicKey
         cancelBlock:(void(^)(void))cancelBlock
           sureBlock:(void(^)(NSString *row1,NSString *row1Str,NSString *row2,NSString *row2Str,NSString *row3,NSString *row3Str))sureBlock
{
    _CancelBlock = cancelBlock;
    _sureBlock = sureBlock;
    _dataList1 = dataList1;
    _dataList2 = dataList2;
    _dataList3 = dataList3;
    _dicKey = dicKey;
    if (_dataList1.count > 0 && _dataList2.count > 0 && _dataList3.count > 0) {
        _rowOfCompent = 3;
    }
    else if (_dataList1.count > 0 && _dataList2.count > 0)
    {
        _rowOfCompent = 2;
    }else{
        _rowOfCompent = 1;
    }
}

-(void)showInView:(UIView *)superView
{
    _superView = superView;
    [self setBackgroundColor:[UIColor clearColor]];
    [self setFrame:CGRectMake(0, 0, WIDTH(superView), HEIGH(superView))];
       [_pickerBottomView setFrame:CGRectMake(0, HEIGH(self), WIDTH(self), HEIGH(_pickerBottomView))];
       [UIView animateWithDuration:0.5 animations:^{
           [_bottomView setBackgroundColor:[UIColor blackColor]];
           [_bottomView setAlpha:0.4];
           [superView addSubview:self];
           [_pickerBottomView setFrame:CGRectMake(0, HEIGH(self)-HEIGH(_pickerBottomView), WIDTH(_pickerBottomView), HEIGH(_pickerBottomView))];
       }];
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return _rowOfCompent;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0) {
        return _dataList1.count;
    }
    else if(component == 1)
    {
        return _dataList2.count;
    }
    return _dataList3.count;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component == 0) {
        if (_dicKey == nil || _dicKey.count == 0) {
            return [_dataList1 objectAtIndex:row];
        }
        return [[_dataList1 objectAtIndex:row] valueForKey:[_dicKey valueForKey:@"kName"]];
    }
    else if(component == 1)
    {
        if (_dicKey == nil || _dicKey.count == 0) {
            return [_dataList2 objectAtIndex:row];
        }
        return [[_dataList2 objectAtIndex:row] valueForKey:[_dicKey valueForKey:@"kName"]];
    }
    if (_dicKey == nil || _dicKey.count == 0) {
        return [_dataList3 objectAtIndex:row];
    }
    return [[_dataList3 objectAtIndex:row] valueForKey:[_dicKey valueForKey:@"kName"]];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component == 0) {
        if (_dicKey == nil || _dicKey.count == 0) {
            _row1 = [NSString stringWithFormat:@"%ld",row+1];
            _row1Str = [_dataList1 objectAtIndex:row];
            return;
        }
        _row1 = [[_dataList1 objectAtIndex:row] valueForKey:[_dicKey valueForKey:@"kId"]];
        _row1Str = [[_dataList1 objectAtIndex:row] valueForKey:[_dicKey valueForKey:@"kName"]];
    }
    else if(component == 1)
    {
        if (_dicKey == nil || _dicKey.count == 0) {
            _row2 = [NSString stringWithFormat:@"%ld",row+1];
            _row2Str = [_dataList2 objectAtIndex:row];
            return;
        }
        _row2 = [[_dataList2 objectAtIndex:row] valueForKey:[_dicKey valueForKey:@"kId"]];
        _row2Str = [[_dataList2 objectAtIndex:row] valueForKey:[_dicKey valueForKey:@"kName"]];
    }else{
        if (_dicKey == nil || _dicKey.count == 0) {
            _row3 = [NSString stringWithFormat:@"%ld",row+1];
            _row3Str = [_dataList3 objectAtIndex:row];
            return;
        }
        _row3 = [[_dataList3 objectAtIndex:row] valueForKey:[_dicKey valueForKey:@"kId"]];
        _row3Str = [[_dataList3 objectAtIndex:row] valueForKey:[_dicKey valueForKey:@"kName"]];
    }
}

@end
