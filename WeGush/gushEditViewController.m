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
#import "UIImageView+WebCache.h"
#import "Reachability.h"
@interface gushEditViewController ()<UITextViewDelegate,MFMailComposeViewControllerDelegate,MFMessageComposeViewControllerDelegate, UIActionSheetDelegate>
@end
Reachability *internetReachableFoo;
NSString *extraString;
NSString *stringState;
NSString *str;
MFMessageComposeViewController *messageVC;
@implementation gushEditViewController
@synthesize chosenImage;
@synthesize gushImageView;
int *num;

- (void)viewDidLoad {
    [super viewDidLoad];
    messageVC = [[MFMessageComposeViewController alloc] init];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSArray *rec = [[NSArray alloc]init];
    rec = [userDefaults arrayForKey:@"imageData"];
    
    stringState = @"";
    dataClass *obj = [dataClass getInstance];
    BOOL shouldUseServer = [[NSUserDefaults standardUserDefaults]boolForKey:@"useServer"];
    if (shouldUseServer == NO) {
        NSArray *savedIMageArray = [[NSUserDefaults standardUserDefaults]objectForKey:@"defualtImageData"];
        NSData* imageData = [savedIMageArray objectAtIndex:obj.chosenIndex];
        UIImage* theIage = [UIImage imageWithData:imageData];
        chosenImage = theIage;
        [gushImageView setImage:chosenImage];
    }
    else{
        NSData* imageData = [rec objectAtIndex:obj.chosenIndex];
        UIImage* theIage = [UIImage imageWithData:imageData];
        chosenImage = theIage;
        [gushImageView setImage:chosenImage];
    }
    
    extraTextTF.layer.cornerRadius=8.0f;
    extraTextTF.layer.masksToBounds=YES;
    extraTextTF.layer.borderColor=[[UIColor colorWithRed:23/255.0 green:149/255.0 blue:165/255.0 alpha:1.0f]CGColor];
    extraTextTF.layer.borderWidth= 0.5f;
    if ([extraTextTF respondsToSelector:@selector(setAttributedPlaceholder:)]) {
        UIColor *color = [UIColor colorWithRed:23/255.0 green:149/255.0 blue:165/255.0 alpha:1.0f];
        extraTextTF.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"+ Add optional text to send with Gush" attributes:@{NSForegroundColorAttributeName: color}];
    } else {
        // TODO: Add fall-back code to set placeholder color.
    }
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(resignKeyboard:)];
    
    [self.view addGestureRecognizer:tap];
    [extraTextTF setDelegate:self];
    extraString = [[NSString alloc]init];
    str = obj.chosenGush;
    //chosenImage = [UIImage imageNamed:str];
    //[gushImageView setImage:chosenImage];
    id tracker = [[GAI sharedInstance] defaultTracker];
    
    // This screen name value will remain set on the tracker and sent with
    // hits until it is set to a new value or to nil.
    [tracker set:kGAIScreenName
           value:@"Preview Screen"];
    
    // manual screen tracking
    [tracker send:[[GAIDictionaryBuilder createScreenView] build]];
    

}
-(void)viewDidAppear:(BOOL)animated{

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    if (result == MessageComposeResultCancelled) {
        NSLog(@"Cancelled");
    }
    else if (result == MessageComposeResultFailed){
        NSLog(@"Failed");
    }
    else{
        stringState = @"done";
        NSLog(@"Sent");
    }

    [self dismissViewControllerAnimated:YES completion:NULL];
}
-(void)viewWillAppear:(BOOL)animated{
    doneNavViewController *NVC = [self.storyboard instantiateViewControllerWithIdentifier:@"done"];
    if ([stringState  isEqualToString: @"done"]) {
        stringState = @"nil";
        [self presentViewController:NVC animated:YES completion:nil];
    }
}
- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result) {
        case MFMailComposeResultCancelled:{
            break;
        }
        case MFMailComposeResultFailed:{
            break;
        }
        case MFMailComposeResultSent:{
            stringState = @"done";
            break;
        }
        case MFMailComposeResultSaved:{
            break;
        default:
            break;
        }
    }
    [self dismissViewControllerAnimated:YES completion:NULL];
}
- (IBAction)sendGush:(id)sender {
    [extraTextTF resignFirstResponder];
    UIActionSheet *popup = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:
                            @"Message",
                            @"Email",
                            @"Save To Camera Roll", @"Copy",
                            nil];
    [popup showInView:[UIApplication sharedApplication].keyWindow];
    stringState = @"nil";

}

- (void)actionSheet:(UIActionSheet *)popup clickedButtonAtIndex:(NSInteger)buttonIndex {
    dataClass *obj = [dataClass getInstance];
    
    if (buttonIndex == 1){
        NSString *methodOfSending = @"Email";
        id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
        
        [tracker set:kGAIScreenName value:@"Preview Screen"];
        [tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"Sent Gushes"
                                                              action:methodOfSending
                                                               label: obj.chosenMessage
                                                               value:nil] build]];
        [tracker set:kGAIScreenName value:nil];
        NSString *emailTitle = @"Here’s a Gush for you!";
        NSString *messageBody = extraTextTF.text;
        NSArray *toRecipents = nil;
        
        BOOL shouldUseServer = [[NSUserDefaults standardUserDefaults]boolForKey:@"useServer"];
        if (shouldUseServer == NO) {
            NSArray *dimgURLS = [[NSUserDefaults standardUserDefaults]objectForKey:@"defualtImageURLData"];
            /*
            MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
            mc.mailComposeDelegate = self;
            [mc setSubject:emailTitle];
            [mc setMessageBody:messageBody isHTML:NO];
            [mc setToRecipients:toRecipents];
            //NSString *path = [[NSBundle mainBundle] pathForResource:@"rainy" ofType:@"png"];
            //NSData *myData = [NSData dataWithContentsOfFile:[NSString stringWithFormat:@"%@",obj.chosenGush]];
            NSData *myData = UIImagePNGRepresentation(self.gushImageView.image);
            [mc addAttachmentData:myData mimeType:@"image/png" fileName:obj.chosenGush];
            mc.navigationBar.tintColor = [UIColor colorWithRed:142/255.0 green:225/255.0 blue:232/255.0 alpha:1.0f];
            [self presentViewController:mc animated:YES completion:NULL];
            */
            NSMutableString *emailBody = [[NSMutableString alloc] initWithString:@"<html><body>"];
            [emailBody appendString:[NSString stringWithFormat:@"<img src='%@' alt='%@'>",[dimgURLS objectAtIndex:obj.chosenIndex],obj.chosenMessage]];
            [emailBody appendString:[NSString stringWithFormat:@"<p>%@</p>",messageBody]];
            [emailBody appendString:@"</body></html>"];
            NSString *bod = [NSString stringWithString:emailBody];
            MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
            mc.mailComposeDelegate = self;
            [mc setSubject:emailTitle];
            [mc setMessageBody:bod isHTML:YES];
            [mc setToRecipients:toRecipents];
            mc.navigationBar.tintColor = [UIColor colorWithRed:142/255.0 green:225/255.0 blue:232/255.0 alpha:1.0f];
            [self presentViewController:mc animated:YES completion:NULL];
        }
        else{
            NSMutableString *emailBody = [[NSMutableString alloc] initWithString:@"<html><body>"];
            [emailBody appendString:[NSString stringWithFormat:@"<img src='%@' alt='%@'>",[obj.imageURLData objectAtIndex:obj.chosenIndex],obj.chosenMessage]];
            [emailBody appendString:[NSString stringWithFormat:@"<p>%@</p>",messageBody]];
            [emailBody appendString:@"</body></html>"];
            NSString *bod = [NSString stringWithString:emailBody];
            MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
            mc.mailComposeDelegate = self;
            [mc setSubject:emailTitle];
            [mc setMessageBody:bod isHTML:YES];
            [mc setToRecipients:toRecipents];
            mc.navigationBar.tintColor = [UIColor colorWithRed:142/255.0 green:225/255.0 blue:232/255.0 alpha:1.0f];
            [self presentViewController:mc animated:YES completion:NULL];
        }
       /**
        NSMutableString *emailBody = [[NSMutableString alloc] initWithString:@"<html><body>"];
        NSData *imageData = [NSData dataWithData:UIImagePNGRepresentation(gushImageView.image)];
        NSString *base64String = [imageData base64EncodedStringWithOptions:0];
        [emailBody appendString:[NSString stringWithFormat:@"<p><b><img src='data:image/png;base64,%@'></b></p>",base64String]];
        [emailBody appendString:[NSString stringWithFormat:@"<p>%@</p>",messageBody]];
        [emailBody appendString:@"</body></html>"];
        **/
        
    }
    else if (buttonIndex == 0) {
        NSString *methodOfSending = @"Text";
        id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
        
        [tracker set:kGAIScreenName value:@"Preview Screen"];
        [tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"Sent Gushes"
                                                              action:methodOfSending
                                                               label:obj.chosenMessage
                                                               value:nil] build]];
        [tracker set:kGAIScreenName value:nil];
        if ([MFMessageComposeViewController canSendText]) {
            if (messageVC) {
                messageVC = nil;
                messageVC = [[MFMessageComposeViewController alloc]init];
            }
            [messageVC setRecipients:nil];
            messageVC.messageComposeDelegate = self;
            messageVC.body = extraTextTF.text;
            NSData *imageData = [NSData dataWithData:UIImagePNGRepresentation(gushImageView.image)];
            [messageVC addAttachmentData:imageData typeIdentifier:@"public.data" filename:@"image.png"];
            messageVC.navigationBar.tintColor = [UIColor colorWithRed:142/255.0 green:225/255.0 blue:232/255.0 alpha:1.0f];
            [self presentViewController:messageVC animated:YES completion:nil];
        }
//        messageVC.body = extraTextTF.text;
//        messageVC.recipients = nil;
//        messageVC.messageComposeDelegate = self;
//        
//        NSData *data = UIImagePNGRepresentation(gushImageView.image);
//        [messageVC addAttachmentData:data typeIdentifier:@"image/png" filename:str];
//        messageVC.navigationBar.tintColor = [UIColor colorWithRed:142/255.0 green:225/255.0 blue:232/255.0 alpha:1.0f];
//        [self presentViewController:messageVC animated:YES completion:NULL];
    }
    else if (buttonIndex == 2){
        NSString *methodOfSending = @"Save To Camera Roll";
        id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
        
        [tracker set:kGAIScreenName value:@"Preview Screen"];
        [tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"Sent Gushes"
                                                              action:methodOfSending
                                                               label:obj.chosenMessage
                                                               value:nil] build]];
        [tracker set:kGAIScreenName value:nil];
        UIImage *imageS = gushImageView.image;
        UIImageWriteToSavedPhotosAlbum(imageS, nil, nil, nil);
        
        stringState = @"done";
        [self viewWillAppear:NO];
        
    }
    else if (buttonIndex == 3){
        NSString *methodOfSending = @"Copy";
        id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
        
        [tracker set:kGAIScreenName value:@"Preview Screen"];
        [tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"Sent Gushes"
                                                              action:methodOfSending
                                                               label:obj.chosenMessage
                                                               value:nil] build]];
        [tracker set:kGAIScreenName value:nil];
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"Image.png"];
        
        // Save image.
        [UIImagePNGRepresentation(gushImageView.image) writeToFile:filePath atomically:YES];
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        NSData *data = [NSData dataWithContentsOfFile:filePath];
        [pasteboard setData:data forPasteboardType:@"public.png"];
        stringState = @"done";
        [self viewWillAppear:NO];
    }
    else{
        stringState = @"nil";
    }

}



- (IBAction)resignKeyboard:(id)sender {
    [extraTextTF resignFirstResponder];

}
@end
