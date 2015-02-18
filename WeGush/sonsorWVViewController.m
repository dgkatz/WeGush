//
//  sonsorWVViewController.m
//  WeGush
//
//  Created by Daniel Katz on 1/27/15.
//  Copyright (c) 2015 Stratton Apps. All rights reserved.
//

#import "sonsorWVViewController.h"
#import "SWRevealViewController.h"
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
    _homeButton.target = self;
    _homeButton.action = @selector(segue);
    NSString *strURL = @"http://www.brighamandwomens.org";
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
