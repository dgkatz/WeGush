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
    NSMutableURLRequest *countRequest;
    NSMutableData *_responseData;
    __weak IBOutlet UILabel *countLabel;
    __weak IBOutlet UIImageView *sponsorImage;
    __weak IBOutlet UIButton *sponsorButton;
    __weak IBOutlet UILabel *quoteLabel;
    __weak IBOutlet UIImageView *quoteImage;
    __weak IBOutlet UILabel *paragraphLabel;
    IBOutlet UILabel *gushesSent;
}
@property (strong, nonatomic) IBOutlet UIImageView *sponsorImageView;
@property (weak,nonatomic)NSString *test;
@property (weak, nonatomic) IBOutlet UIView *gushView;

@end
