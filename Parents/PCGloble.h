//
//  PCClient.h
//  P_Child
//
//  Created by kfd on 14/10/30.
//  Copyright (c) 2014年 qzz. All rights reserved.
//

#import <Foundation/Foundation.h>
#define PC_Globle  [PCGloble shareInstance]
@interface PCGloble : NSObject
+ (PCGloble *)shareInstance;
- (NSUserDefaults *)shareUserDefaults;
@property (nonatomic,strong) UIViewController *taskVC;
@end
