//
//  sonsorWVViewController.m
//  WeGush
//
//  Created by Daniel Katz on 1/27/15.
//  Copyright (c) 2015 Stratton Apps. All rights reserved.
//

#import "sonsorWVViewController.h"
#import "SWRevealViewController.h"
#import "dataClass.h"
#import "GAIFields.h"
#import "GAI.h"
#import "GAIDictionaryBuilder.h"
@interface sonsorWVViewController ()

@end

@implementation sonsorWVViewController

-(BOOL) webView:(UIWebView *)inWeb shouldStartLoadWithRequest:(NSURLRequest *)inRequest navigationType:(UIWebViewNavigationType)inType {
    if ( inType == UIWebViewNavigationTypeLinkClicked ) {
        [[UIApplication sharedApplication] openURL:[inRequest URL]];
        return NO;
    }
    
    return YES;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewDidAppear:(BOOL)animated{
    _webView.delegate = self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    BOOL shouldUseServer = [[NSUserDefaults standardUserDefaults]boolForKey:@"useServer"];
    NSArray *sponsorArray = [[NSUserDefaults standardUserDefaults]objectForKey:@"defaultSponsorData"];

    id tracker = [[GAI sharedInstance] defaultTracker];
    
    // This screen name value will remain set on the tracker and sent with
    // hits until it is set to a new value or to nil.
    [tracker set:kGAIScreenName
           value:@"Sponsor Screen"];
    
    // manual screen tracking
    [tracker send:[[GAIDictionaryBuilder createScreenView] build]];

    dataClass *obj = [dataClass getInstance];
    _homeButton.target = self;
    _homeButton.action = @selector(segue);
    NSString *strURL;
    if (shouldUseServer == NO) {
        strURL = [sponsorArray objectAtIndex:3];
        NSLog(@"%@",strURL);
    }
    else{
        strURL = [obj.sponsorInfo objectAtIndex:3];
        NSLog(@"%@",strURL);
    }
    NSURL *url = [NSURL URLWithString:strURL];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:urlRequest];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
-(void)segue{
    SWRevealViewController *vc = (SWRevealViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"blah"];
    [self presentViewController:vc animated:YES completion:nil];
}



- (IBAction)learnMoreClicked:(id)sender {
    dataClass *obj = [dataClass getInstance];
    BOOL shouldUseServer = [[NSUserDefaults standardUserDefaults]boolForKey:@"useServer"];
    NSArray *sponsorArray = [[NSUserDefaults standardUserDefaults]objectForKey:@"defaultSponsorData"];
    NSString *url;
    if (shouldUseServer == NO) {
        url = [sponsorArray objectAtIndex:4];
    }
    else{
        url = [obj.sponsorInfo objectAtIndex:4];
    }
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}
@end
