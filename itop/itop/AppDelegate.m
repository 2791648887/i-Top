//
//  AppDelegate.m
//  itop
//
//  Created by huangli on 18/1/6.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import "AppDelegate.h"
#import "AppDelegate+WeChat.h"
#import <Reachability.h>

@interface AppDelegate (){
    
@private
    Reachability *hostReach;
}

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // 启动画面的显示时间为2秒
//    [NSThread sleepForTimeInterval:1.0];
    [UIManager makeKeyAndVisible];
    [UMAnalyticsConfig sharedInstance].appKey = UMengAppKey;
    [UMAnalyticsConfig sharedInstance].channelId = UMengChannel;
    [MobClick startWithConfigure:UMConfigInstance];
    
    [self setupWeChat];
    
    //开启网络状况的监听
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(reachabilityChanged:)
                                                name:kReachabilityChangedNotification
                                              object:nil];
    hostReach = [Reachability
                 reachabilityWithHostName:@"www.apple.com"]; //可以以多种形式初始化
    [hostReach startNotifier]; //开始监听,会启动一个run loop
    
    [IQKeyboardManager load];
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
//    [[IQKeyboardManager sharedManager]
//     disableInViewControllerClass:[LCEChatRoomVC class]];

    // Override point for customization after application launch.
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}

-(BOOL)application:(UIApplication *)application handleOpenURL:(nonnull NSURL *)url{
    
    return [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
}

-(BOOL)application:(UIApplication *)application openURL:(nonnull NSURL *)url sourceApplication:(nullable NSString *)sourceApplication annotation:(nonnull id)annotation{
    
    return [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

//监听到网络状态改变
- (void)reachabilityChanged:(NSNotification *)note{
    
    Reachability *curReach = [note object];
    
    NSParameterAssert([curReach isKindOfClass:[Reachability class]]);
    
    [self updateInterfaceWithReachability:curReach];
}

//处理连接改变后的情况
- (void)updateInterfaceWithReachability:(Reachability *)curReach{
    
    //对连接改变做出响应的处理动作。
    NetworkStatus status = [curReach currentReachabilityStatus];
    
    if (status == 1) {
        NSLog(@"\n网络--3g/2G\n");
    } else if (status == 2) {
        NSLog(@"\n网络--wifi\n");
    } else if (status == 0) {
        NSLog(@"\n网络--无网络\n");
    }
}



@end