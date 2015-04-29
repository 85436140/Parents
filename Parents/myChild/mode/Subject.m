//
//  Subject.m
//  Parents
//
//  Created by kfd on 14-12-8.
//  Copyright (c) 2014年 qzz. All rights reserved.
//

#import "Subject.h"

@implementation Subject

+(Subject *)boundDataWithSubject:(NSDictionary *)dic{
    Subject *subjct = [[Subject alloc] init];
    subjct.subject = dic[@"subject"];
    subjct.subId = dic[@"sub_id"];
    subjct.state = dic[@"state"];
    return subjct;
}
@end
