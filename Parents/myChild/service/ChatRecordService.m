//
//  ChatMessageService.m
//  Parents
//
//  Created by kfd on 15-2-11.
//  Copyright (c) 2015年 qzz. All rights reserved.
//

#import "ChatRecordService.h"
#import "FMDatabase.h"

@implementation ChatRecordService

//判断数据是否存在
+(BOOL)QuerySqlExites
{
    BOOL flag;
    
    FMDatabase *db = [FMDatabase databaseWithPath:DATABAE_PATH];
    if (![db open]) {
        NSLog(@"数据打开失败");
        return false;
    }
    NSString *SqlString = [NSString stringWithFormat:@"select * from ChatRecored"];
    FMResultSet *set = [db executeQuery:SqlString];
    if  ([set next]) {
        flag = YES;
    }
    else
    {
        flag = NO;
    }
    [db close];
    return flag;
}

+(BOOL)cacheChatRecored:(NSArray *)array{
    
    if ([self dataPath:ER_DATABASE_PATH]) {
        
        FMDatabase *db = [FMDatabase databaseWithPath:DATABAE_PATH];
        if (![db open]) {
            return NO;
        }
        
        NSString *createTable = @"CREATE TABLE IF NOT EXISTS ChatRecored (ID INTEGER,headImageURL VARCHAR(100),nickName VARCHAR(100),content VARCHAR(1000),sendTime VARCHAR(100), isPlaying VARCHAR(10), isSender VARCHAR(10),isRead VARCHAR(10),isChatGroup VARCHAR(10),isPlayed VARCHAR(10),groupType VARCHAR(10),type VARCHAR(10),status VARCHAR(10))";
        BOOL bo = [db executeUpdate:createTable];
        
        NSString *time;
        MessageModel *message;
        if(array.count == 2){
             time = [array objectAtIndex:0];
             message = [array objectAtIndex:1];
        }else{
            time = @"";
            message = [array objectAtIndex:0];
        }
        NSUserDefaults *users = [PC_Globle shareUserDefaults];
        NSString *realName = [users valueForKey:@"real_name_p"];
        NSString *groupType = [users valueForKey:@"groupType"];
        
        NSString *sqlInsert = [NSString stringWithFormat:@"INSERT INTO ChatRecored('ID','headImageURL','nickName','content','sendTime','isPlaying','isSender','isRead','isChatGroup','isPlayed','groupType','type','status') VALUES(%d,'%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%u','%u');",[message.messageId intValue],[message.headImageURL absoluteString],realName              ,message.content,time,message.isPlaying ? @"YES" : @"NO",message.isSender ? @"YES" : @"NO",message.isRead ? @"YES" : @"NO",message.isChatGroup ? @"YES" : @"NO",message.isPlayed ? @"YES" : @"NO",groupType,message.type,message.status];
        bo = [db executeUpdate:sqlInsert];
        [db close];
        return bo;
    }
    return NO;
}

+(NSArray *)queryChatRecord{

    if ([self dataPath:ER_DATABASE_PATH]) {
        
        NSMutableArray *chatRecordList = [[NSMutableArray alloc] initWithCapacity:0];
        FMDatabase *db = [FMDatabase databaseWithPath:DATABAE_PATH];
        if (![db open]) {
            return chatRecordList;
        }
        
        if ([self QuerySqlExites]) {
           NSString *sql = [NSString stringWithFormat:@"select * from ChatRecored"];
           FMResultSet *result = [db executeQuery:sql];
            while ([result next]) {
                MessageModel *message = [[MessageModel alloc] init];
                message.messageId = [NSString stringWithFormat:@"%d",[result intForColumn:@"ID"]];
                message.headImageURL = [[NSURL alloc] initWithString:[result stringForColumn:@"headImageURL"]];
                message.nickName = [result stringForColumn:@"nickName"];
                message.groupType = [result stringForColumn:@"groupType"];
                message.content = [result stringForColumn:@"content"];
                message.lastSendTime = [result stringForColumn:@"sendTime"];
                message.isPlaying = [[result stringForColumn:@"isPlaying"] boolValue];
                message.isSender = [[result stringForColumn:@"isSender"] boolValue];
                message.isRead = [[result stringForColumn:@"isRead"] boolValue];
                message.isChatGroup = [[result stringForColumn:@"isChatGroup"] boolValue];
                message.status = [[result stringForColumn:@"isPlayed"] boolValue];
                message.type = [[result stringForColumn:@"type"] boolValue];
                message.status = [[result stringForColumn:@"status"] boolValue];
                [chatRecordList addObject:message];
            }
        }
        [db close];
        return chatRecordList;
    }
    return nil;
}

+(BOOL)deleteTable{
    
    FMDatabase *db = [FMDatabase databaseWithPath:DATABAE_PATH];
    if (![db open]) {
        NSLog(@"数据打开失败");
        return false;
    }
    NSString *SqlString = [NSString stringWithFormat:@"drop table ChatRecored"];
    BOOL flag = [db executeUpdate:SqlString];
    [db close];
    return flag;
}

@end
