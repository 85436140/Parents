//
//  LecutureDetailVC.h
//  Parents
//
//  Created by kfd on 14-11-12.
//  Copyright (c) 2014年 qzz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ApplyJoinVC.h"

@interface LecutureDetailVC : PCBaseVC
@property (weak, nonatomic) IBOutlet UILabel *organizersNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *activityTimeLbl;
@property (weak, nonatomic) IBOutlet UILabel *activityFeeLbl;
@property (weak, nonatomic) IBOutlet UILabel *activityAddressLbl;
@property (weak, nonatomic) IBOutlet UILabel *fitPeopleLbl;
@property (weak, nonatomic) IBOutlet UILabel *activityFrequencyLbl;

- (IBAction)backBtnAction:(id)sender;
- (IBAction)editBtnAction:(id)sender;
- (IBAction)collectBtnAction:(id)sender;
- (IBAction)shareBtnAction:(id)sender;
- (IBAction)textFontBtnAction:(id)sender;

-(void)setDataSourceWithOrganizerName:(NSString *)organizerName
                   andActivityTimeLbl:(NSString *)activityTime
                    andActivityFeeLbl:(NSString *)activityFee
                andActivityAddressLbl:(NSString *)activityAddress
                      andFitPeopleLbl:(NSString *)fitPeople
             andActitvityFrequencyLbl:(NSString *)activityFrequency
           andActivityPreferentialLbl:(NSString *)activityPreferential;
@end
