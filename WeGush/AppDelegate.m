//
//  AppDelegate.m
//  WeGush
//
//  Created by Family on 1/16/15.
//  Copyright (c) 2015 Stratton Apps. All rights reserved.
//

#import "AppDelegate.h"
#import "GAI.h"
#import "GAIFields.h"
#import "Appirater.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    UIUserNotificationType types = UIUserNotificationTypeBadge |
    UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
    
    UIUserNotificationSettings *mySettings =
    [UIUserNotificationSettings settingsForTypes:types categories:nil];
    
    [[UIApplication sharedApplication] registerUserNotificationSettings:mySettings];
    [Appirater setAppId:@"770699556"];
    [Appirater setDaysUntilPrompt:0];
    [Appirater setUsesUntilPrompt:5];
    [Appirater setSignificantEventsUntilPrompt:-1];
    [Appirater setTimeBeforeReminding:3];
    [Appirater setDebug:NO];
    [Appirater appLaunched:YES];
    [GAI sharedInstance].trackUncaughtExceptions = YES;
    
    // 2
    [[GAI sharedInstance].logger setLogLevel:kGAILogLevelVerbose];
    
    // 3
    [GAI sharedInstance].dispatchInterval = 20;
    
    // 4
    id<GAITracker> tracker = [[GAI sharedInstance] trackerWithTrackingId:@"UA-59048962-1"];
    if ([[UINavigationBar class] respondsToSelector:@selector(appearance)])
    {
        [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed: 14/255.0 green:111/255.0 blue:129/255.0 alpha:1.0f ]]; //// change
        [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
        [[UINavigationBar appearance]setTranslucent:NO];
    }
    
    // Override point for customization after application launch.
    
    // Handle launching from a notification
    UILocalNotification *locationNotification = [launchOptions objectForKey:UIApplicationLaunchOptionsLocalNotificationKey];
    if (locationNotification) {
        // Set icon badge number to zero
        application.applicationIconBadgeNumber = 0;
    }
    
    return YES;
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    
    // Request to reload table view data
    [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadData" object:self];
    
    // Set icon badge number to zero
    application.applicationIconBadgeNumber = 0;
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
