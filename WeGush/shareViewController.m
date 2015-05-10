//
//  shareViewController.m
//  WeGush
//
//  Created by Daniel Katz on 3/3/15.
//  Copyright (c) 2015 Stratton Apps. All rights reserved.
//

#import "shareViewController.h"
#import <MessageUI/MessageUI.h>
#import "SWRevealViewController.h"
#import "GAI.h"
#import "GAIDictionaryBuilder.h"
#import "GAIFields.h"
@interface shareViewController ()

@end
NSString *status;
@implementation shareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setValue:[[UINavigationBar alloc]init]forKeyPath:@"navigationBar"];
    id tracker = [[GAI sharedInstance] defaultTracker];
    
    // This screen name value will remain set on the tracker and sent with
    // hits until it is set to a new value or to nil.
    [tracker set:kGAIScreenName
           value:@"Share Screen"];
    
    // manual screen tracking
    [tracker send:[[GAIDictionaryBuilder createScreenView] build]];

    NSString *emailTitle = @"WeGush Feedback";
    NSString *url = @"http://www.WeGush.com";
    NSString *emailBody = [NSString stringWithFormat:@"You should check out WeGush! <a href = '%@'>", url];
    NSArray *toRecipents = Nil;
    
    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
    mc.mailComposeDelegate = self;
    [mc setSubject:emailTitle];
    [mc setMessageBody:emailBody isHTML:YES];
    [mc setToRecipients:toRecipents];
    
    // Present mail view controller on screen
    mc.navigationBar.tintColor = [UIColor colorWithRed:142/255.0 green:225/255.0 blue:232/255.0 alpha:1.0f];
    
    [self presentViewController:mc animated:YES completion:NULL];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/**
-(void)viewDidAppear:(BOOL)animated{
    if ([status isEqualToString:@"next"]) {
        status = @"";
        SWRevealViewController *NVC = [self.storyboard instantiateViewControllerWithIdentifier:@"blah"];
        [self presentViewController:NVC animated:YES completion:nil];
        
    }
}
 **/
- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    
    if (result == MFMailComposeResultCancelled) {
        
        //status = @"next";
    }
    else if (result == MFMailComposeResultSaved){
        //status = @"next";
        
    }
    else if (result == MFMailComposeResultSent){
        //status = @"next";
        
    }
    else{
        //status = @"next";
        
    }
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
    SWRevealViewController *NVC = [self.storyboard instantiateViewControllerWithIdentifier:@"blah"];
    [self presentViewController:NVC animated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
