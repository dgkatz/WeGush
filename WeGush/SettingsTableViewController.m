//
//  SettingsTableViewController.m
//  WeGush
//
//  Created by Daniel Katz on 1/26/15.
//  Copyright (c) 2015 Stratton Apps. All rights reserved.
//

#import "SettingsTableViewController.h"
#import "SWRevealViewController.h"
#import "GAI.h"
#import "GAIDictionaryBuilder.h"
#import "GAIFields.h"
#import "GAITrackedViewController.h"
#import "dataClass.h"
@interface SettingsTableViewController ()

@end
NSArray *array1;
NSArray *array2;
NSArray *array3;
NSString *day;
NSString *week;
NSString *month;
NSString *year;
NSString *noteBody;
NSCalendarUnit *repeatIntervel;

int i;
@implementation SettingsTableViewController

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
    id tracker = [[GAI sharedInstance] defaultTracker];
    
    // This screen name value will remain set on the tracker and sent with
    // hits until it is set to a new value or to nil.
    [tracker set:kGAIScreenName
           value:@"Settings Screen"];
    
    // manual screen tracking
    [tracker send:[[GAIDictionaryBuilder createScreenView] build]];
    [self.navigationController setValue:[[UINavigationBar alloc]init]forKeyPath:@"navigationBar"];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    _barButton.target = self.revealViewController;
    _barButton.action = @selector(revealToggle:);
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    array1 = [NSArray arrayWithObjects: @"Once a day",@"Every few days",@"Once a week",@"Never", nil];
}

-(void)viewDidAppear:(BOOL)animated{
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.

        return [array1 count];

    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    dataClass *obj = [dataClass getInstance];
    NSString *reminderBody;
    if ([obj.reminderData count] == 0) {
        reminderBody = @"Don't forget to send a Gush!";
    }
    else{
        int r = arc4random_uniform([obj.reminderData count]);
        reminderBody = [NSString stringWithFormat:@"%@",[obj.reminderData objectAtIndex:r]];
    }
    // Uncheck the previous checked row
    if(self.checkedIndexPath)
    {
        UITableViewCell* uncheckCell = [tableView
                                        cellForRowAtIndexPath:self.checkedIndexPath];
        uncheckCell.accessoryType = UITableViewCellAccessoryNone;
        
        [[UIApplication sharedApplication] cancelAllLocalNotifications];
        
        
    }
    if([self.checkedIndexPath isEqual:indexPath])
    {
        self.checkedIndexPath = nil;
    }
    else{
        UITableViewCell* cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        self.checkedIndexPath = indexPath;
        if (indexPath.row == 0) {
            NSLog(@"path = 0");
            _repeatSettings = @"day";
            UILocalNotification* localNotification = [[UILocalNotification alloc] init];
            localNotification.fireDate = [NSDate dateWithTimeIntervalSinceNow:360];
            localNotification.repeatInterval = NSDayCalendarUnit;
            localNotification.alertBody = reminderBody;
            localNotification.alertAction = @"Show me the item";
            localNotification.timeZone = [NSTimeZone defaultTimeZone];
            localNotification.applicationIconBadgeNumber = [[UIApplication sharedApplication] applicationIconBadgeNumber] + 1;
            
            [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
        }
        else if (indexPath.row == 1){
            NSLog(@"path = 1");
            _repeatSettings = @"every few days";
            UILocalNotification* localNotification = [[UILocalNotification alloc] init];
            localNotification.fireDate = [NSDate dateWithTimeIntervalSinceNow:360];
            localNotification.repeatInterval = NSDayCalendarUnit;
            localNotification.alertBody = reminderBody;
            localNotification.alertAction = @"Show me the item";
            localNotification.timeZone = [NSTimeZone defaultTimeZone];
            localNotification.applicationIconBadgeNumber = [[UIApplication sharedApplication] applicationIconBadgeNumber] + 1;
            
            [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
            
        }
        else if (indexPath.row == 2){
            NSLog(@"path = 2");
            _repeatSettings = @"once a week";
            UILocalNotification* localNotification = [[UILocalNotification alloc] init];
            localNotification.fireDate = [NSDate dateWithTimeIntervalSinceNow:360];
            localNotification.repeatInterval = NSWeekCalendarUnit;
            localNotification.alertBody = reminderBody;
            localNotification.alertAction = @"Show me the item";
            localNotification.timeZone = [NSTimeZone defaultTimeZone];
            localNotification.applicationIconBadgeNumber = [[UIApplication sharedApplication] applicationIconBadgeNumber] + 1;
            
            [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
            
        }
        else if (indexPath.row == 3){
            NSLog(@"path = 3");
            _repeatSettings = @"never";
            UILocalNotification* localNotification = [[UILocalNotification alloc] init];
            localNotification.fireDate = [NSDate dateWithTimeIntervalSinceNow:120];
            localNotification.repeatInterval = NSYearCalendarUnit;
            localNotification.alertBody = reminderBody;
            localNotification.alertAction = @"Show me the item";
            localNotification.timeZone = [NSTimeZone defaultTimeZone];
            localNotification.applicationIconBadgeNumber = [[UIApplication sharedApplication] applicationIconBadgeNumber] + 1;
            
            [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
            
        }
        else{
             [[UIApplication sharedApplication] cancelAllLocalNotifications];
        }
        
        
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
        cell.textLabel.text = [array1 objectAtIndex:indexPath.row];
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        if([self.checkedIndexPath isEqual:indexPath])
        {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
        else
        {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }

    return cell;
    
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    return @"Reminder Frequency";

    
}
@end
