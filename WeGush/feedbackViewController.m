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
    
    

}
-(void)viewDidAppear:(BOOL)animated{
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    
    [tracker set:kGAIScreenName value:nil];
    [tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"Rate This App"
                                                          action:@"menu"
                                                           label:nil
                                                           value:nil] build]];
    [tracker set:kGAIScreenName value:nil];
    NSString *iTunesLink = @"itms://itunes.apple.com/app/id984121643";
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:iTunesLink]];
    SWRevealViewController *NVC = [self.storyboard instantiateViewControllerWithIdentifier:@"blah"];
    [self presentViewController:NVC animated:YES completion:nil];
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
