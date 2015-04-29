//
//  PCClient.m
//  P_Child
//
//  Created by kfd on 14/10/30.
//  Copyright (c) 2014年 qzz. All rights reserved.
//

#import "PCGloble.h"
static PCGloble *instance = nil;
static NSUserDefaults *userDefaults = nil;
@implementation PCGloble

+ (PCGloble *)shareInstance{
    @synchronized(self) {
        if (nil == instance) {
            instance = [[PCGloble alloc] init];
        }
    }
    return instance;
}

-(NSUserDefaults *)shareUserDefaults{
    
    @synchronized(self) {
        if (nil == userDefaults) {
            userDefaults = [NSUserDefaults standardUserDefaults];
        }
    }
    return userDefaults;
}

@end
