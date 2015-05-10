//
//  bugViewController.m
//  WeGush
//
//  Created by Daniel Katz on 2/14/15.
//  Copyright (c) 2015 Stratton Apps. All rights reserved.
//

#import "bugViewController.h"
#import "SWRevealViewController.h"
#import "SDiPhoneVersion.h"
#import "SWRevealViewController.h"
#import "initNavController.h"
#import "GAI.h"
#import "GAIDictionaryBuilder.h"
#import "GAIFields.h"
@implementation bugViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    id tracker = [[GAI sharedInstance] defaultTracker];
    
    // This screen name value will remain set on the tracker and sent with
    // hits until it is set to a new value or to nil.
    [tracker set:kGAIScreenName
           value:@"Feedback Screen"];
    
    // manual screen tracking
    [tracker send:[[GAIDictionaryBuilder createScreenView] build]];

        [self.navigationController setValue:[[UINavigationBar alloc]init]forKeyPath:@"navigationBar"];
        if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_6_1) {
        iOSVersion = [NSString stringWithFormat:@"iOS version is %f and lower",6.0];
    } else {
        iOSVersion = [NSString stringWithFormat:@"iOS version is %f and above",7.0];

    }
    if ([SDiPhoneVersion deviceVersion] == iPhone4){
        device = [NSString stringWithFormat:@"Device: iPhone 4"];

        
    }
    else if ([SDiPhoneVersion deviceVersion] == iPhone4S){
        device = [NSString stringWithFormat:@"Device: iPhone 4s"];

        
    }
    else if ([SDiPhoneVersion deviceVersion] == iPhone5){
        device = [NSString stringWithFormat:@"Device: iPhone 5"];


    }
    else if ([SDiPhoneVersion deviceVersion] == iPhone5S){
        device = [NSString stringWithFormat:@"Device: iPhone 5s"];


    }
    else if ([SDiPhoneVersion deviceVersion] == iPhone5C){
        device = [NSString stringWithFormat:@"Device: iPhone 5c"];


    }
    else if ([SDiPhoneVersion deviceVersion] == iPhone6){
        device = [NSString stringWithFormat:@"Device: iPhone 6"];


    }
    else {
        device = [NSString stringWithFormat:@"Device: iPhone 6 plus"];

  
    }
    NSString *emailTitle = @"WeGush Feedback";
    NSString *messageBody = [NSString stringWithFormat:@"\n\n\n\n\n----------------------------\nDevice Details:\n Platform: %@\n%@\nApp Version: 1.12\nBug:",iOSVersion,device];
    NSArray *toRecipents = [NSArray arrayWithObject:@"info@WeGush.com"];
    
    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
    mc.mailComposeDelegate = self;
    [mc setSubject:emailTitle];
    [mc setMessageBody:messageBody isHTML:NO];
    [mc setToRecipients:toRecipents];
    
    // Present mail view controller on screen
    mc.navigationBar.tintColor = [UIColor colorWithRed:142/255.0 green:225/255.0 blue:232/255.0 alpha:1.0f];
    
    [self presentViewController:mc animated:YES completion:NULL];

}
-(void)viewDidAppear:(BOOL)animated{
    if ([status isEqualToString:@"next"]) {
        status = @"";
        SWRevealViewController *NVC = [self.storyboard instantiateViewControllerWithIdentifier:@"blah"];
        [self presentViewController:NVC animated:YES completion:nil];

    }
}
- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    
    if (result == MFMailComposeResultCancelled) {
        
        status = @"next";
    }
    else if (result == MFMailComposeResultSaved){
        status = @"next";

    }
    else if (result == MFMailComposeResultSent){
        status = @"next";

    }
    else{
        status = @"next";

    }
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
