//
//  NavigationViewController.m
//  WeGush
//
//  Created by Family on 1/16/15.
//  Copyright (c) 2015 Stratton Apps. All rights reserved.
//

#import "NavigationViewController.h"
#import "SWRevealViewController.h"
#import "GAITrackedViewController.h"
#import "GAITracker.h"
#import "GAIFields.h"
#import "GAIDictionaryBuilder.h"
#import "GAI.h"
#import "SDiPhoneVersion.h"
#import "GAIFields.h"
#import "GAI.h"
#import "GAIDictionaryBuilder.h"
#import "SDiPhoneVersion.h"
@interface NavigationViewController ()

#if __has_feature(objc_arc_weak)
@property(nonatomic, weak) NSObject <AppiraterDelegate> *delegate;
#else
@property(nonatomic, unsafe_unretained) NSObject <AppiraterDelegate> *delegate;
#endif
@end

@implementation NavigationViewController{
    NSArray *menu;
    UIImageView *cellImage;
    NSArray *menuIcons1;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.scrollEnabled = NO;
    self.av.scrollEnabled = NO;
    menu = @[@"1",@"sizth",@"1.5",@"first",@"second",@"third",@"fourth",@"fifth",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15"];
    menuIcons1 = @[@"",@"",@"",@"Settings.png",@"Share.png",@"Rate.png",@"Feedback.png",@"About.png"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewDidAppear:(BOOL)animated{
    id tracker = [[GAI sharedInstance] defaultTracker];
    
    // This screen name value will remain set on the tracker and sent with
    // hits until it is set to a new value or to nil.
    [tracker set:kGAIScreenName
           value:@"Menu Screen"];
    
    // manual screen tracking
    [tracker send:[[GAIDictionaryBuilder createScreenView] build]];

}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [menu count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentifier = [menu objectAtIndex:indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.textLabel.textColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1];
    if (indexPath.row == 0) {
        cellImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"MainLogo.png"]];
        cellImage.frame = CGRectMake(0, 0, 131, 48);
        cellImage.center = CGPointMake(cell.contentView.bounds.size.width/2.75,cell.contentView.bounds.size.height/2 + 15);
        [self.view addSubview:cellImage];
    }
    else if (indexPath.row == 1){
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(cell.frame.origin.x, cell.frame.origin.y, cell.frame.size.width, .5)];
        lineView.backgroundColor = [UIColor colorWithRed:84/255.0 green:173/255.0 blue:187/255.0 alpha:1.0f];
        [cell addSubview:lineView];
        
    }
    else if (indexPath.row > 2 && indexPath.row <8) {
        UIView *selView = [[UIView alloc]initWithFrame:cell.frame];
        selView.backgroundColor = [UIColor colorWithRed:17/255.0 green:130/255.0 blue:147/255.0 alpha:1.0f];
        cell.selectedBackgroundView = selView;
        if ([SDiPhoneVersion deviceSize] == iPhone4inch) {
            NSString *img = [NSString stringWithFormat:@"%@",[menuIcons1 objectAtIndex:indexPath.row]];
            cell.imageView.image = [UIImage imageNamed:img];
        }
        else if ([SDiPhoneVersion deviceVersion] == iPhone4){
            NSString *img = [NSString stringWithFormat:@"%@",[menuIcons1 objectAtIndex:indexPath.row]];
            cell.imageView.image = [UIImage imageNamed:img];
        }
        else if ([SDiPhoneVersion deviceVersion] == iPhone4S){
            NSString *img = [NSString stringWithFormat:@"%@",[menuIcons1 objectAtIndex:indexPath.row]];
            cell.imageView.image = [UIImage imageNamed:img];
        }
        else if ([SDiPhoneVersion deviceVersion] == iPhone5){
            NSString *img = [NSString stringWithFormat:@"%@",[menuIcons1 objectAtIndex:indexPath.row]];
            cell.imageView.image = [UIImage imageNamed:img];
        }
        else if ([SDiPhoneVersion deviceVersion] == iPhone5C){
            NSString *img = [NSString stringWithFormat:@"%@",[menuIcons1 objectAtIndex:indexPath.row]];
            cell.imageView.image = [UIImage imageNamed:img];
        }
        else if ([SDiPhoneVersion deviceVersion] == iPhone5S){
            NSString *img = [NSString stringWithFormat:@"%@",[menuIcons1 objectAtIndex:indexPath.row]];
            cell.imageView.image = [UIImage imageNamed:img];
        }
        else if ([SDiPhoneVersion deviceVersion] == iPhone6){
            NSString *img = [NSString stringWithFormat:@"%@",[menuIcons1 objectAtIndex:indexPath.row]];
            cell.imageView.image = [UIImage imageNamed:img];
        }
        else{
            NSString *img = [NSString stringWithFormat:@"%@",[menuIcons1 objectAtIndex:indexPath.row]];
            cell.imageView.image = [UIImage imageNamed:img];
        }

    }
    else{
        /**
        UIView *seView = [[UIView alloc]initWithFrame:cell.frame];
        seView.backgroundColor = [UIColor colorWithRed:70/255.0 green:158/255.0 blue:173/255.0 alpha:1.0f];
        cell.selectedBackgroundView = seView;
         **/
    }
    
    return cell;

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([SDiPhoneVersion deviceSize] == iPhone35inch && indexPath.row >2){
        return 48.0;

    }
    else if ([SDiPhoneVersion deviceSize] == iPhone4inch && indexPath.row >2){
        return 48.0;
    }
    if ([SDiPhoneVersion deviceSize] == iPhone47inch && indexPath.row >2){
        return 48.0;
        
    }
    if ([SDiPhoneVersion deviceSize] == iPhone55inch && indexPath.row >2){
        return 55.0;
        
    }
    else if (indexPath.row == 2){
        return 20;
    }
    // "Else"
    return 37.5;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 4) {
        id tracker = [[GAI sharedInstance] defaultTracker];
        
        // This screen name value will remain set on the tracker and sent with
        // hits until it is set to a new value or to nil.
        [tracker set:kGAIScreenName
               value:@"Share Screen"];
        
        // manual screen tracking
        [tracker send:[[GAIDictionaryBuilder createScreenView] build]];
        
        NSString *emailTitle = @"WeGush: Deliver Gratitude in Real Time";
        NSString *url = @"https://itunes.apple.com/us/app/wegush-express-appreciation/id984121643?ls=1&mt=8";
        NSString *url2 = @"http://www.WeGush.com";
        NSString *emailBody = [NSString stringWithFormat:@"I thought you might enjoy unleashing your gratitude with the WeGush app. Check it out at:<br/><br/><a href='%@'>%@</a><br/><br/> I bet that every day you experience kindnesses large and small. WeGush makes it easy to express your gratitude before the moment slips away. Simply choose a beautiful, personal, appreciation message to send right from your iPhone. And never miss another opportunity to say “thank you”!<br/><br/>Learn more at:<br/><br/><a href='%@'>%@</a>",url,url,url2,url2];
        NSArray *toRecipents = Nil;
        MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
        mc.mailComposeDelegate = self;
        [mc setSubject:emailTitle];
        [mc setMessageBody:emailBody isHTML:YES];
        [mc setToRecipients:toRecipents];
        
        // Present mail view controller on screen
        mc.navigationBar.tintColor = [UIColor colorWithRed:142/255.0 green:225/255.0 blue:232/255.0 alpha:1.0f];
        
        [self presentViewController:mc animated:YES completion:NULL];
    }
    else if (indexPath.row == 6){
        id tracker = [[GAI sharedInstance] defaultTracker];
        
        // This screen name value will remain set on the tracker and sent with
        // hits until it is set to a new value or to nil.
        [tracker set:kGAIScreenName
               value:@"Feedback Screen"];
        
        // manual screen tracking
        [tracker send:[[GAIDictionaryBuilder createScreenView] build]];
        
        [self.navigationController setValue:[[UINavigationBar alloc]init]forKeyPath:@"navigationBar"];
        if ([SDiPhoneVersion deviceVersion] == iPhone4){
            device = [NSString stringWithFormat:@"Device: iPhone 4"];
            
            
        }
        else if ([SDiPhoneVersion deviceVersion] == iPhone4S){
            device = [NSString stringWithFormat:@"Device: iPhone 4s"];
            
            
        }
        else if ([SDiPhoneVersion deviceVersion] == iPhone5){
            device = [NSString stringWithFormat:@"Device: iPhone 5"];
            
            
        }
        else if ([SDiPhoneVersion deviceVersion] == iPhone5S){
            device = [NSString stringWithFormat:@"Device: iPhone 5s"];

            
        }
        else if ([SDiPhoneVersion deviceVersion] == iPhone5C){
            device = [NSString stringWithFormat:@"Device: iPhone 5c"];
            
            
        }
        else if ([SDiPhoneVersion deviceVersion] == iPhone6){
            device = [NSString stringWithFormat:@"Device: iPhone 6"];
            
            
        }
        else {
            device = [NSString stringWithFormat:@"Device: iPhone 6 plus"];
            
        }
        NSString *df = [[UIDevice currentDevice] systemVersion];
        NSString *emailTitle = @"WeGush Feedback";
        NSString *messageBody = [NSString stringWithFormat:@"\n\n\n\n\n----------------------------\nDevice Details:\n Platform: %@\n%@\nApp Version: 1.35",df,device];
        NSArray *toRecipents = [NSArray arrayWithObject:@"info@WeGush.com"];
        
        MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
        mc.mailComposeDelegate = self;
        [mc setSubject:emailTitle];
        [mc setMessageBody:messageBody isHTML:NO];
        [mc setToRecipients:toRecipents];
        
        // Present mail view controller on screen
        mc.navigationBar.tintColor = [UIColor colorWithRed:142/255.0 green:225/255.0 blue:232/255.0 alpha:1.0f];
        
        [self presentViewController:mc animated:YES completion:NULL];
    }
}
- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    
    if (result == MFMailComposeResultCancelled) {
        
    }
    else if (result == MFMailComposeResultSaved){
        
    }
    else if (result == MFMailComposeResultSent){
        
    }
    else{
        
    }
    // Close the Mail Interface
    [self.revealViewController revealToggleAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ( [segue isKindOfClass:[SWRevealViewControllerSegue class]]) {
        
        SWRevealViewControllerSegue *swSeque = (SWRevealViewControllerSegue *)segue;
        swSeque.performBlock = ^(SWRevealViewControllerSegue* rvc_segue, UIViewController*svc, UIViewController*dvc) {
            UINavigationController* navController = ( UINavigationController*)self.revealViewController.frontViewController;
            [navController setViewControllers:@[dvc] animated:NO];
            [self.revealViewController setFrontViewPosition:FrontViewPositionLeft animated:YES];
        };
    }
}


@end
