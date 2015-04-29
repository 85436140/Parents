//
//  SpaceListVC.h
//  Parents
//
//  Created by kfd on 14-11-10.
//  Copyright (c) 2014年 qzz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SpaceCell.h"

@interface SpaceListVC : PCBaseVC<UITabBarDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIButton *pictureBtnOutlet;
@property (weak, nonatomic) IBOutlet UIButton *sendBtnOutlet;

- (IBAction)pictureBtnAction:(id)sender;
- (IBAction)sendBtnAction:(id)sender;


@end
