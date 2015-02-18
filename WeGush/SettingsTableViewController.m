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
    [self.navigationController setValue:[[UINavigationBar alloc]init]forKeyPath:@"navigationBar"];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    _barButton.target = self.revealViewController;
    _barButton.action = @selector(revealToggle:);
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    array1 = [NSArray arrayWithObjects: @"Day",@"Week",@"Month",@"Year",@"Never", nil];
    array2 = [NSArray arrayWithObjects:@"Allow Google Analytics", nil];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (section==0)
    {
        return [array1 count];
    }
    else {
        return [array2 count];
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
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
            UILocalNotification* localNotification = [[UILocalNotification alloc] init];
            localNotification.fireDate = [NSDate dateWithTimeIntervalSinceNow:5];
            localNotification.repeatInterval = NSMinuteCalendarUnit;
            localNotification.alertBody = @"Daily Reminder To Send A Gush";
            localNotification.alertAction = @"Show me the item";
            localNotification.timeZone = [NSTimeZone defaultTimeZone];
            localNotification.applicationIconBadgeNumber = [[UIApplication sharedApplication] applicationIconBadgeNumber] + 1;
            
            [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
        }
        else if (indexPath.row == 1){
            NSLog(@"path = 1");
            UILocalNotification* localNotification = [[UILocalNotification alloc] init];
            localNotification.fireDate = [NSDate dateWithTimeIntervalSinceNow:120];
            localNotification.repeatInterval = NSWeekCalendarUnit;
            localNotification.alertBody = @"Weekly Reminder To Send A Gush";
            localNotification.alertAction = @"Show me the item";
            localNotification.timeZone = [NSTimeZone defaultTimeZone];
            localNotification.applicationIconBadgeNumber = [[UIApplication sharedApplication] applicationIconBadgeNumber] + 1;
            
            [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
            
        }
        else if (indexPath.row == 2){
            NSLog(@"path = 2");
            UILocalNotification* localNotification = [[UILocalNotification alloc] init];
            localNotification.fireDate = [NSDate dateWithTimeIntervalSinceNow:120];
            localNotification.repeatInterval = NSMonthCalendarUnit;
            localNotification.alertBody = @"Monthly Reminder To Send A Gush";
            localNotification.alertAction = @"Show me the item";
            localNotification.timeZone = [NSTimeZone defaultTimeZone];
            localNotification.applicationIconBadgeNumber = [[UIApplication sharedApplication] applicationIconBadgeNumber] + 1;
            
            [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
            
        }
        else if (indexPath.row == 3){
            NSLog(@"path = 3");
            UILocalNotification* localNotification = [[UILocalNotification alloc] init];
            localNotification.fireDate = [NSDate dateWithTimeIntervalSinceNow:120];
            localNotification.repeatInterval = NSYearCalendarUnit;
            localNotification.alertBody = @"Yearly Reminder To Send A Gush";
            localNotification.alertAction = @"Show me the item";
            localNotification.timeZone = [NSTimeZone defaultTimeZone];
            localNotification.applicationIconBadgeNumber = [[UIApplication sharedApplication] applicationIconBadgeNumber] + 1;
            
            [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
            
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
    if (indexPath.section==0) {
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
        
    }
    else if(indexPath.section==1){
        cell.textLabel.text = [array2 objectAtIndex:indexPath.row];
        
    }
    return cell;
    
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    if(section == 0){
        return @"Reminder Frequency";
    }
    else {
        return @"More";
    }
    
}
@end
