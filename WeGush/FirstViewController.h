//
//  FirstViewController.h
//  WeGush
//
//  Created by Family on 1/16/15.
//  Copyright (c) 2015 Stratton Apps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GAITrackedViewController.h"
#import "SWRevealViewController.h"
@interface FirstViewController :GAITrackedViewController<UITableViewDelegate, UITableViewDataSource,SWRevealViewControllerDelegate,UIAlertViewDelegate,NSURLConnectionDelegate>

@property(weak,nonatomic) IBOutlet UIBarButtonItem *barButton;
@property (weak, nonatomic) IBOutlet UITableView *messageTableView;
@property (weak, nonatomic) IBOutlet UINavigationItem *navItem;
@property (strong, nonatomic) IBOutlet UIButton *sponsorButton;
@property (strong, nonatomic)  UIView *shadowView;

@end

