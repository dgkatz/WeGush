//
//  about2ViewController.h
//  WeGush
//
//  Created by Daniel Katz on 3/31/15.
//  Copyright (c) 2015 Stratton Apps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface about2ViewController : UIViewController<UITableViewDataSource,UITableViewDataSource,UIScrollViewDelegate>
@property (strong, nonatomic) IBOutlet UIScrollView *aboutScrollView;
@property (strong, nonatomic) IBOutlet UITableView *infoTable;

@end
