//
//  aboutViewController.h
//  WeGush
//
//  Created by Daniel Katz on 1/25/15.
//  Copyright (c) 2015 Stratton Apps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface aboutViewController : UIViewController<UITableViewDataSource,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableview;

@end
