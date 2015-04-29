//
//  AppDelegate.h
//  Parents
//
//  Created by kfd on 14-11-7.
//  Copyright (c) 2014年 qzz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShowAnimateVC.h"
#import "Reachability.h"
#import "SVProgressHUD.h"
#import "MainViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, IChatManagerDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) MainViewController *mainController;
@property (nonatomic) Reachability *internetReachability;

@end