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
@interface sonsorWVViewController ()

@end

@implementation sonsorWVViewController

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
    dataClass *obj = [dataClass getInstance];
    _homeButton.target = self;
    _homeButton.action = @selector(segue);
    NSString *strURL = [obj.sponsorInfo objectAtIndex:3];
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



@end
