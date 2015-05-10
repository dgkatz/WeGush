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
#import "UIView+RoundedCorners.h"
#import "SDiPhoneVersion.h"
#import "NSString+NSHash.h"
#import "NSData+NSHash.h"
#import "GAI.h"
#import "GAIDictionaryBuilder.h"
#import "GAIFields.h"
#import "UIImageView+WebCache.h"
@interface doneViewController ()
@end
NSNumber *count;
NSString *attString;
NSLayoutConstraint *myConstraint2;
NSLayoutConstraint *myConstraint;
NSLayoutConstraint *myConstraint3;
@implementation doneViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    int total = (int)[[NSUserDefaults standardUserDefaults]integerForKey:@"total"];
    countLabel.text = [NSString stringWithFormat:@"%d",total];
    if ([SDiPhoneVersion deviceVersion] == iPhone6Plus) {
     myConstraint =[NSLayoutConstraint
     constraintWithItem:paragraphLabel
     attribute:NSLayoutAttributeTop
     relatedBy:NSLayoutRelationEqual
     toItem:self.topLayoutGuide
     attribute:NSLayoutAttributeBottom
     multiplier:1.0
     constant:40];
     [self.view addConstraint:myConstraint];
    }
    else if ([SDiPhoneVersion deviceVersion] == iPhone6){
    myConstraint3 =[NSLayoutConstraint
                       constraintWithItem:paragraphLabel
                       attribute:NSLayoutAttributeTop
                       relatedBy:NSLayoutRelationEqual
                       toItem:self.topLayoutGuide
                       attribute:NSLayoutAttributeBottom
                       multiplier:1.0
                       constant:30];
        [self.view addConstraint:myConstraint3];
    }
    else{
    myConstraint2 =[NSLayoutConstraint
                                       constraintWithItem:paragraphLabel
                                       attribute:NSLayoutAttributeTop
                                       relatedBy:NSLayoutRelationEqual
                                       toItem:self.topLayoutGuide
                                       attribute:NSLayoutAttributeBottom
                                       multiplier:1.0
                                       constant:10];
    [self.view addConstraint:myConstraint2];
    }
    //----------------------------------------------------------------------------------//
    //------------------------- Send View To Google Analytics --------------------------//
    id tracker = [[GAI sharedInstance] defaultTracker];
    [tracker set:kGAIScreenName
           value:@"Done Screen"];
    [tracker send:[[GAIDictionaryBuilder createScreenView] build]];
    
    //--------------------------------------------------------------------//
    //------------------------- Round The Vuiew --------------------------//
    [self.gushView.layer setCornerRadius:5.0f];
    [self.gushView.layer setMasksToBounds:YES];
    
    //------------------------------------------------------------------------------//
    //------------------------- Paragraph Label Designing --------------------------//
    paragraphLabel.textColor = [UIColor whiteColor];
    paragraphLabel.text = [NSString stringWithFormat:@"The appreciation revolution is under way.\nThanks for being a part of it!"];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:paragraphLabel.text];
    NSMutableParagraphStyle *paragrahStyle = [[NSMutableParagraphStyle alloc] init];
    if ([SDiPhoneVersion deviceVersion] == iPhone6Plus) {
        [paragrahStyle setLineSpacing:8];
    }
    else{
        [paragrahStyle setLineSpacing:6];
    }
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragrahStyle range:NSMakeRange(0, [paragraphLabel.text length])];
    paragraphLabel.attributedText = attributedString ;
    paragraphLabel.textAlignment = NSTextAlignmentCenter;
    //[SDiPhoneVersion deviceVersion] == iPhone6Plus
    if([SDiPhoneVersion deviceVersion] == iPhone6){
        [paragraphLabel setFont:[UIFont systemFontOfSize:17.5]];
        [gushesSent setFont:[UIFont systemFontOfSize:23]];
        [countLabel setFont:[UIFont systemFontOfSize:46]];
    }
    else if ([SDiPhoneVersion deviceVersion] == iPhone6Plus){
        [paragraphLabel setFont:[UIFont systemFontOfSize:19]];
        [gushesSent setFont:[UIFont systemFontOfSize:24]];
        [countLabel setFont:[UIFont systemFontOfSize:47]];
    }
    else{
        [paragraphLabel setFont:[UIFont systemFontOfSize:15]];
    }
    //-------------------------------------------------------------------------------------------//
    //------------------------- Determine If iPhone 4 And Remove Quote --------------------------//
    if([SDiPhoneVersion deviceVersion] == iPhone4){
        quoteImage.hidden = YES;
        quoteLabel.hidden = YES;
    }
    else if ([SDiPhoneVersion deviceVersion] == iPhone4S){
        quoteImage.hidden = YES;
        quoteLabel.hidden = YES;
    }
    else if ([SDiPhoneVersion deviceVersion] == iPadMini){
        quoteImage.hidden = YES;
        quoteLabel.hidden = YES;
    }
    else if ([SDiPhoneVersion deviceVersion] == iPad1){
        quoteImage.hidden = YES;
        quoteLabel.hidden = YES;
    }
    else if ([SDiPhoneVersion deviceVersion] == iPad2){
        quoteImage.hidden = YES;
        quoteLabel.hidden = YES;
    }
    else if ([SDiPhoneVersion deviceVersion] == iPad3){
        quoteImage.hidden = YES;
        quoteLabel.hidden = YES;
    }
    else if ([SDiPhoneVersion deviceVersion] == iPad4){
        quoteImage.hidden = YES;
        quoteLabel.hidden = YES;
    }
    else if ([SDiPhoneVersion deviceVersion] == iPadAir){
        quoteImage.hidden = YES;
        quoteLabel.hidden = YES;
    }
    else if ([SDiPhoneVersion deviceVersion] == iPadMiniRetina){
        quoteImage.hidden = YES;
        quoteLabel.hidden = YES;
    }
    else if ([[UIScreen mainScreen] respondsToSelector:@selector(displayLinkWithTarget:selector:)] &&
             ([UIScreen mainScreen].scale == 1.0)) {
        // Retina display
        quoteImage.hidden = YES;
        quoteLabel.hidden = YES;
    }
    else{
        quoteLabel.hidden = NO;
        quoteImage.hidden = NO;
    }
    
    //-----------------------------------------------------------------------------//
    //------------------------- Setting Background Image --------------------------//
    BOOL shouldUseServer = [[NSUserDefaults standardUserDefaults]boolForKey:@"useServer"];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    UIImageView *backgroundImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"background-640x960.png"]];
    CGRect rectFrame = self.navigationController.view.frame;
    backgroundImage.frame = rectFrame;
    [self.view insertSubview:backgroundImage atIndex:0];
    
    dataClass *obj = [dataClass getInstance];
    
    NSLog(@"%@",obj.sponsorInfo);
    NSString *urlToGet;
    if (shouldUseServer == NO) {
        NSArray *sponsorArray = [[NSUserDefaults standardUserDefaults]objectForKey:@"defaultSponsorData"];
        urlToGet = [sponsorArray objectAtIndex:1];
    }
    else{
        urlToGet = [obj.sponsorInfo objectAtIndex:1];
    }
    [SDWebImageDownloader.sharedDownloader downloadImageWithURL:[NSURL URLWithString:urlToGet]
                                                        options:0
                                                       progress:^(NSInteger receivedSize, NSInteger expectedSize)
     {
         // progression tracking code
     }
                                                      completed:^(UIImage *theImage, NSData *data, NSError *error, BOOL finished)
     {
         if (theImage && finished)
         {
             self.sponsorImageView.image = theImage;
 
         }
     }];

    //-----------------------------------------------------------------------//
    //------------------------- Notification Logic --------------------------//
    int rand = arc4random_uniform((int)[obj.reminderData count]);
    NSString *randReminder = [obj.reminderData objectAtIndex:rand];
    NSString *repeatSettings = [[NSUserDefaults standardUserDefaults]stringForKey:@"repeatSettings"];
    if ([repeatSettings  isEqualToString: @"day"]) {
        [[UIApplication sharedApplication] cancelAllLocalNotifications];
        UILocalNotification* localNotification = [[UILocalNotification alloc] init];
        localNotification.fireDate = [NSDate dateWithTimeIntervalSinceNow:86400];
        localNotification.repeatInterval = NSDayCalendarUnit;
        localNotification.alertBody = randReminder;
        localNotification.alertAction = @"Show me the item";
        localNotification.timeZone = [NSTimeZone defaultTimeZone];
        localNotification.applicationIconBadgeNumber = [[UIApplication sharedApplication] applicationIconBadgeNumber] + 1;
        [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
    }
    else if ([repeatSettings isEqualToString:@"once a week"]){
        [[UIApplication sharedApplication] cancelAllLocalNotifications];
        UILocalNotification* localNotification = [[UILocalNotification alloc] init];
        localNotification.fireDate = [NSDate dateWithTimeIntervalSinceNow:604800];
        localNotification.repeatInterval = NSWeekCalendarUnit;
        localNotification.alertBody = randReminder;
        localNotification.alertAction = @"Show me the item";
        localNotification.timeZone = [NSTimeZone defaultTimeZone];
        localNotification.applicationIconBadgeNumber = [[UIApplication sharedApplication] applicationIconBadgeNumber] + 1;
        [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];

    }
    else if ([repeatSettings isEqualToString:@"once a month"]){
        [[UIApplication sharedApplication] cancelAllLocalNotifications];
        UILocalNotification* localNotification = [[UILocalNotification alloc] init];
        localNotification.fireDate = [NSDate dateWithTimeIntervalSinceNow:2628000];
        localNotification.repeatInterval = NSMonthCalendarUnit;
        localNotification.alertBody = randReminder;
        localNotification.alertAction = @"Show me the item";
        localNotification.timeZone = [NSTimeZone defaultTimeZone];
        localNotification.applicationIconBadgeNumber = [[UIApplication sharedApplication] applicationIconBadgeNumber] + 1;
        [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];

    }
    else{
        
    }
    
    //-----------------------------------------------------------------------------//
    //------------------------- Set Sponsor Button Title --------------------------//
    NSString *label;
    [sponsorButton setTitle:label forState:UIControlStateNormal];
    if (shouldUseServer == NO) {
        NSArray *sponsorArray = [[NSUserDefaults standardUserDefaults]objectForKey:@"defaultSponsorData"];
        label = [sponsorArray objectAtIndex:2];
        [sponsorButton setTitle:label forState:UIControlStateNormal];
    }
    else{
        label= [obj.sponsorInfo objectAtIndex:2];
        [sponsorButton setTitle:label forState:UIControlStateNormal];

    }
    
    //--------------------------------------------------------------------------//
    //------------------------- Quote Label Designing --------------------------//
    if (shouldUseServer == NO) {
        NSArray *quoteArray = [[NSUserDefaults standardUserDefaults]objectForKey:@"defaultQuoteData"];
        NSArray *attributionArray = [[NSUserDefaults standardUserDefaults]objectForKey:@"defaultAttributionData"];
        int randitn = arc4random_uniform([quoteArray count]);
        NSString *quoteString = [quoteArray objectAtIndex:randitn];
        attString = [attributionArray objectAtIndex:randitn];
        NSMutableString *stringForLabel = [NSMutableString stringWithFormat:@"%@\n%@",quoteString,attString];
        NSMutableAttributedString* attributedString = [[NSMutableAttributedString alloc] initWithString:stringForLabel];
        [attributedString beginEditing];
        [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, [quoteString length])];
        NSMutableParagraphStyle *paragrahStyle = [[NSMutableParagraphStyle alloc] init];
        [paragrahStyle setLineSpacing:10];
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragrahStyle range:NSMakeRange(0, [stringForLabel length])];
        [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:179/255.0 green:233/255.0 blue:237/255.0 alpha:1.0f] range:NSMakeRange([quoteString length], [attString length] + 1)];
        [attributedString endEditing];
        quoteLabel.attributedText = attributedString;
        quoteLabel.textAlignment = NSTextAlignmentLeft;
    }
    else{
        int i = arc4random_uniform((int)[obj.quoteData count]);
        
        NSString *quoteString = [obj.quoteData objectAtIndex:i];
        attString = [NSString stringWithFormat:@"%@",[obj.quoteAttributeData objectAtIndex:i]];
        NSMutableString *stringForLabel = [NSMutableString stringWithFormat:@"%@\n%@",quoteString,attString];
        NSMutableAttributedString* attributedString = [[NSMutableAttributedString alloc] initWithString:stringForLabel];
        [attributedString beginEditing];
        [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, [quoteString length])];
        NSMutableParagraphStyle *paragrahStyle = [[NSMutableParagraphStyle alloc] init];
        NSMutableParagraphStyle *paragrahStyle2 = [[NSMutableParagraphStyle alloc] init];
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragrahStyle range:NSMakeRange(0, [stringForLabel length])];
        if ([SDiPhoneVersion deviceVersion] == iPhone6) {
            [paragrahStyle setLineSpacing:8];
            [paragrahStyle setParagraphSpacing:12];
            sponsorButton.titleLabel.font = [UIFont systemFontOfSize:14];
            [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange([quoteString length], [attString length] + 1)];
            [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:17] range:NSMakeRange(0, [quoteString length])];
        }
        else if ([SDiPhoneVersion deviceVersion] == iPhone6Plus){
            [paragrahStyle setLineSpacing:8];
            [paragrahStyle setParagraphSpacing:12];
            sponsorButton.titleLabel.font = [UIFont systemFontOfSize:14];
            [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange([quoteString length], [attString length] + 1)];
            [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:19] range:NSMakeRange(0, [quoteString length])];
        }
        else{
            sponsorButton.titleLabel.font = [UIFont systemFontOfSize:12];
            [paragrahStyle setParagraphSpacing:8];
            [paragrahStyle setLineSpacing:5];
            [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:NSMakeRange([quoteString length], [attString length] + 1)];
            [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(0, [quoteString length])];
        }
        [quoteLabel sizeToFit];
        [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:179/255.0 green:233/255.0 blue:237/255.0 alpha:1.0f] range:NSMakeRange([quoteString length], [attString length] + 1)];
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragrahStyle range:NSMakeRange(0, [quoteString length])];
        NSUInteger lengtht = [quoteString length] - 1;
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragrahStyle2 range:NSMakeRange(lengtht,[attString length])];
        [attributedString endEditing];
        
        quoteLabel.attributedText = attributedString;
        quoteLabel.textAlignment = NSTextAlignmentLeft;
        [quoteLabel setNumberOfLines:0];
        [quoteLabel sizeToFit];
    }
    
    //-----------------------------------------------------------------------//
    //------------------------- Send Count Request --------------------------//
    int timestamp = [[NSDate date] timeIntervalSince1970];
    int randomnum = arc4random_uniform(1000000000);
    NSString *concat = [NSString stringWithFormat: @"%d%d%@", timestamp, randomnum, @"GsWpfzremRIZMIRA"];
    NSString *sha256 = [NSString stringWithFormat:@"%@",[concat SHA256]];
    // Adding vars into nsurlqueryitem objects to be passed into components
    NSURLQueryItem *tsItem = [NSURLQueryItem queryItemWithName:@"t" value:[NSString stringWithFormat:@"%d",timestamp]];
    NSURLQueryItem *randItem = [NSURLQueryItem queryItemWithName:@"c" value:[NSString stringWithFormat:@"%d",randomnum]];
    NSURLQueryItem *hashItem = [NSURLQueryItem queryItemWithName:@"s" value: sha256];
    //initializing request
    countRequest = [[NSMutableURLRequest alloc] init];
    countRequest.HTTPMethod= @"POST";
    NSURLComponents *components = [NSURLComponents new];
    [components setScheme:@"http"];
    [components setHost:@"api.wegush.com"];
    [components setQueryItems: @[ tsItem, randItem,hashItem]];
    [components setPath:@"/1to1/count"];
    [countRequest setURL:[components URL]];
    [countRequest setValue:Nil forHTTPHeaderField:@"Content-Length"];
    [countRequest setValue:@"application/x-www-form-urlencoded;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [countRequest setValue:@"XMLHttpRequest" forHTTPHeaderField:@"X-Requested-With"];
    [countRequest setHTTPBody:Nil];
    //send request
    [NSURLConnection connectionWithRequest:countRequest delegate:self];

}
- (void)didReceiveMemoryWarning
{
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    // A response has been received, this is where we initialize the instance var you created
    // so that we can append data to it in the didReceiveData method
    // Furthermore, this method is called each time there is a redirect so reinitializing it
    // also serves to clear it
    
    
    //initialize response (data)
    _responseData = [[NSMutableData alloc] init];
    
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
    count = [json objectForKey:@"gushes_sent"];
    countLabel.text = [NSString stringWithFormat:@"%@",count];
    dataClass *obj = [dataClass getInstance];
    obj.totalGushesSent = [count intValue];
    [[NSUserDefaults standardUserDefaults]setInteger:obj.totalGushesSent forKey:@"total"];
    
}
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
     if ([segue.identifier isEqualToString:@"sponsor2"]) {
         id<GAITracker> tracker = [[GAI sharedInstance] trackerWithTrackingId:@"UA-41894678-4"];
         
         [tracker set:kGAIScreenName value:@"Main Screen"];
         [tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"Sponsor"
                                                               action:@"touch"
                                                                label:@"Done-to-Sponsor"
                                                                value:nil] build]];
         [tracker set:kGAIScreenName value:nil];

     }
}

@end
