//
//  doneViewController.h
//  WeGush
//
//  Created by Daniel Katz on 1/27/15.
//  Copyright (c) 2015 Stratton Apps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface doneViewController : UIViewController<NSURLConnectionDelegate>{
    NSMutableURLRequest *request;
    NSMutableData *_responseData;
    __weak IBOutlet UILabel *countLabel;
    __weak IBOutlet UIImageView *sponsorImage;
    __weak IBOutlet UIButton *sponsorButton;
    __weak IBOutlet UIView *view;
    
    __weak IBOutlet UILabel *attributionLabel;
    __weak IBOutlet UILabel *quoteLabel;
}
@property (weak,nonatomic)NSString *test;
@end
