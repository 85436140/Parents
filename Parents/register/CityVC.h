//
//  CityVC.h
//  Parents
//
//  Created by kfd on 15-1-5.
//  Copyright (c) 2015年 qzz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommoneCell.h"

@interface CityVC : PCBaseVC
@property (weak, nonatomic) IBOutlet UITableView *cityTB;
@property (weak, nonatomic) IBOutlet UITextField *cityKeyWordTF;

-(instancetype)initWithCity:(ClassInfo *)clsInfo;
@end
