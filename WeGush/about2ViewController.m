//
//  about2ViewController.m
//  WeGush
//
//  Created by Daniel Katz on 3/31/15.
//  Copyright (c) 2015 Stratton Apps. All rights reserved.
//

#import "about2ViewController.h"
#import "SWRevealViewController.h"
#import "GAI.h"
#import "GAITrackedViewController.h"
#import "GAIDictionaryBuilder.h"
#import "GAIFields.h"
#import "SDiPhoneVersion.h"
@interface about2ViewController (){
    NSArray *menu;
    NSArray *menu2;
    
    
}

@end

@implementation about2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.aboutScrollView.delegate = self;
    self.aboutScrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height);
    self.aboutScrollView.scrollEnabled = YES;
    menu = @[@"1",@"2",@"3"];
    menu2 = @[@"4"];
    [self.navigationController setValue:[[UINavigationBar alloc]init]forKeyPath:@"navigationBar"];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    NSInteger count;
    if (section == 0) {
        count = [menu count];
        
    }
    else if (section == 1){
        count =  [menu2 count];
    }
    return count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentifier;
    if (indexPath.section == 0) {
        cellIdentifier = [menu objectAtIndex:indexPath.row];
    }
    else{
        cellIdentifier = [menu2 objectAtIndex:indexPath.row];
        
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSURL *url;
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
            
            [tracker set:kGAIScreenName value:nil];
            [tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"About"
                                                                  action:@"Touch"
                                                                   label:@"Website"
                                                                   value:nil] build]];
            [tracker set:kGAIScreenName value:nil];
            UIApplication *mySafari = [UIApplication sharedApplication];
            url = [NSURL URLWithString:@"http://www.WeGush.com"];
            [mySafari openURL:url];
        }
        else if (indexPath.row == 1){
            id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
            
            [tracker set:kGAIScreenName value:nil];
            [tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"About"
                                                                  action:@"Touch"
                                                                   label:@"Twitter"
                                                                   value:nil] build]];
            [tracker set:kGAIScreenName value:nil];
            UIApplication *mySafari = [UIApplication sharedApplication];
            url = [NSURL URLWithString:@"https://twitter.com/wegush"];
            [mySafari openURL:url];
        }
        else if (indexPath.row == 2){
            id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
            
            [tracker set:kGAIScreenName value:nil];
            [tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"About"
                                                                  action:@"Touch"
                                                                   label:@"Facebook"
                                                                   value:nil] build]];
            [tracker set:kGAIScreenName value:nil];
            if( [[UIApplication sharedApplication]
                 canOpenURL:[NSURL URLWithString:@"fb://"]] )
            {
                NSURL *url = [NSURL URLWithString:@"fb://profile/241183186020806"];
                [[UIApplication sharedApplication] openURL:url];
            }
            else{
                UIApplication *mySafari = [UIApplication sharedApplication];
                url = [NSURL URLWithString:@"https://www.facebook.com/WeGush1"];
                [mySafari openURL:url];
            }
        }
        
    }
    else{
        id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
        
        [tracker set:kGAIScreenName value:nil];
        [tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"About"
                                                              action:@"Touch"
                                                               label:@"Terms"
                                                               value:nil] build]];
        [tracker set:kGAIScreenName value:nil];
        //        SWRevealViewController *NVC = [self.storyboard instantiateViewControllerWithIdentifier:@"blah"];
        //        [self presentViewController:NVC animated:YES completion:nil];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.wegush.com/terms.html"]];
    }
    
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
