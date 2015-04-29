//
//  ZoneVC.h
//  Parents
//
//  Created by kfd on 15-1-6.
//  Copyright (c) 2015年 qzz. All rights reserved.
//

#import "PCBaseVC.h"

@interface ZoneVC : PCBaseVC

@property (weak, nonatomic) IBOutlet UITextField *zoneKeyWordTF;
@property (weak, nonatomic) IBOutlet UITableView *zoneTB;

-(instancetype)initWithZone:(ClassInfo *)clsInfo;

@end
