//
//  Subject.h
//  Parents
//
//  Created by kfd on 14-12-8.
//  Copyright (c) 2014年 qzz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Subject : NSObject

@property (nonatomic, strong) NSString *subId;
@property (nonatomic, strong) NSString *subject;
@property (nonatomic, strong) NSString *state;

+(Subject *)boundDataWithSubject:(NSDictionary *)dic;
@end
