//
//  splashVC.m
//  WeGush
//
//  Created by Daniel Katz on 2/17/15.
//  Copyright (c) 2015 Stratton Apps. All rights reserved.
//

#import "splashVC.h"
#import "SDiPhoneVersion.h"
#import "editNavViewController.h"
#import "dataClass.h"
#import "GAI.h"
#import "GAIDictionaryBuilder.h"
#import "GAIFields.h"
#import "UIImageView+WebCache.h"
NSString *wegushBaseUrl;
NSMutableURLRequest *request;
typedef enum programStateTypes
{
    PS_GET_STATUS,
    PS_PROCESS_DATA,
    PS_GET_COUNT,
} ProgramState;
@implementation splashVC

- (void)viewDidLoad
{
        [super viewDidLoad];
    id tracker = [[GAI sharedInstance] defaultTracker];
    
    // This screen name value will remain set on the tracker and sent with
    // hits until it is set to a new value or to nil.
    [tracker set:kGAIScreenName
           value:@"Splash Screen"];
    
    // manual screen tracking
    [tracker send:[[GAIDictionaryBuilder createScreenView] build]];

    dataClass *obj = [dataClass getInstance];
    obj.imageData = [[NSMutableArray alloc]initWithObjects:@"s",@"nil",@"nil",@"nil",@"nil",@"nil",@"nil",@"nil",@"nil",@"nil",@"nil",@"nil",@"nil",@"nil",@"nil",@"nil",@"nil",@"nil",@"nil",@"nil",@"s",@"nil",@"nil",@"nil",@"nil",@"nil",@"nil",@"nil",@"nil",@"nil",@"nil",@"nil",@"nil",@"nil",@"nil",@"nil",@"nil",@"nil",@"nil",@"nil",@"s",@"nil",@"nil",@"nil",@"nil",@"nil",@"nil",@"nil",@"nil",@"nil",@"nil",@"nil",@"nil",@"nil",@"nil",@"nil",@"nil",@"nil",@"nil",@"nil",@"s",@"nil",@"nil",@"nil",@"nil",@"nil",@"nil",@"nil",@"nil",@"nil",@"nil",@"nil",@"nil",@"nil",@"nil",@"nil",@"nil",@"nil",@"nil",@"nil", nil];
    obj.messageData = [[NSMutableArray alloc]init];
    obj.sponsorInfo = [[NSMutableArray alloc]initWithObjects:nil,nil,nil, nil,nil];
    obj.imageURLData = [[NSMutableArray alloc]init];
    obj.reminderData = [[NSMutableArray alloc]init];
    obj.quoteData = [[NSMutableArray alloc]init];
    obj.quoteAttributeData = [[NSMutableArray alloc]init];
    wegushBaseUrl = @"http://api.wegush.com/1to1/";
    request = [[NSMutableURLRequest alloc] init];
    request.HTTPMethod= @"GET";
    //Now we will build the url for this request. We start out with defaultURL and then we append user/allseries
    NSString *getDataURL = wegushBaseUrl;
    getDataURL = [getDataURL stringByAppendingString:@"data"];
    //now we set the request url to the value of allseriesURL and attach a cookie to it
    [request setURL:[NSURL URLWithString:getDataURL]];
    // Send Asynchronous request
    BOOL shouldUseServer = [[NSUserDefaults standardUserDefaults]boolForKey:@"useServer"];
    if (shouldUseServer == YES) {
        NSLog(@"SHould use server is on");
        [NSURLConnection connectionWithRequest:request delegate:self];
    }
    else{
        NSLog(@"should use server is off");
    }
    
    if ([SDiPhoneVersion deviceVersion] == iPhone4){
        image = [UIImage imageNamed:@"background-640x960logo.png"];
        _splash.image = image;
        [self startTimerMethod];
    }
    else if ([SDiPhoneVersion deviceVersion] == iPhone4S){
        image = [UIImage imageNamed:@"background-640x960logo.png"];
        _splash.image = image;
        [self startTimerMethod];
    }
    else if ([SDiPhoneVersion deviceVersion] == iPhone5){
        image = [UIImage imageNamed:@"background-640x1136.png"];
        _splash.image = image;
        [self startTimerMethod];
    }
    else if ([SDiPhoneVersion deviceVersion] == iPhone5S){
        image = [UIImage imageNamed:@"background-640x1136.png"];
        _splash.image = image;
        [self startTimerMethod];
    }
    else if ([SDiPhoneVersion deviceVersion] == iPhone5C){
        image = [UIImage imageNamed:@"background-640x1136.png"];
        _splash.image = image;
        [self startTimerMethod];
    }
    else if ([SDiPhoneVersion deviceVersion] == iPhone6){
        image = [UIImage imageNamed:@"background-750x1334logo.png"];
        _splash.image = image;
        [self startTimerMethod];
    }
    else {
        image = [UIImage imageNamed:@"background-iphone6pluswithlogo.png"];
        _splash.image = image;
        [self startTimerMethod];
    }
    
    
    
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    
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
    dataClass *obj = [dataClass getInstance];
    // _responseData -> is a class variable containing a buffer of recieved response bytes
    // to be able to print it we need to convert it to string -> dataRecieved
    // Log the dataRecieved
    // Covert recieved response buffer _responseData to JSON object
    // We know that it has to be JSON in the body of this response - if NOT we need to move this code into
    // each program state where it is used
    NSError *error = nil;
    id json = [NSJSONSerialization JSONObjectWithData:_responseData options:0 error:&error];
    if (error) {
        return;
    }
    NSNumber *version_ts = [json objectForKey:@"version_ts"];
    NSArray *Messages = [json objectForKey:@"messages"];
    NSArray *reminders = [json objectForKey:@"reminders"];
    NSArray *quotes = [json objectForKey:@"quotes"];
    NSDictionary *Sponsor = [json objectForKey:@"sponsor"];
    NSString *main_screen_text = [Sponsor objectForKey:@"main_screen_text"];
    NSString *done_screen_image_url = [Sponsor objectForKey:@"done_screen_image_url"];
    NSString *done_screen_text = [Sponsor objectForKey:@"done_screen_text"];
    NSString *sponsor_url = [Sponsor objectForKey:@"sponsor_url"];
    NSString *learn_more_url = [Sponsor objectForKey:@"learn_more_url"];
    [obj.sponsorInfo insertObject:main_screen_text atIndex:0];
    [obj.sponsorInfo insertObject:done_screen_image_url atIndex:1];
    [obj.sponsorInfo insertObject:done_screen_text atIndex:2];
    [obj.sponsorInfo insertObject:sponsor_url atIndex:3];
    [obj.sponsorInfo insertObject:learn_more_url atIndex:4];
    // log everything (all the dictionaries) in allseries response, do this by creating a loop that goes through every dict in allSeries response
    id dict;
    for (dict in Messages) {
        NSString *imgURL = dict[@"image_url"];
        NSString *messageString = dict[@"text"];
        [obj.messageData addObject:messageString];
        [obj.imageURLData addObject:imgURL];
        
    }
    for (id dict in reminders) {
        NSString *reminder = dict[@"text"];
        [obj.reminderData addObject:reminder];
    }
    for (id dict in quotes) {
        NSString *quote = dict[@"quote_text"];
        NSString *quoteAttribute = dict[@"attribution"];
        [obj.quoteData addObject:quote];
        [obj.quoteAttributeData addObject: quoteAttribute];
    }
    for (int i = 0; i < [obj.imageURLData count]; i++) {
        [SDWebImageDownloader.sharedDownloader downloadImageWithURL:[NSURL URLWithString:[obj.imageURLData objectAtIndex:i]]
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
                [obj.imageData replaceObjectAtIndex:i withObject:UIImagePNGRepresentation(img)];
                 NSLog(@"Working");
             }
         }];
    }
    
    NSLog(@"%@",obj.quoteData);
    NSLog(@"%@",obj.quoteAttributeData);
    NSLog(@"%@",obj.reminderData);
    NSLog(@"%@",obj.imageURLData);
    NSLog(@"%@",obj.messageData);
    NSLog(@"%@",obj.imageData);
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSArray *messageArray = [NSArray arrayWithArray:obj.messageData];
    [userDefaults setObject:messageArray forKey:@"messageData"];
    NSArray *reminderArray = [NSArray arrayWithArray:obj.reminderData];
    [userDefaults setObject:reminderArray forKey:@"reminderData"];
    NSArray *quoteArray = [NSArray arrayWithArray:obj.quoteData];
    [userDefaults setObject:quoteArray forKey:@"quoteData"];
    NSArray *quoteAttArray = [NSArray arrayWithArray:obj.quoteAttributeData];
    [userDefaults setObject:quoteAttArray forKey:@"quoteAttributeData"];
    NSArray *sponsorArray = [NSArray arrayWithArray:obj.sponsorInfo];
    [userDefaults setObject:sponsorArray forKey:@"sponsorInfo"];
    NSArray *imageUrlArray = [NSArray arrayWithArray:obj.imageURLData];
    [userDefaults setObject:imageUrlArray forKey:@"imageURLData"];
    [userDefaults synchronize];
    obj.doneLoading = 1;
}
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    
    //initialize response (data)
    _responseData = [[NSMutableData alloc] init];
}

-(void)startTimerMethod{
    timer = [NSTimer scheduledTimerWithTimeInterval:2.75 target:self selector:@selector(next) userInfo:nil repeats:NO];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)next{
    [timer invalidate];
    [self performSegueWithIdentifier:@"beginApp" sender:self];
}
@end

