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
@property (nonatomic) NSInteger *selectedRow;
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
    NSLog(@"View did load");
    self.tableView.scrollEnabled = NO;
    id tracker = [[GAI sharedInstance] defaultTracker];
    
    // This screen name value will remain set on the tracker and sent with
    // hits until it is set to a new value or to nil.
    [tracker set:kGAIScreenName
           value:@"Settings Screen"];
    
    // manual screen tracking
    [tracker send:[[GAIDictionaryBuilder createScreenView] build]];
    [self.navigationController setValue:[[UINavigationBar alloc]init]forKeyPath:@"navigationBar"];
    //self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    _barButton.target = self.revealViewController;
    _barButton.action = @selector(revealToggle:);
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    array1 = [NSArray arrayWithObjects: @"Once a day",@"Once a week",@"Once a month",@"Never",@"Use server intereaction", nil];
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
    BOOL shouldUseServer = [[NSUserDefaults standardUserDefaults]boolForKey:@"useServer"];
        dataClass *obj = [dataClass getInstance];
        // Uncheck the previous checked row
    if (indexPath.row < 4) {
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
            int row = (int)self.checkedIndexPath.row;
            int section = (int)self.checkedIndexPath.section;
            [[NSUserDefaults standardUserDefaults] setInteger:row forKey:@"row"];
            [[NSUserDefaults standardUserDefaults] setInteger:section forKey:@"section"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            NSString *randReminder;
            if (shouldUseServer == NO) {
                NSArray *reminderArray =[[NSArray alloc]initWithArray:[[NSUserDefaults standardUserDefaults]objectForKey:@"defaultReminderData"]];
                int rand = arc4random_uniform([reminderArray count]);
                randReminder = [reminderArray objectAtIndex:rand];
            }
            else{
                int rand = arc4random_uniform((int)[obj.reminderData count]);
                randReminder = [obj.reminderData objectAtIndex:rand];
            }
            if (indexPath.row == 0) {
                [[UIApplication sharedApplication] cancelAllLocalNotifications];
                _repeatSettings = @"day";
                obj.twiceADay = 0;
                [[NSUserDefaults standardUserDefaults] setInteger:obj.twiceADay forKey:@"2"];
                [[NSUserDefaults standardUserDefaults]setObject:_repeatSettings forKey:@"repeatSettings"];
                [[NSUserDefaults standardUserDefaults]synchronize];
                UILocalNotification* localNotification = [[UILocalNotification alloc] init];
                localNotification.fireDate = [NSDate
                                              dateWithTimeIntervalSinceNow:86400];//86400
                localNotification.repeatInterval = NSDayCalendarUnit;
                localNotification.alertBody = randReminder;
                localNotification.alertAction = @"Show me the item";
                localNotification.timeZone = [NSTimeZone defaultTimeZone];
                localNotification.applicationIconBadgeNumber = [[UIApplication sharedApplication] applicationIconBadgeNumber] + 1;
                [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
            }
            else if (indexPath.row == 1){
                [[UIApplication sharedApplication] cancelAllLocalNotifications];
                obj.twiceADay = 0;
                [[NSUserDefaults standardUserDefaults] setInteger:obj.twiceADay forKey:@"2"];
                _repeatSettings = @"once a week";
                [[NSUserDefaults standardUserDefaults]setObject:_repeatSettings forKey:@"repeatSettings"];
                UILocalNotification* localNotification = [[UILocalNotification alloc] init];
                localNotification.fireDate = [NSDate dateWithTimeIntervalSinceNow:604800];
                localNotification.repeatInterval = NSWeekCalendarUnit;
                localNotification.alertBody = randReminder;
                localNotification.alertAction = @"Show me the item";
                localNotification.timeZone = [NSTimeZone defaultTimeZone];
                localNotification.applicationIconBadgeNumber = [[UIApplication sharedApplication] applicationIconBadgeNumber] + 1;
                [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
                [[NSUserDefaults standardUserDefaults]synchronize];
                
            }
            else if (indexPath.row == 2){
                [[UIApplication sharedApplication] cancelAllLocalNotifications];
                obj.twiceADay = 0;
                [[NSUserDefaults standardUserDefaults] setInteger:obj.twiceADay forKey:@"2"];
                _repeatSettings = @"once a month";
                [[NSUserDefaults standardUserDefaults]setObject:_repeatSettings forKey:@"repeatSettings"];
                UILocalNotification* localNotification = [[UILocalNotification alloc] init];
                localNotification.fireDate = [NSDate dateWithTimeIntervalSinceNow:2592000];
                localNotification.repeatInterval = NSMonthCalendarUnit;
                localNotification.alertBody = randReminder;
                localNotification.alertAction = @"Show me the item";
                localNotification.timeZone = [NSTimeZone defaultTimeZone];
                localNotification.applicationIconBadgeNumber = [[UIApplication sharedApplication] applicationIconBadgeNumber] + 1;
                [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
                [[NSUserDefaults standardUserDefaults]synchronize];
                
            }
            else{
                obj.twiceADay = 0;
                [[NSUserDefaults standardUserDefaults] setInteger:obj.twiceADay forKey:@"2"];
                [[UIApplication sharedApplication] cancelAllLocalNotifications];
            }
            [tableView deselectRowAtIndexPath:indexPath animated:YES];
            [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            
        }

    }
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Will dislpay cell called");

        if (indexPath.row == 1) {
            //indent = cell.textLabel.frame.origin.x;
        }
        
        // Remove seperator inset
        if (indexPath.row == 3) {
            [cell setSeparatorInset:UIEdgeInsetsZero];
            [cell setPreservesSuperviewLayoutMargins:NO];
            [cell setLayoutMargins:UIEdgeInsetsZero];
            
        }
        //[cell.textLabel setFrame: CGRectMake(indent, cell.textLabel.frame.origin.y, cell.textLabel.frame.size.width, cell.textLabel.frame.size.height)];

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }

    if (indexPath.row < 4) {
        
        NSLog(@"Cell for row at index path called");
        cell.textLabel.text = [array1 objectAtIndex:indexPath.row];
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        NSInteger row = [[NSUserDefaults standardUserDefaults] integerForKey:@"row"];
        NSInteger section = [[NSUserDefaults standardUserDefaults] integerForKey:@"section"];
        self.checkedIndexPath = [NSIndexPath indexPathForRow:row inSection:section];
        
        if([self.checkedIndexPath isEqual:indexPath])
        {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
        else
        {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }

    }
    else{
        BOOL shouldUseServer = [[NSUserDefaults standardUserDefaults]boolForKey:@"useServer"];
        cell.textLabel.text = [array1 objectAtIndex:indexPath.row];
        UISwitch* aswitch = [[UISwitch alloc] initWithFrame:CGRectZero];
        aswitch.on = shouldUseServer; // or NO
        aswitch.tag = 12345;
        [aswitch addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
        cell.accessoryView = aswitch;
    }
    return cell;
}
- (void) switchChanged:(id)sender {
    NSLog(@"This method got called");
    UISwitch* switchControl = sender;
    NSLog( @"The switch is %@", switchControl.on ? @"ON" : @"OFF" );
    BOOL shouldUseServer = [[NSUserDefaults standardUserDefaults]boolForKey:@"useServer"];
    shouldUseServer = switchControl.on;
    NSLog(@"%hhd",shouldUseServer);
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"useServer"];
    [[NSUserDefaults standardUserDefaults]setBool:shouldUseServer forKey:@"useServer"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
        return @"REMINDER FREQUENCY";
}
- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(15, 15, tableView.bounds.size.width, 0)];
        UILabel *label = [[UILabel alloc]init];
        label.frame = CGRectMake(15, 30,300, tableView.sectionHeaderHeight);
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor grayColor];
        label.font = [UIFont fontWithName:@"System" size:10.0f];
        label.text = [self tableView:tableView titleForHeaderInSection:section];
        [label setFont:[UIFont systemFontOfSize:13.0]];
        //CGRect sepFrame = CGRectMake(0, self.tableView.sectionHeaderHeight-1, self.tableView.frame.size.width, 1);
        //UIView *seperatorView = [[UIView alloc] initWithFrame:sepFrame];
        //seperatorView.backgroundColor = [UIColor colorWithWhite:224.0/255.0 alpha:1.0];
        //[headerView addSubview:seperatorView];
        //    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(self.view.frame.origin.x,tableView.sectionHeaderHeight, headerView.frame.size.width, .32)];
        //    topView.backgroundColor = [UIColor colorWithRed:224/255 green:224/255 blue:224/255 alpha:1.0f];
        //    [headerView addSubview:topView];
        [headerView addSubview:label];
        return headerView;

}
@end
