//
//  gushEditViewController.m
//  WeGush
//
//  Created by Family on 1/16/15.
//  Copyright (c) 2015 Stratton Apps. All rights reserved.
//
#import "dataClass.h"
#import "gushEditViewController.h"
#import "FirstViewController.h"
#import "SWRevealViewController.h"
#import "doneViewController.h"
#import <MessageUI/MessageUI.h>
#import "doneNavViewController.h"
#import "GAIDictionaryBuilder.h"
#import "GAI.h"
#import "GAIFields.h"
#import <QuartzCore/QuartzCore.h>
@interface gushEditViewController ()<UITextViewDelegate,MFMailComposeViewControllerDelegate,MFMessageComposeViewControllerDelegate, UIActionSheetDelegate>
@end
NSString *extraString;
NSString *string;
NSString *str;
@implementation gushEditViewController
@synthesize chosenImage;
@synthesize gushImageView;
int *num;
- (void)viewDidLoad {
    [super viewDidLoad];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(resignKeyboard:)];
    
    [self.view addGestureRecognizer:tap];
    [extraTextTF setDelegate:self];
    extraString = [[NSString alloc]init];
    dataClass *obj = [dataClass getInstance];
    str = obj.chosenGush;
    chosenImage = [UIImage imageNamed:str];
    [gushImageView setImage:chosenImage];
    NSLog(@"this is the chosen gush %@",obj.chosenGush);
    
    

}
-(void)viewDidAppear:(BOOL)animated{
    if ([string  isEqual: @"done"]) {
        doneNavViewController *NVC = [self.storyboard instantiateViewControllerWithIdentifier:@"done"];
        [self presentViewController:NVC animated:YES completion:nil];
        string = @"nil";
    }

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    switch (result) {
        case MessageComposeResultCancelled:
            NSLog(@"Message was cancelled");
            [self dismissViewControllerAnimated:YES completion:NULL];             break;
        case MessageComposeResultFailed:
            NSLog(@"Message failed");
            [self viewDidLoad];
            [self dismissViewControllerAnimated:YES completion:NULL];             break;
        case MessageComposeResultSent:
            NSLog(@"Message was sent");
            string=@"done";
            [self dismissViewControllerAnimated:YES completion:NULL];
            break;
        default:             
            break;     
    } 
}
- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result) {
        case MFMailComposeResultCancelled:{
            NSLog(@"Message was cancelled");
            [self dismissViewControllerAnimated:YES completion:NULL];             break;
        }
        case MFMailComposeResultFailed:{
            NSLog(@"Message failed");
            [self viewDidLoad];
            UIAlertView *mailFail = [[UIAlertView alloc]initWithTitle:@"Oh No!" message:[NSString stringWithFormat:@"We Could Not send Your Message Becasue %@",[error localizedDescription]] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"Try Again", nil];
            [mailFail setTag:2];
            [mailFail show];

            [self dismissViewControllerAnimated:YES completion:NULL];
            break;
        }
        case MFMailComposeResultSent:{
            NSLog(@"Message was sent");
            string = @"done";
            [self dismissViewControllerAnimated:YES completion:NULL];
            break;
        }
        case MFMailComposeResultSaved:{
            NSLog(@"Message was saved");
            [self dismissViewControllerAnimated:YES completion:NULL];
            break;
        default:
            break;
        }
    }
}
- (IBAction)sendGush:(id)sender {

    UIActionSheet *popup = [[UIActionSheet alloc] initWithTitle:@"Select Sending option" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:
                            @"Email",
                            @"Text",
                            @"Save To Camera Roll",
                            nil];
    [popup showInView:[UIApplication sharedApplication].keyWindow];

}
- (void)actionSheet:(UIActionSheet *)popup clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 0){
        NSString *methodOfSending = @"Email";
        id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
        
        [tracker set:kGAIScreenName value:@"Preview Screen"];
        [tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"UX"
                                                              action:@"touch"
                                                               label:methodOfSending
                                                               value:nil] build]];
        [tracker set:kGAIScreenName value:nil];
        NSString *emailTitle = @"WeGush For You!";
        NSString *messageBody = extraTextTF.text;
        NSArray *toRecipents = nil;
        
        MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
        mc.mailComposeDelegate = self;
        [mc setSubject:emailTitle];
        [mc setMessageBody:messageBody isHTML:NO];
        [mc setToRecipients:toRecipents];
        mc.navigationBar.tintColor = [UIColor colorWithRed:142/255.0 green:225/255.0 blue:232/255.0 alpha:1.0f];
        // Present mail view controller on screen
        UIImage *gushImage = [UIImage imageNamed:str];
        NSData *myData = UIImagePNGRepresentation(gushImage);
        [mc addAttachmentData:myData mimeType:@"image/png" fileName:str];
        (NSLog(@"%@",str));
        [self presentViewController:mc animated:YES completion:NULL];
    }
    else if (buttonIndex == 1) {
        NSLog(@"text selected");
        NSString *methodOfSending = @"Text";
        id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
        
        [tracker set:kGAIScreenName value:@"Preview Screen"];
        [tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"UX"
                                                              action:@"touch"
                                                               label:methodOfSending
                                                               value:nil] build]];
        [tracker set:kGAIScreenName value:nil];
        MFMessageComposeViewController *messageVC = [[MFMessageComposeViewController alloc] init];
        
        messageVC.body = extraTextTF.text;
        messageVC.recipients = nil;
        messageVC.messageComposeDelegate = self;
        
        UIImage *gushImage = [UIImage imageNamed:str];
        NSData *data = UIImagePNGRepresentation(gushImage);
        [messageVC addAttachmentData:data typeIdentifier:@"image/png" filename:str];
        messageVC.navigationBar.tintColor = [UIColor colorWithRed:142/255.0 green:225/255.0 blue:232/255.0 alpha:1.0f];
        [self presentViewController:messageVC animated:YES completion:NULL];
    }
    else if (buttonIndex == 2){
        UIImage *image = [UIImage imageNamed:str];
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
        UIAlertView *saved = [[UIAlertView alloc]initWithTitle:@"Your GUsh Has Been Saved To Your Camera Roll!" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [saved show];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        return;
    }
    else{
        doneNavViewController *NVC = [self.storyboard instantiateViewControllerWithIdentifier:@"done"];
        [self presentViewController:NVC animated:YES completion:nil];
    }
}



- (IBAction)resignKeyboard:(id)sender {
    [extraTextTF resignFirstResponder];

}
@end
