//
//  splashVC.h
//  WeGush
//
//  Created by Daniel Katz on 2/17/15.
//  Copyright (c) 2015 Stratton Apps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface splashVC : UIViewController<NSURLConnectionDelegate>{
    UIImage *image;
    NSTimer *timer;
    NSMutableData *_responseData;

}
@property (weak, nonatomic) IBOutlet UIImageView *splash;
@property (weak, nonatomic)NSMutableArray *messageData;
@end
