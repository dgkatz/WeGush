//
//  feedbackViewController.m
//  WeGush
//
//  Created by Daniel Katz on 1/25/15.
//  Copyright (c) 2015 Stratton Apps. All rights reserved.
//

#import "feedbackViewController.h"
#import <MessageUI/MessageUI.h>
#import "SWRevealViewController.h"
#import "GAIFields.h"
#import "GAI.h"
#import "GAIDictionaryBuilder.h"
@interface feedbackViewController ()

@end

@implementation feedbackViewController

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
    _barButton.target = self.revealViewController;
    _barButton.action = @selector(revealToggle:);
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    NSString *emailTitle = @"WeGush Issue";
    NSString *messageBody = nil;
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
    UIAlertView *thanks = [[UIAlertView alloc]initWithTitle:@"Thankyou for the feedback" message:@"Your feedback is valued and encouraged, help us be better so you can be happier!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [thanks show];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
