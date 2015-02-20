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
    dataClass *obj = [dataClass getInstance];
    obj.messageData = [[NSMutableArray alloc]initWithCapacity:20];
    obj.sponsorInfo = [[NSMutableArray alloc]initWithCapacity:4];
    obj.imageURLData = [[NSMutableArray alloc]initWithCapacity:20];
    obj.reminderData = [[NSMutableArray alloc]initWithCapacity:20];
    obj.quoteData = [[NSMutableArray alloc]initWithCapacity:20];
    obj.quoteAttributeData = [[NSMutableArray alloc]initWithCapacity:20];
    wegushBaseUrl = @"http://api.wegush.com/1to1/";
    request = [[NSMutableURLRequest alloc] init];
    request.HTTPMethod= @"GET";
    //Now we will build the url for this request. We start out with defaultURL and then we append user/allseries
    NSString *getDataURL = wegushBaseUrl;
    getDataURL = [getDataURL stringByAppendingString:@"data"];
    //now we set the request url to the value of allseriesURL and attach a cookie to it
    [request setURL:[NSURL URLWithString:getDataURL]];
    // Send Asynchronous request
    [NSURLConnection connectionWithRequest:request delegate:self];
    
    if ([SDiPhoneVersion deviceVersion] == iPhone4){
        image = [UIImage imageNamed:@"iPhone4.png"];
        _splash.image = image;
        [self startTimerMethod];
    }
    else if ([SDiPhoneVersion deviceVersion] == iPhone4S){
        image = [UIImage imageNamed:@"iPhone4.png"];
        _splash.image = image;
        [self startTimerMethod];
    }
    else if ([SDiPhoneVersion deviceVersion] == iPhone5){
        image = [UIImage imageNamed:@"iPhone5.png"];
        _splash.image = image;
        [self startTimerMethod];
    }
    else if ([SDiPhoneVersion deviceVersion] == iPhone5S){
        image = [UIImage imageNamed:@"iPhone5.png"];
        _splash.image = image;
        [self startTimerMethod];
    }
    else if ([SDiPhoneVersion deviceVersion] == iPhone5C){
        image = [UIImage imageNamed:@"iPhone5.png"];
        _splash.image = image;
        [self startTimerMethod];
    }
    else if ([SDiPhoneVersion deviceVersion] == iPhone6){
        image = [UIImage imageNamed:@"iPhone6.png"];
        _splash.image = image;
        [self startTimerMethod];
    }
    else {
        image = [UIImage imageNamed:@"iPhone6plus.png"];
        _splash.image = image;
        [self startTimerMethod];
    }
    
    
    
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
    dataClass *obj = [dataClass getInstance];
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
    NSNumber *version_ts = [json objectForKey:@"version_ts"];
    NSLog(@"Received VT = %@",version_ts);
    NSArray *Messages = [json objectForKey:@"messages"];
    NSArray *reminders = [json objectForKey:@"reminders"];
    NSArray *quotes = [json objectForKey:@"quotes"];
    NSDictionary *Sponsor = [json objectForKey:@"sponsor"];
    NSString *main_screen_text = [Sponsor objectForKey:@"main_screen_text"];
    NSString *done_screen_image_url = [Sponsor objectForKey:@"done_screen_image_url"];
    NSString *done_screen_text = [Sponsor objectForKey:@"done_screen_text"];
    NSString *sponsor_url = [Sponsor objectForKey:@"sponsor_url"];
    [obj.sponsorInfo insertObject:main_screen_text atIndex:0];
    [obj.sponsorInfo insertObject:done_screen_image_url atIndex:1];
    [obj.sponsorInfo insertObject:done_screen_text atIndex:2];
    [obj.sponsorInfo insertObject:sponsor_url atIndex:3];
    NSLog(@"sponsor info array ----> %@",obj.sponsorInfo);
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
    NSLog(@"received array of messages: %@",obj.messageData);
    NSLog(@"received array of image urls: %@",obj.imageURLData);
    NSLog(@"received array of reminders: %@",obj.reminderData);
    NSLog(@"received array of quotes: %@",obj.quoteData);
    NSLog(@"received array of attributions: %@",obj.quoteAttributeData);

    
}
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    NSLog(@"--> didReceiveResponse");
    
    //initialize response (data)
    _responseData = [[NSMutableData alloc] init];
}

-(void)startTimerMethod{
    timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(next) userInfo:nil repeats:NO];
    
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

