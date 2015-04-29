//
//  HttpRequest.h
//  InternetRequest
//
//  Created by kfd on 14-9-21.
//  Copyright (c) 2014年 kfd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpRequest : NSObject

+(HttpRequest *)shareInstance;

-(void)requestWithPost:(NSString *)url
         requestParams:(NSDictionary *)dicParams
          successBlock:(void(^)(NSData *data))successBlock
           failedBlock:(void(^)(NSString *code,NSString *msg))failedBlock;

-(void)requestWithGet:(NSString *)url
         successBlock:(void(^)(NSData *data))successBlock
          failedBlock:(void(^)(NSString *code,NSString *msg))failedBlock;
@end
