//
//  AppDelegate.m
//  Parents
//
//  Created by kfd on 14-11-7.
//  Copyright (c) 2014年 qzz. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "LoginViewController.h"
#import "ApplyViewController.h"
#import "MobClick.h"
#import "APService.h"

#import <ShareSDK/ShareSDK.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import "WXApi.h"
#import "WeiboSDK.h"
//#import <QQConnection/QQConnection.h>


@implementation AppDelegate

//判断当前网络
- (void)reachabilityChanged:(NSNotification *)note{
    Reachability *curReach = [note object];
    NSParameterAssert([curReach isKindOfClass:[Reachability class]]);
    NetworkStatus netStatus = [curReach currentReachabilityStatus];
    switch (netStatus)
    {
        case NotReachable:        {
            // 无网络
            [SVProgressHUD showErrorWithStatus:@"无网络" duration:1];
            break;
        }
            
        case ReachableViaWWAN:        {
            // 移动网络
            [SVProgressHUD showErrorWithStatus:@"当前网络为移动网络，请谨慎使用" duration:1];
            break;
        }
        case ReachableViaWiFi:        {
            // wifi
            [SVProgressHUD showErrorWithStatus:@"当前网络为Wi-Fi" duration:1];
            break;
        }
    }
}

/*
 AppKey="1759557034"  新浪
 AppSecret="085e36a5872ebce0d95c459afe8ba95a"
 
 AppId="1103881123" 空间
 AppKey="URPgH0WdpSS6Q50p"
 
 <Wechat  微信
 AppId="wxfea467da3dba6f52"
 AppSecret="61abe8a53b1cd4a4a3ca9ddc647eec50"
 
 
 <WechatMoments 微信好友
 AppId="wxfea467da3dba6f52"
 AppSecret="61abe8a53b1cd4a4a3ca9ddc647eec50"
 
 <QQ
 AppId="1103881123"
 AppKey="URPgH0WdpSS6Q50p"
 */
-(void)initWithShareAppKey{

    //shareSDK的AppKey
    [ShareSDK registerApp:@"api20"];
    
    //添加新浪微博应用 注册网址 http://open.weibo.com
    [ShareSDK connectSinaWeiboWithAppKey:@"568898243"
                               appSecret:@"38a4f8204cc784f81f9f0daaf31e02e3"
                             redirectUri:@"http://www.sharesdk.cn"];
    //当使用新浪微博客户端分享的时候需要按照下面的方法来初始化新浪的平台
    [ShareSDK  connectSinaWeiboWithAppKey:@"568898243"
                                appSecret:@"38a4f8204cc784f81f9f0daaf31e02e3"
                              redirectUri:@"http://www.sharesdk.cn"
                              weiboSDKCls:[WeiboSDK class]];
    
    //添加QQ空间应用  注册网址  http://connect.qq.com/intro/login/
    [ShareSDK connectQZoneWithAppKey:@"1103881123"//100371282
                           appSecret:@"URPgH0WdpSS6Q50p"//aed9b0303e3ed1e27bae87c33761161d
                   qqApiInterfaceCls:[QQApiInterface class]
                     tencentOAuthCls:[TencentOAuth class]];
    
    //添加QQ应用  注册网址  http://open.qq.com/
    [ShareSDK connectQQWithQZoneAppKey:@"1103881123"//100371282
                     qqApiInterfaceCls:[QQApiInterface class]
                       tencentOAuthCls:[TencentOAuth class]];
    
    //添加微信应用 注册网址 http://open.weixin.qq.com
    [ShareSDK connectWeChatWithAppId:@"wxfea467da3dba6f52"//wx4868b35061f87885
                           appSecret:@"61abe8a53b1cd4a4a3ca9ddc647eec50"
                           wechatCls:[WXApi class]];
}

-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    return [ShareSDK handleOpenURL:url
                        wxDelegate:self];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [ShareSDK handleOpenURL:url
                 sourceApplication:sourceApplication
                        annotation:annotation
                        wxDelegate:self];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    // 设置网络状态变化时的通知函数
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
    self.internetReachability = [Reachability reachabilityForInternetConnection];
    [self.internetReachability startNotifier];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.window setBackgroundColor:[UIColor whiteColor]];
    ShowAnimateVC *showVc = [[ShowAnimateVC alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:showVc];
    [nav.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_bg"] forBarMetrics:UIBarMetricsDefault];
    [self.window setRootViewController:nav];
    
    //初始化shareSDK
    [self initWithShareAppKey];
    
    //jpush
    // Required
#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_7_1
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //可以添加自定义categories
        [APService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                       UIUserNotificationTypeSound |
                                                       UIUserNotificationTypeAlert)
                                           categories:nil];
    } else {
        //categories 必须为nil
        [APService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                       UIRemoteNotificationTypeSound |
                                                       UIRemoteNotificationTypeAlert)
                                           categories:nil];
    }
#else
    //categories 必须为nil
    [APService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                   UIRemoteNotificationTypeSound |
                                                   UIRemoteNotificationTypeAlert)
                                       categories:nil];
#endif
    // Required
    [APService setupWithOption:launchOptions];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(loginStateChange:)
                                                 name:KNOTIFICATION_LOGINCHANGE
                                               object:nil];
    
    if ([UIDevice currentDevice].systemVersion.floatValue >= 7.0) {
        [[UINavigationBar appearance] setBarTintColor:RGBACOLOR(78, 188, 211, 1)];
        [[UINavigationBar appearance] setTitleTextAttributes:
         [NSDictionary dictionaryWithObjectsAndKeys:RGBACOLOR(245, 245, 245, 1), NSForegroundColorAttributeName, [UIFont fontWithName:@ "HelveticaNeue-CondensedBlack" size:21.0], NSFontAttributeName, nil]];
    }
    
    //友盟
    NSString *bundleID = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"];
    if ([bundleID isEqualToString:@"com.easemob.enterprise.demo.ui"]) {
        [MobClick startWithAppkey:@"5389bb7f56240ba94208ac97"
                     reportPolicy:BATCH
                        channelId:Nil];
#if DEBUG
        [MobClick setLogEnabled:YES];
#else
        [MobClick setLogEnabled:NO];
#endif
        
    }
    
    [self registerRemoteNotification];
    
#warning SDK注册 APNS文件的名字, 需要与后台上传证书时的名字一一对应
    NSString *apnsCertName = nil;
#if DEBUG
    apnsCertName = @"pushDevTest";
#else
    apnsCertName = @"pushDevTest";
#endif
    [[EaseMob sharedInstance] registerSDKWithAppKey:@"ecloudz#elcoudz" apnsCertName:apnsCertName];
    
#if DEBUG
    [[EaseMob sharedInstance] enableUncaughtExceptionHandler];
#endif
    [[[EaseMob sharedInstance] chatManager] setAutoFetchBuddyList:YES];
    
    //以下一行代码的方法里实现了自动登录，异步登录，需要监听[didLoginWithInfo: error:]
    //demo中此监听方法在MainViewController中
    [[EaseMob sharedInstance] application:application didFinishLaunchingWithOptions:launchOptions];
    
#warning 注册为SDK的ChatManager的delegate (及时监听到申请和通知)
    [[EaseMob sharedInstance].chatManager removeDelegate:self];
    [[EaseMob sharedInstance].chatManager addDelegate:self delegateQueue:nil];
    
#warning 如果使用MagicalRecord, 要加上这句初始化MagicalRecord
    //demo coredata, .pch中有相关头文件引用
    [MagicalRecord setupCoreDataStackWithStoreNamed:[NSString stringWithFormat:@"%@.sqlite", @"UIDemo"]];
    
//    [self loginStateChange:nil];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)registerRemoteNotification{
#if !TARGET_IPHONE_SIMULATOR
    UIApplication *application = [UIApplication sharedApplication];
    application.applicationIconBadgeNumber = 0;
    
    //iOS8 注册APNS
    if ([application respondsToSelector:@selector(registerForRemoteNotifications)]) {
        [application registerForRemoteNotifications];
        UIUserNotificationType notificationTypes = UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:notificationTypes categories:nil];
        [application registerUserNotificationSettings:settings];
    }else{
        UIRemoteNotificationType notificationTypes = UIRemoteNotificationTypeBadge |
        UIRemoteNotificationTypeSound |
        UIRemoteNotificationTypeAlert;
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:notificationTypes];
    }
    
#endif
    
}

-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    NSString *token = [[deviceToken description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    token = [token stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSString *oldToken = [[PC_Globle shareUserDefaults] valueForKey:@"channelid"];
    
    if (![oldToken isEqualToString:token]) {
    [APService registerDeviceToken:deviceToken];
        NSUserDefaults *user = [PC_Globle shareUserDefaults];
        [user setValue:[APService registrationID] forKey:@"channelid"];
        [user synchronize];
    }
    NSLog(@"--------registrationID:%@",[APService registrationID]);
    
//#warning SDK方法调用
//    [[EaseMob sharedInstance] application:application didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
    
    // Required jpush
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
//#warning SDK方法调用
//    [[EaseMob sharedInstance] application:application didFailToRegisterForRemoteNotificationsWithError:error];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"注册推送失败"
                                                    message:error.description
                                                   delegate:nil
                                          cancelButtonTitle:@"确定"
                                          otherButtonTitles:nil];
    [alert show];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    if (_mainController) {
        [_mainController jumpToChatList];
    }
    
//#warning SDK方法调用
//    [[EaseMob sharedInstance] application:application didReceiveRemoteNotification:userInfo];
    
    // Required jpush
    [APService handleRemoteNotification:userInfo];
}

//jpush
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    AudioServicesPlaySystemSound(1007);
    AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);
    
    // IOS 7 Support Required
    [APService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
    
    NSLog(@"=======userInfo:%@",userInfo);
    NSString *alertstr = userInfo[@"aps"][@"alert"];
    
    UIAlertView *alert =
    [[UIAlertView alloc] initWithTitle:@"温馨提示"
                               message:alertstr
                              delegate:nil
                     cancelButtonTitle:@"确定"
                     otherButtonTitles:nil];
    [alert show];
}

//- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
//{
//    if (_mainController) {
//        [_mainController jumpToChatList];
//    }
//#warning SDK方法调用
//    [[EaseMob sharedInstance] application:application didReceiveLocalNotification:notification];
//}

- (void)applicationWillResignActive:(UIApplication *)application
{
#warning SDK方法调用
    [[EaseMob sharedInstance] applicationWillResignActive:application];
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"applicationDidEnterBackground" object:nil];
#warning SDK方法调用
    [[EaseMob sharedInstance] applicationDidEnterBackground:application];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
#warning SDK方法调用
    [[EaseMob sharedInstance] applicationWillEnterForeground:application];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    //    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    
#warning SDK方法调用
    [[EaseMob sharedInstance] applicationDidBecomeActive:application];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
#warning SDK方法调用
    [[EaseMob sharedInstance] applicationWillTerminate:application];
}

//#pragma mark - IChatManagerDelegate 好友变化
//- (void)didReceiveBuddyRequest:(NSString *)username
//                       message:(NSString *)message
//{
//    if (!username) {
//        return;
//    }
//    if (!message) {
//        message = [NSString stringWithFormat:@"%@ 添加你为好友", username];
//    }
//    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:@{@"title":username, @"username":username, @"applyMessage":message, @"applyStyle":[NSNumber numberWithInteger:ApplyStyleFriend]}];
//    [[ApplyViewController shareController] addNewApply:dic];
//    if (_mainController) {
//        [_mainController setupUntreatedApplyCount];
//    }
//}

#pragma mark - IChatManagerDelegate 群组变化
- (void)didReceiveGroupInvitationFrom:(NSString *)groupId
                              inviter:(NSString *)username
                              message:(NSString *)message
{
    if (!groupId || !username) {
        return;
    }
    
    NSString *groupName = groupId;
    if (!message || message.length == 0) {
        message = [NSString stringWithFormat:@"%@ 邀请你加入群组\'%@\'", username, groupName];
    }
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:@{@"title":groupName, @"groupId":groupId, @"username":username, @"applyMessage":message, @"applyStyle":[NSNumber numberWithInteger:ApplyStyleGroupInvitation]}];
    [[ApplyViewController shareController] addNewApply:dic];
    if (_mainController) {
        [_mainController setupUntreatedApplyCount];
    }
}

//接收到入群申请
//- (void)didReceiveApplyToJoinGroup:(NSString *)groupId
//                         groupname:(NSString *)groupname
//                     applyUsername:(NSString *)username
//                            reason:(NSString *)reason
//                             error:(EMError *)error
//{
//    if (!groupId || !username) {
//        return;
//    }
//    
//    if (!reason || reason.length == 0) {
//        reason = [NSString stringWithFormat:@"%@ 申请加入群组\'%@\'", username, groupname];
//    }
//    else{
//        reason = [NSString stringWithFormat:@"%@ 申请加入群组\'%@\'：%@", username, groupname, reason];
//    }
//    
//    if (error) {
//        NSString *message = [NSString stringWithFormat:@"发送申请失败:%@\n原因：%@", reason, error.description];
//        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"错误" message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//        [alertView show];
//    }
//    else{
//        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:@{@"title":groupname, @"groupId":groupId, @"username":username, @"groupname":groupname, @"applyMessage":reason, @"applyStyle":[NSNumber numberWithInteger:ApplyStyleJoinGroup]}];
//        [[ApplyViewController shareController] addNewApply:dic];
//        if (_mainController) {
//            [_mainController setupUntreatedApplyCount];
//        }
//    }
//}

//- (void)didReceiveRejectApplyToJoinGroupFrom:(NSString *)fromId
//                                   groupname:(NSString *)groupname
//                                      reason:(NSString *)reason
//{
//    if (!reason || reason.length == 0) {
//        reason = [NSString stringWithFormat:@"被拒绝加入群组\'%@\'", groupname];
//    }
//    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"申请提示" message:reason delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//    [alertView show];
//}

//- (void)group:(EMGroup *)group didLeave:(EMGroupLeaveReason)reason error:(EMError *)error
//{
//    NSString *tmpStr = group.groupSubject;
//    NSString *str;
//    if (!tmpStr || tmpStr.length == 0) {
//        NSArray *groupArray = [[EaseMob sharedInstance].chatManager groupList];
//        for (EMGroup *obj in groupArray) {
//            if ([obj.groupId isEqualToString:group.groupId]) {
//                tmpStr = obj.groupSubject;
//                break;
//            }
//        }
//    }
//    
//    if (reason == eGroupLeaveReason_BeRemoved) {
//        str = [NSString stringWithFormat:@"你被从群组\'%@\'中踢出", tmpStr];
//    }
//    if (str.length > 0) {
//        TTAlertNoTitle(str);
//    }
//}

#pragma mark - push
- (void)didBindDeviceWithError:(EMError *)error
{
    if (error) {
        TTAlertNoTitle(@"消息推送与设备绑定失败");
    }
}

#pragma mark - private
//-(void)loginStateChange:(NSNotification *)notification
//{
//    UINavigationController *nav = nil;
//    
//    BOOL isAutoLogin = [[[EaseMob sharedInstance] chatManager] isAutoLoginEnabled];
//    BOOL loginSuccess = [notification.object boolValue];
//    
//    if (isAutoLogin || loginSuccess) {
//        [[ApplyViewController shareController] loadDataSourceFromLocalDB];
//        if (_mainController == nil) {
//            _mainController = [[MainViewController alloc] init];
//            nav = [[UINavigationController alloc] initWithRootViewController:_mainController];
//        }else{
//            nav  = _mainController.navigationController;
//        }
//    }else{
//        _mainController = nil;
//        LoginViewController *loginController = [[LoginViewController alloc] init];
//        nav = [[UINavigationController alloc] initWithRootViewController:loginController];
//        loginController.title = @"环信Test";
//    }
//    
//    if ([UIDevice currentDevice].systemVersion.floatValue < 7.0){
//        nav.navigationBar.barStyle = UIBarStyleDefault;
//        [nav.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_bg"]
//                                forBarMetrics:UIBarMetricsDefault];
//        
//        [nav.navigationBar.layer setMasksToBounds:YES];
//    }
//    
//    self.window.rootViewController = nav;
//    
//    [nav setNavigationBarHidden:YES];
//    [nav setNavigationBarHidden:NO];
//}

@end
