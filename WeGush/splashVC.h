//
//  splashVC.h
//  WeGush
//
//  Created by Daniel Katz on 2/17/15.
//  Copyright (c) 2015 Stratton Apps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface splashVC : UIViewController{
    UIImage *image;
    NSTimer *timer;
}
@property (weak, nonatomic) IBOutlet UIImageView *splash;

@end
