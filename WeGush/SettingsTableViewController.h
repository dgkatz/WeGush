//
//  SettingsTableViewController.h
//  WeGush
//
//  Created by Daniel Katz on 1/26/15.
//  Copyright (c) 2015 Stratton Apps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GAITrackedViewController.h"
@interface SettingsTableViewController : UITableViewController
@property(weak,nonatomic) IBOutlet UIBarButtonItem *barButton;
@property (nonatomic, retain) NSIndexPath* checkedIndexPath;
@property(nonatomic,retain)NSString *repeatSettings;
@end
