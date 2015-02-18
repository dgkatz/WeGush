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
        [self.navigationController setValue:[[UINavigationBar alloc]init]forKeyPath:@"navigationBar"];
    _barButton.target = self.revealViewController;
    _barButton.action = @selector(revealToggle:);
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_6_1) {
        iOSVersion = [NSString stringWithFormat:@"iOS version is %f and lower",6.0];
        NSLog(@"%@",iOSVersion);
    } else {
        iOSVersion = [NSString stringWithFormat:@"iOS version is %f and above",7.0];
        NSLog(@"%@",iOSVersion);

    }
    if ([SDiPhoneVersion deviceVersion] == iPhone4){
        device = [NSString stringWithFormat:@"Device: iPhone 4"];
        NSLog(@"%@",device);

        
    }
    else if ([SDiPhoneVersion deviceVersion] == iPhone4S){
        device = [NSString stringWithFormat:@"Device: iPhone 4s"];
        NSLog(@"%@",device);

        
    }
    else if ([SDiPhoneVersion deviceVersion] == iPhone5){
        device = [NSString stringWithFormat:@"Device: iPhone 5"];
        NSLog(@"%@",device);


    }
    else if ([SDiPhoneVersion deviceVersion] == iPhone5S){
        device = [NSString stringWithFormat:@"Device: iPhone 5s"];
        NSLog(@"%@",device);


    }
    else if ([SDiPhoneVersion deviceVersion] == iPhone5C){
        device = [NSString stringWithFormat:@"Device: iPhone 5c"];
        NSLog(@"%@",device);


    }
    else if ([SDiPhoneVersion deviceVersion] == iPhone6){
        device = [NSString stringWithFormat:@"Device: iPhone 6"];
        NSLog(@"%@",device);


    }
    else {
        device = [NSString stringWithFormat:@"Device: iPhone 6 plus"];
        NSLog(@"%@",device);

  
    }
    NSString *emailTitle = @"WeGush Feedback";
    NSString *messageBody = [NSString stringWithFormat:@"%@ , %@ Bug:",iOSVersion,device];
    NSArray *toRecipents = [NSArray arrayWithObject:@"dgkatz@gmail.com"];
    
    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
    mc.mailComposeDelegate = self;
    [mc setSubject:emailTitle];
    [mc setMessageBody:messageBody isHTML:NO];
    [mc setToRecipients:toRecipents];
    
    // Present mail view controller on screen
    mc.navigationBar.tintColor = [UIColor colorWithRed:142/255.0 green:225/255.0 blue:232/255.0 alpha:1.0f];
    
    [self presentViewController:mc animated:YES completion:NULL];

}
- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
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
