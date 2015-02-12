//
//  myGushesTableViewController.m
//  WeGush
//
//  Created by Daniel Katz on 1/19/15.
//  Copyright (c) 2015 Stratton Apps. All rights reserved.
//

#import "myGushesTableViewController.h"
#import "dataClass.h"
#import "SWRevealViewController.h"
@interface myGushesTableViewController ()

@end

@implementation myGushesTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _barButton.target = self.revealViewController;
    _barButton.action = @selector(revealToggle:);
    NSLog(@"bar button Created");
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    }

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    dataClass *obj=[dataClass getInstance];
    return [obj.gushesList count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    dataClass *obj = [dataClass getInstance];
    NSString *cellIdentifier = [obj.gushesList objectAtIndex:indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    
    return cell;
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
