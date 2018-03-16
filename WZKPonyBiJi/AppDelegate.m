//
//  AppDelegate.m
//  WZKPonyBiJi
//
//  Created by 王正魁 on 15-3-14.
//  Copyright (c) 2015年 psylife. All rights reserved.
//
#import "AppDelegate.h"
#import "NavControllerDelegate.h"
#import "Most.h"

#import "NextViewController.h"
#import "TestViewController.h"
#define ios8 [[[UIDevice currentDevice] systemVersion] integerValue]>7?YES:NO
@interface AppDelegate ()
{
}
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [[UIApplication sharedApplication]setApplicationIconBadgeNumber:0];
    
    if ([[NSUserDefaults standardUserDefaults]valueForKey:@"soundName"] == nil) {
       [[NSUserDefaults standardUserDefaults]setValue:@1 forKey:@"soundName"];
    }
    _window.backgroundColor =[UIColor colorWithRed:249/255.0 green:249/255.0 blue:249/255.0 alpha:1];
    
    
    [self removeImages];
    [Most getDBForPathWithName:@"test.sqlite"];
    
    [self jianCeTongZhi];
    
//    //设置全局导航条风格和颜色
//    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:23/255.0 green:180/255.0 blue:237/255.0 alpha:1]];
//    [[UINavigationBar appearance] setBarStyle:UIBarStyleBlack];
    
    //如果已经获得发送通知的授权则创建本地通知，否则请求授权(注意：如果不请求授权在设置中是没有对应的通知设置项的，也就是说如果从来没有发送过请求，即使通过设置也打不开消息允许设置)
    self.main= [[MainViewController alloc] init];
    
    self.menu = [[DDMenuController alloc] initWithRootViewController:self.main];
    TestViewController *leftController = [[TestViewController alloc] init];
    self.menu.leftViewController = leftController;
    
    NextViewController *rightController = [[NextViewController alloc] init];
    self.menu.rightViewController = rightController;
   
    self.window.rootViewController = self.menu;
   
    
    [self.window makeKeyAndVisible];
    return YES;
}
/*
 "Please use registerForRemoteNotifications and registerUserNotificationSettings: instead"
 */
-(void)jianCeTongZhi
{
    if (ios8 == YES) {
        //8
         [[UIApplication sharedApplication]registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound  categories:nil]];
    }
    else
    {
        //7
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
         (UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert)];


    }
    
  
}
-(void)naozhong:(NSInteger)inter withContent:(NSString*)content
{
   
    
    
     if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
     {
        //8
         if ([[UIApplication sharedApplication]currentUserNotificationSettings].types!=UIUserNotificationTypeNone) {
             [self addLocalNotificationWithTime:inter withContent:content];
         }else{
                [[UIApplication sharedApplication]registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound  categories:nil]];
             
         }
     }
     else
     {
         //7
//         if ([[UIApplication sharedApplication]enabledRemoteNotificationTypes]!=UIRemoteNotificationTypeNone) {
             [self addLocalNotificationWithTime:inter withContent:content];
//         }
//         else
//         {
//             [[UIApplication sharedApplication] registerForRemoteNotificationTypes: UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound];
//
//         }
         
     }
}
-(void)removeImages
{
    [Most cleanFolderWithFileName:imageName_];
    [Most cleanFolderWithFileName:luxiangName_];
}
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notif {
    application.applicationIconBadgeNumber = notif.applicationIconBadgeNumber-1;
}
-(void)addLocalNotificationWithTime:(NSInteger)inter withContent:(NSString*)content{
    //定义本地通知对象
//    index++;
    UILocalNotification *notification=[[UILocalNotification alloc]init];
    //设置调用时间
    notification.fireDate=[NSDate dateWithTimeIntervalSinceNow:inter];//通知触发的时间，10s以后
    notification.repeatInterval=0;//通知重复次数
    //notification.repeatCalendar=[NSCalendar currentCalendar];//当前日历，使用前最好设置时区等信息以便能够自动同步时间
    //设置通知属性
    notification.alertBody=content; //通知主体
    notification.applicationIconBadgeNumber = 1;//应用程序图标右上角显示的消息数
    notification.alertAction=@"打开应用"; //待机界面的滑动动作提示
    notification.alertLaunchImage=@"Default";//通过点击通知打开应用时的启动图片,这里使用程序启动图片
//    notification.soundName=UILocalNotificationDefaultSoundName;//收到通知时播放的声音，默认消息声音
    //设置用户信息
    NSUserDefaults* def = [NSUserDefaults standardUserDefaults];
    NSString* soundName = [NSString stringWithFormat:@"%d.caf",[[def objectForKey:@"soundName"] integerValue]];
    notification.soundName = soundName;
    notification.userInfo=@{@"id":@1,@"user":@"Kenshin Cui"};//绑定到通知上的其他附加信息
    //调用通知
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
}
#pragma mark 调用过用户注册通知方法之后执行（也就是调用完registerUserNotificationSettings:方法之后执行）
-(void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings{
    if (notificationSettings.types == UIUserNotificationTypeNone) {
        [[[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"请进入“设置”，进入“通知”，开启通知，否则无法操作" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil] show];
    }
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self jianCeTongZhi];
}
#pragma mark 进入前台后设置消息信息
-(void)applicationWillEnterForeground:(UIApplication *)application{
    [[UIApplication sharedApplication]setApplicationIconBadgeNumber:0];//进入前台取消应用消息图标
}
-(void)removeNotification{
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
