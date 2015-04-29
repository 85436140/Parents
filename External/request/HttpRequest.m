//
//  HttpRequest.m
//  InternetRequest
//
//  Created by kfd on 14-9-21.
//  Copyright (c) 2014年 kfd. All rights reserved.
//

#import "HttpRequest.h"
#import "ASIFormDataRequest.h"
#import "JSonKit.h"
static HttpRequest *request = nil;

@implementation HttpRequest

+(HttpRequest *)shareInstance{
    @synchronized(self) {
        if (nil == request) {
            request = [[HttpRequest alloc] init];
        }
    }
    return request;
}

-(void)requestWithPost:(NSString *)urlStr
         requestParams:(NSMutableDictionary *)dicParams
          successBlock:(void(^)(NSData *data))successBlock
           failedBlock:(void(^)(NSString *code,NSString *msg))failedBlock;
 {
    NSString *requestUrl = [NSString stringWithFormat:@"%@%@",kBASEURL,urlStr];
    ASIFormDataRequest *request = [[ASIFormDataRequest alloc]initWithURL:[NSURL URLWithString:requestUrl]];
    //设置请求参数
     if ([dicParams count] != 0) {
         [request setPostValue:[dicParams JSONString] forKey:@"data"];
     }
    [request setTimeOutSeconds:10];
     //设置请求方式
     [request setRequestMethod:@"POST"];
     //设置头文件参数
     [request addRequestHeader:@"Content-Type" value:@"application/json; charset=UTF-8"];
    __block ASIFormDataRequest *weakSelf = request;
    //请求成功
    [request setCompletionBlock:^{
        successBlock(weakSelf.responseData);
    }];
    //请求失败
    [request setFailedBlock:^{
        failedBlock(@"faild:%@",(NSString *)weakSelf.error);
    }];
    //启动异步请求
    [request startSynchronous];
 }

-(void)requestWithGet:(NSString *)url
          successBlock:(void(^)(NSData *data))successBlock
           failedBlock:(void(^)(NSString *code,NSString *msg))failedBlock;
{
    NSString *requestUrl = [NSString stringWithFormat:@"%@%@",kBASEURL,url];
    ASIFormDataRequest *request = [[ASIFormDataRequest alloc]initWithURL:[NSURL URLWithString:requestUrl]];
    __block ASIFormDataRequest *weakSelf = request;
    //请求成功
    [request setCompletionBlock:^{
        successBlock(weakSelf.responseData);
    }];
    //请求失败
    [request setFailedBlock:^{
        failedBlock(@"faild:%@",(NSString *)weakSelf.error);
    }];
    //启动异步请求
    [request startAsynchronous];
}

@end
