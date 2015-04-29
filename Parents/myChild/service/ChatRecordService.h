//
//  ChatMessageService.h
//  Parents
//
//  Created by kfd on 15-2-11.
//  Copyright (c) 2015年 qzz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DBService.h"
#import "MessageModel.h"

@interface ChatRecordService : DBService

+(BOOL)cacheChatRecored:(NSArray *)array;
+(NSArray *)queryChatRecord;
+(BOOL)deleteTable;
@end
