//
//  feedbackViewController.h
//  WeGush
//
//  Created by Daniel Katz on 1/25/15.
//  Copyright (c) 2015 Stratton Apps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
@interface feedbackViewController : UIViewController<MFMailComposeViewControllerDelegate>

@property(weak,nonatomic) IBOutlet UIBarButtonItem *barButton;
@end
