//
//  ContactsVC.h
//  Parents
//
//  Created by kfd on 14-11-13.
//  Copyright (c) 2014年 qzz. All rights reserved.
//

#import "PCBaseVC.h"
#import "FriendsCell.h"
#import "SpaceListVC.h"

@interface ContactsVC : PCBaseVC<UITabBarDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIButton *searchBtnOutlet;
- (IBAction)searchBtnAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *ignoreBtnOutlet;
- (IBAction)ignoreBtnAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *acceptBtnOutlet;
- (IBAction)acceptBtnAction:(id)sender;
@end
