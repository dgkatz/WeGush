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
#import "dataClass.h"
#import "UIImageView+WebCache.h"
@interface AppDelegate ()

@end
int i;
@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    UIUserNotificationType types = UIUserNotificationTypeBadge |
    UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
    
    UIUserNotificationSettings *mySettings =
    [UIUserNotificationSettings settingsForTypes:types categories:nil];
    
    [[UIApplication sharedApplication] registerUserNotificationSettings:mySettings];
    [Appirater setAppId:@"984121643"];
    [Appirater setDaysUntilPrompt:0];
    [Appirater setUsesUntilPrompt:5];
    [Appirater setSignificantEventsUntilPrompt:-1];
    [Appirater setTimeBeforeReminding:3];
    [Appirater setDebug:NO];
    [Appirater appLaunched:YES];
    //id<GAITracker> tracker = [[GAI sharedInstance] trackerWithTrackingId:@"UA-41894678-4"];
    [GAI sharedInstance].trackUncaughtExceptions = YES;
    
    // 2
    [[GAI sharedInstance].logger setLogLevel:kGAILogLevelVerbose];
    
    // 3
    [GAI sharedInstance].dispatchInterval = 20;
    
    // 4

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
    application.applicationIconBadgeNumber = 0;
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"HasLaunchedOnce"])
    {
        // app already launched
    }
    else
    {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"HasLaunchedOnce"];
        [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"row"];
        [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"section"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [[UIApplication sharedApplication] cancelAllLocalNotifications];
        // This is the first launch ever
    }
    BOOL shouldUseServer = [[NSUserDefaults standardUserDefaults]boolForKey:@"useServer"];
    if (shouldUseServer) {
        NSLog(@"Should use server already exists");
    }
    else{
        BOOL shouldUseServer = NO;
        NSLog(@"Should use server doesnt exist");
        [[NSUserDefaults standardUserDefaults]setBool:shouldUseServer forKey:@"useServer"];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }
    BOOL shouldUseServer2 = [[NSUserDefaults standardUserDefaults]boolForKey:@"useServer"];
    if (shouldUseServer2 == NO) {
        NSMutableArray *defualtIMageUrlArray =[[NSMutableArray alloc]initWithObjects:@"http://api.wegush.com/1to1/images/messages/msg1.png",
                                               @"http://api.wegush.com/1to1/images/messages/msg2.png",
                                               @"http://api.wegush.com/1to1/images/messages/msg3.png",
                                               @"http://api.wegush.com/1to1/images/messages/msg4.png",
                                               @"http://api.wegush.com/1to1/images/messages/msg5.png",
                                               @"http://api.wegush.com/1to1/images/messages/msg6.png",
                                               @"http://api.wegush.com/1to1/images/messages/msg7.png",
                                               @"http://api.wegush.com/1to1/images/messages/msg8.png",
                                               @"http://api.wegush.com/1to1/images/messages/msg9.png",
                                               @"http://api.wegush.com/1to1/images/messages/msg10.png",
                                               @"http://api.wegush.com/1to1/images/messages/msg11.png",
                                               @"http://api.wegush.com/1to1/images/messages/msg12.png",
                                               @"http://api.wegush.com/1to1/images/messages/msg13.png",
                                               @"http://api.wegush.com/1to1/images/messages/msg14.png",
                                               @"http://api.wegush.com/1to1/images/messages/msg15.png",
                                               @"http://api.wegush.com/1to1/images/messages/msg16.png",
                                               @"http://api.wegush.com/1to1/images/messages/msg17.png",
                                               @"http://api.wegush.com/1to1/images/messages/msg18.png",
                                               @"http://api.wegush.com/1to1/images/messages/msg19.png",
                                               @"http://api.wegush.com/1to1/images/messages/msg20.png",
                                               @"http://api.wegush.com/1to1/images/messages/msg21.png",
                                               @"http://api.wegush.com/1to1/images/messages/msg22.png",
                                               @"http://api.wegush.com/1to1/images/messages/msg23.png",
                                               @"http://api.wegush.com/1to1/images/messages/msg24.png",
                                               @"http://api.wegush.com/1to1/images/messages/msg25.png",
                                               @"http://api.wegush.com/1to1/images/messages/msg26.png"
                                               , nil];
        [[NSUserDefaults standardUserDefaults]setObject:defualtIMageUrlArray forKey:@"defualtImageURLData"];
        NSMutableArray *defualtImageData = [[NSMutableArray alloc]init];
        for (int i = 0; i < [defualtIMageUrlArray count]; i++) {
            [SDWebImageDownloader.sharedDownloader downloadImageWithURL:[NSURL URLWithString:[defualtIMageUrlArray objectAtIndex:i]]
                                                                options:0
                                                               progress:^(NSInteger receivedSize, NSInteger expectedSize)
             {
                 // progression tracking code
             }
                                                              completed:^(UIImage *theImage, NSData *data, NSError *error, BOOL finished)
             {
                 if (theImage && finished)
                 {
                     UIImage *img = theImage;
                     [defualtImageData addObject: UIImagePNGRepresentation(img)];
                     NSLog(@"Working");
                     if ([defualtImageData count] == [defualtIMageUrlArray count]) {
                         NSLog(@"done");
                         [[NSUserDefaults standardUserDefaults]setObject:defualtImageData forKey:@"defualtImageData"];
                         [[NSUserDefaults standardUserDefaults]synchronize];
                     }
                 }
             }];
        }

    }
    return YES;
}

// this is a callback for every notification
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    int td = (int)[[NSUserDefaults standardUserDefaults] integerForKey:@"2"];
    if (td != 1) {
        NSLog(@"Not every Couple Days");
        // this is NOT a multiday notification
        return;
    }
    NSLog(@"Every Couple Days");

    // processes multiday notification
    // multiday notification is NOT recurring
    dataClass *obj = [dataClass getInstance];
    int rand = arc4random_uniform( (int)obj.reminderData.count );
    NSString *randReminder = [obj.reminderData objectAtIndex:rand];
    // Request to reload table view data
    
    UILocalNotification* localNotification = [[UILocalNotification alloc] init];
    localNotification.fireDate = [NSDate dateWithTimeIntervalSinceNow:259200]; // 3 days 259200
    localNotification.repeatInterval = 0;
    localNotification.alertBody = randReminder;
    localNotification.alertAction = @"Show me the item";
    localNotification.timeZone = [NSTimeZone defaultTimeZone];
    localNotification.applicationIconBadgeNumber = [[UIApplication sharedApplication] applicationIconBadgeNumber] + 1;
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
    //[[NSNotificationCenter defaultCenter] postNotificationName:@"reloadData" object:self];
    
    return;
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
