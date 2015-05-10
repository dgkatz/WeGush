//
//  NavigationViewController.h
//  WeGush
//
//  Created by Family on 1/16/15.
//  Copyright (c) 2015 Stratton Apps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Appirater.h"
#import "AppiraterDelegate.h"
#import <MessageUI/MessageUI.h>
@interface NavigationViewController : UITableViewController<AppiraterDelegate,MFMailComposeViewControllerDelegate>{
    NSString *iOSVersion;
    NSString *device;
    NSString *status;
}
@property (strong, nonatomic) IBOutlet UITableView *av;

@end
