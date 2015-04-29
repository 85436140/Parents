//
//  SchoolVC.h
//  Parents
//
//  Created by kfd on 15-1-6.
//  Copyright (c) 2015年 qzz. All rights reserved.
//

#import "PCBaseVC.h"

@interface SchoolVC : PCBaseVC

@property (weak, nonatomic) IBOutlet UITextField *schoolKeyWordTF;
@property (weak, nonatomic) IBOutlet UITableView *schoolTB;

-(instancetype)initWithSchool:(ClassInfo *)clsInfo;

@end
