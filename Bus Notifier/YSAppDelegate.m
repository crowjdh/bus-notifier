//
//  YSAppDelegate.m
//  Bus Notifier
//
//  Created by Wooseong Kim on 2014. 4. 14..
//  Copyright (c) 2014년 Yooii Studios. All rights reserved.
//

#import "YSAppDelegate.h"

@implementation YSAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    // 원격 노티피케이션을 위한 등록
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound)];
    application.applicationIconBadgeNumber = 0;
    return YES;
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    #if !TARGET_IPHONE_SIMULATOR
    
    NSString *appName = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"];
    NSString *appVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    
    NSUInteger rntypes = [[UIApplication sharedApplication] enabledRemoteNotificationTypes];
    
    NSString *pushBadge = @"disabled";
    NSString *pushAlert = @"disabled";
    NSString *pushSound = @"disabled";
    
    if (rntypes == UIRemoteNotificationTypeBadge) {
        pushBadge = @"enabled";
    }
    
    else if (rntypes == UIRemoteNotificationTypeAlert) {
        pushAlert = @"enabled";
    }
    
    else if (rntypes == UIRemoteNotificationTypeSound) {
        pushSound = @"enabled";
    }
    
    else if (rntypes == (UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert)) {
        pushAlert = @"enabled";
        pushBadge = @"enabled";
    }
    
    else if (rntypes == (UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound)) {
        pushBadge = @"enabled";
        pushSound = @"enabled";
    }
    
    else if (rntypes == (UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound)) {
        pushAlert = @"enabled";
        pushSound = @"enabled";
    }
    
    else if (rntypes == (UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound)) {
        pushBadge = @"enabled";
        pushAlert = @"enabled";
        pushSound = @"enabled";
    }
    
    UIDevice *dev = [UIDevice currentDevice];
    NSString *deviceUuid = [self uniqueDeviceIdentifier];
    NSString *deviceName = dev.name;
    NSString *deviceModel = dev.model;
    NSString *deviceSystemVersion = dev.systemVersion;
    
    NSString *devToken = [[[[deviceToken description] stringByReplacingOccurrencesOfString:@"<" withString:@""] stringByReplacingOccurrencesOfString:@">" withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    // Build URL String for Registration
    NSString *host = @"qnibus1.godo.co.kr";
    NSString *urlString = [@"/apns/apns.php?" stringByAppendingString:@"task=register"];
    urlString = [urlString stringByAppendingFormat:@"&appname=%@", appName];
    urlString = [urlString stringByAppendingFormat:@"&appversion=%@", appVersion];
    urlString = [urlString stringByAppendingFormat:@"&deviceuid=%@", deviceUuid];
    urlString = [urlString stringByAppendingFormat:@"&devicetoken=%@", devToken];
    urlString = [urlString stringByAppendingFormat:@"&devicename=%@", deviceName];
    urlString = [urlString stringByAppendingFormat:@"&devicemodel=%@", deviceModel];
    urlString = [urlString stringByAppendingFormat:@"&deviceversion=%@", deviceSystemVersion];
    urlString = [urlString stringByAppendingFormat:@"&pushbadge=%@", pushBadge];
    urlString = [urlString stringByAppendingFormat:@"&pushalert=%@", pushAlert];
    urlString = [urlString stringByAppendingFormat:@"&pushsound=%@", pushSound];
    
    // Register the Device Data
    NSURL *url = [[NSURL alloc] initWithScheme:@"http" host:host path:urlString];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSLog(@"Register URL: %@", url);
    NSLog(@"Return Data: %@", returnData);
    
    #endif
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    #if !TARGET_IPHONE_SIMULATOR
    
    NSLog(@"Error in registration. Error: %@", error);
    
    #endif
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    #if !TARGET_IPHONE_SIMULATOR
    
    NSLog(@"Remote Notification: %@", [userInfo description]);
    NSDictionary *apsInfo = [userInfo objectForKey:@"aps"];
    
    if (application.applicationState == UIApplicationStateActive) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Did receive a Remote Notification", nil)
                                                            message:[apsInfo objectForKey:@"alert"]
                                                           delegate:self
                                                  cancelButtonTitle:NSLocalizedString(@"OK", nil)
                                                  otherButtonTitles:nil];
        [alertView show];
    } else {
        NSString *alert = [apsInfo objectForKey:@"alert"];
        NSLog(@"Received Push Alert: %@", alert);
        
        NSString *badge = [apsInfo objectForKey:@"badge"];
        NSLog(@"Received Push Badge: %@", badge);
        
        NSString *sound = [apsInfo objectForKey:@"sound"];
        NSLog(@"Received Push Sound: %@", sound);
        NSLog(@"userinfo: %@", userInfo);
    }
    application.applicationIconBadgeNumber = [[apsInfo objectForKey:@"badge"] integerValue];
    
    #endif
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
