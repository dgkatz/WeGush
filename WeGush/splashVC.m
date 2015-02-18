//
//  splashVC.m
//  WeGush
//
//  Created by Daniel Katz on 2/17/15.
//  Copyright (c) 2015 Stratton Apps. All rights reserved.
//

#import "splashVC.h"
#import "SDiPhoneVersion.h"
#import "editNavViewController.h"
@implementation splashVC
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if ([SDiPhoneVersion deviceVersion] == iPhone4){
        image = [UIImage imageNamed:@"iPhone4.png"];
        _splash.image = image;
        [self startTimerMethod];
    }
    else if ([SDiPhoneVersion deviceVersion] == iPhone4S){
        image = [UIImage imageNamed:@"iPhone4.png"];
        _splash.image = image;
        [self startTimerMethod];
    }
    else if ([SDiPhoneVersion deviceVersion] == iPhone5){
        image = [UIImage imageNamed:@"iPhone5.png"];
        _splash.image = image;
        [self startTimerMethod];
    }
    else if ([SDiPhoneVersion deviceVersion] == iPhone5S){
        image = [UIImage imageNamed:@"iPhone5.png"];
        _splash.image = image;
        [self startTimerMethod];
    }
    else if ([SDiPhoneVersion deviceVersion] == iPhone5C){
        image = [UIImage imageNamed:@"iPhone5.png"];
        _splash.image = image;
        [self startTimerMethod];
    }
    else if ([SDiPhoneVersion deviceVersion] == iPhone6){
        image = [UIImage imageNamed:@"iPhone6.png"];
        _splash.image = image;
        [self startTimerMethod];
    }
    else {
        image = [UIImage imageNamed:@"iPhone6plus.png"];
        _splash.image = image;
        [self startTimerMethod];
    }
    


}
-(void)startTimerMethod{
    timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(next) userInfo:nil repeats:NO];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)next{
    [timer invalidate];
    [self performSegueWithIdentifier:@"beginApp" sender:self];
}
@end
