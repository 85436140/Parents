//
//  MyAchieveView.h
//  P_Child
//
//  Created by kfd on 14-11-3.
//  Copyright (c) 2014年 qzz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyAchieveView : UIView<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *myCollectionView;
@property (weak, nonatomic) IBOutlet UILabel *jifenLbl;
@end
