//
//  FirstViewController.m
//  WeGush
//
//  Created by Family on 1/16/15.
//  Copyright (c) 2015 Stratton Apps. All rights reserved.
//

#import "FirstViewController.h"
#import "SWRevealViewController.h"
#import "gushEditViewController.h"
#import "dataClass.h"
#import "GAIDictionaryBuilder.h"
#import "GAI.h"
#import "GAIFields.h"
#import "editNavViewController.h"
#import "gushEditViewController.h"
@interface FirstViewController ()
@end

@implementation FirstViewController{
    NSArray *tableData;
    NSArray *imageArray;
}
@synthesize messageTableView;
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setTranslucent:NO];
    UIImage *image = [UIImage imageNamed:@"logo.png"];
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:image];
    self.screenName = @"Message Screen";
    messageTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
     tableData = [NSArray arrayWithObjects:@"What would I do without you?", @"#SoGr8ful4U",@"You go, girl!",@"You are truly amazing!",@"awesome [aw-suh m] adjective: what you are", @"Your awesomeness is unparalleled.", @"When I grow up....I want to be just like you!", @"I'm so blessed to have you as a friend.", @"Thanks for letting me over-share. You’re a great listener.", @"I cherish the time we spend together.",@"You are my superhero!",@"I owe you big time. Thank you!",@"You’re a lifesaver!",@"We make a spectacular team!",@"Together, we are unstoppable!",@"THX for making me LOL.",@"You make me laugh, even when I want to cry.",@"Awwww, that was so sweet of you!",@"You totally made my day!",@"You made a difference today.", nil];
    
    imageArray = [NSArray arrayWithObjects:@"whatwouldido.png",@"sog8ful4u.png",@"yougogirl.png",@"youareamazing.png",@"awesomewhatuare.png",@"yourawesomeness.png",@"whenigrowup.png",@"iamsoblessed.png",@"thanksforlettingshare.png",@"icherishthetime.png",@"youaremysuperhero.png",@"ioweyoubigtime.png",@"uralifesaver.png",@"wemakeateam.png",@"togetherunstoppable.png",@"thxforlol.png",@"youmakemelaugh.png",@"awwthatwassweet.png",@"youmademyday.png",@"youmadeadifference.png", nil];
    _barButton.target = self.revealViewController;
    _barButton.action = @selector(revealToggle:);
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tableData count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    cell.textLabel.text = [tableData objectAtIndex:indexPath.row];
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.font = [UIFont systemFontOfSize:20];
    cell.textLabel.lineBreakMode = UILineBreakModeWordWrap;
    cell.textLabel.textColor = [UIColor whiteColor];

    return cell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.messageTableView indexPathForSelectedRow];
        id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
        
        [tracker set:kGAIScreenName value:@"Message Screen"];
        [tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"UX"
                                                              action:@"touch"
                                                               label:[tableData objectAtIndex:indexPath.row]
                                    value:nil] build]];
        [tracker set:kGAIScreenName value:nil];
        dataClass *obj = [dataClass getInstance];
        obj.chosenGush = [imageArray objectAtIndex:indexPath.row];
    }
}

@end
