//
//  doneViewController.m
//  WeGush
//
//  Created by Daniel Katz on 1/27/15.
//  Copyright (c) 2015 Stratton Apps. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>
#import "doneViewController.h"
#import "dataClass.h"
#import "SettingsTableViewController.h"
#import "AsyncImageDownloader.h"
@interface doneViewController ()
@end
NSNumber *count;
@implementation doneViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"view loaded");
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background-640x960.png"]]];
    NSLog(@"background image set");
    SettingsTableViewController *vc = [[SettingsTableViewController alloc]init];
    if ([vc.repeatSettings  isEqualToString: @"day"]) {
        [[UIApplication sharedApplication] cancelAllLocalNotifications];
        UILocalNotification* localNotification = [[UILocalNotification alloc] init];
        localNotification.fireDate = [NSDate dateWithTimeIntervalSinceNow:86400];
        localNotification.repeatInterval = NSDayCalendarUnit;
        localNotification.alertBody = @"Daily Reminder To Send A Gush";
        localNotification.alertAction = @"Show me the item";
        localNotification.timeZone = [NSTimeZone defaultTimeZone];
        localNotification.applicationIconBadgeNumber = [[UIApplication sharedApplication] applicationIconBadgeNumber] + 1;
        
        [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
        NSLog(@"setting: day");
    }
    else if ([vc.repeatSettings isEqualToString:@"every few days"]){
        [[UIApplication sharedApplication] cancelAllLocalNotifications];
        UILocalNotification* localNotification = [[UILocalNotification alloc] init];
        localNotification.fireDate = [NSDate dateWithTimeIntervalSinceNow:86400];
        localNotification.repeatInterval = NSDayCalendarUnit;
        localNotification.alertBody = @"Daily Reminder To Send A Gush";
        localNotification.alertAction = @"Show me the item";
        localNotification.timeZone = [NSTimeZone defaultTimeZone];
        localNotification.applicationIconBadgeNumber = [[UIApplication sharedApplication] applicationIconBadgeNumber] + 1;
        
        [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
        NSLog(@"setting: every 2 days");

    }
    else {
        [[UIApplication sharedApplication] cancelAllLocalNotifications];
        UILocalNotification* localNotification = [[UILocalNotification alloc] init];
        localNotification.fireDate = [NSDate dateWithTimeIntervalSinceNow:604800];
        localNotification.repeatInterval = NSDayCalendarUnit;
        localNotification.alertBody = @"Daily Reminder To Send A Gush";
        localNotification.alertAction = @"Show me the item";
        localNotification.timeZone = [NSTimeZone defaultTimeZone];
        localNotification.applicationIconBadgeNumber = [[UIApplication sharedApplication] applicationIconBadgeNumber] + 1;
        
        [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
        NSLog(@"setting: week");

    }
    NSString *label;
    [sponsorButton setTitle:label forState:UIControlStateNormal];
    dataClass *obj = [dataClass getInstance];
    if ([obj.sponsorInfo count] == 0) {
        label = @"nil";
        [sponsorButton setTitle:label forState:UIControlStateNormal];
        NSLog(@"sponsor array is emty");


    }
    else{
        label= [obj.sponsorInfo objectAtIndex:2];
        [sponsorButton setTitle:label forState:UIControlStateNormal];
        NSLog(@"using sponsor data");

    }
    if ([obj.quoteData count] == 0) {
        return;
    }
    else{
        int i = arc4random_uniform([obj.quoteData count]);
        quoteLabel.text = [obj.quoteData objectAtIndex:i];
        attributionLabel.text = [obj.quoteAttributeData objectAtIndex:i];
    }

    /**
     [[[AsyncImageDownloader alloc] initWithMediaURL:urlString successBlock:^(UIImage *image)  {
     [sponsorImage setImage:image];
     } failBlock:^(NSError *error) {
     NSLog(@"Failed to download image due to %@!", error);
     }] startDownload];
     **/
    //initializing request
    
    request = [[NSMutableURLRequest alloc] init];
    request.HTTPMethod= @"POST";
    
    NSString *URL = @"http://api.wegush.com/1to1/count";
    [request setURL:[NSURL URLWithString:URL]];
    [request setValue:nil forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"XMLHttpRequest" forHTTPHeaderField:@"X-Requested-With"];
    [request setHTTPBody:nil];
    [NSURLConnection connectionWithRequest:request delegate:self];
}
- (void)didReceiveMemoryWarning
{
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    NSLog(@"--> didReceiveResponse");
    // A response has been received, this is where we initialize the instance var you created
    // so that we can append data to it in the didReceiveData method
    // Furthermore, this method is called each time there is a redirect so reinitializing it
    // also serves to clear it
    
    
    //initialize response (data)
    _responseData = [[NSMutableData alloc] init];
    
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    NSLog(@"--> didReceiveData");
    
    // Append the new data to the instance variable (responseData) you declared
    [_responseData appendData:data];
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
                  willCacheResponse:(NSCachedURLResponse*)cachedResponse {
    // Return nil to indicate not necessary to store a cached response for this connection
    //A more effecient way of storing data(short term)
    return nil;
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSLog(@"--> connectionDidFinishLoading ");
    // _responseData -> is a class variable containing a buffer of recieved response bytes
    // to be able to print it we need to convert it to string -> dataRecieved
    NSString *dataReceived = [[NSString alloc] initWithData:_responseData encoding:NSUTF8StringEncoding];
    // Log the dataRecieved
    NSLog(@"--> async response data (string): %@", dataReceived);
    // Covert recieved response buffer _responseData to JSON object
    // We know that it has to be JSON in the body of this response - if NOT we need to move this code into
    // each program state where it is used
    NSError *error = nil;
    id json = [NSJSONSerialization JSONObjectWithData:_responseData options:0 error:&error];
    if (error) {
        NSLog(@"--> Error decoding _responseData as JSON, ERROR=%@", error);
        return;
    }
    count = [json objectForKey:@"gushes_sent"];
    NSLog(@"num of gushes ----> %@",count);
    countLabel.text = [NSString stringWithFormat:@"%@",count];
    
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
@end
