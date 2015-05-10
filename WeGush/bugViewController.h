//
//  bugViewController.h
//  WeGush
//
//  Created by Daniel Katz on 2/14/15.
//  Copyright (c) 2015 Stratton Apps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
@interface bugViewController : UIViewController<MFMailComposeViewControllerDelegate>{
    NSString *iOSVersion;
    NSString *device;
    NSString *status;
}
@property(weak,nonatomic) IBOutlet UIBarButtonItem *barButton;

@end
