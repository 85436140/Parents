//
//  ClassVC.h
//  Parents
//
//  Created by kfd on 15-1-6.
//  Copyright (c) 2015年 qzz. All rights reserved.
//

#import "PCBaseVC.h"
#import "PersonInfoVC.h"

@interface ClassVC : PCBaseVC

@property (weak, nonatomic) IBOutlet UITableView *classTB;
-(instancetype)initWithClass:(ClassInfo *)clsInfo;

@end
