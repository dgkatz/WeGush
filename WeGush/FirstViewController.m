//
//  FirstViewController.m
//  WeGush
//
//  Created by Family on 1/16/15.
//  Copyright (c) 2015 Stratton Apps. All rights reserved.
//
#import "navBar.h"
#import "FirstViewController.h"
#import "SWRevealViewController.h"
#import "gushEditViewController.h"
#import "dataClass.h"
#import "GAIDictionaryBuilder.h"
#import "GAI.h"
#import "GAIFields.h"
#import "editNavViewController.h"
#import "gushEditViewController.h"
#import "splashVC.h"
#import "Reachability.h"
#import "UIImageView+WebCache.h"
@interface FirstViewController ()
@end
Reachability *internetReachableFoo;
@implementation FirstViewController{
    NSArray *tableData;
    NSArray *imageArray;
    CGRect frame1;
    UIView *view;
    NSMutableData *_responseData;

}
@synthesize messageTableView;
- (void)revealController:(SWRevealViewController *)revealController willMoveToPosition:    (FrontViewPosition)position
{
    if(position == FrontViewPositionLeft) {
        self.view.userInteractionEnabled = YES;
        [self.shadowView removeFromSuperview];
    } else {
        self.view.userInteractionEnabled = NO;
        self.shadowView = [[UIView alloc]initWithFrame:self.navigationController.view.frame];
        self.shadowView.backgroundColor = [UIColor blackColor];
        self.shadowView.alpha = .3f;
        [self.shadowView addGestureRecognizer:self.revealViewController.panGestureRecognizer];
        [self.shadowView addGestureRecognizer:self.revealViewController.tapGestureRecognizer];
        SWRevealViewController *revealController = [self revealViewController];
        UITapGestureRecognizer *tap = [revealController tapGestureRecognizer];
        [self.shadowView addGestureRecognizer:tap];
        [self.navigationController.view addSubview:self.shadowView];
        /**
         self.shadow.hidden = NO;
         [self.shadow addGestureRecognizer:self.revealViewController.panGestureRecognizer];
         [self.shadow addGestureRecognizer:self.revealViewController.tapGestureRecognizer];
         SWRevealViewController *revealController = [self revealViewController];
         UITapGestureRecognizer *tap = [revealController tapGestureRecognizer];
         [self.shadow addGestureRecognizer:tap];
         [self.navigationController.view addSubview:self.shadow];
         **/
    }
}

- (void)revealController:(SWRevealViewController *)revealController didMoveToPosition:    (FrontViewPosition)position
{
    if(position == FrontViewPositionLeft) {
        self.view.userInteractionEnabled = YES;
    } else {
        self.view.userInteractionEnabled = NO;
    }
}- (void)viewDidLoad {
    [super viewDidLoad];
    dataClass *vc = [dataClass getInstance];
    //======Setting Deafult Data=========//
    tableData = [NSArray arrayWithObjects:@"What would I do without you?",
                 @"#SoGr8ful4U",
                 @"You totally rock!",
                 @"I owe you big time. Thank you!",
                 @"I am so blessed to have you in my life.",
                 @"I can't thank you enough.",
                 @"awesome [aw-suh m] adjective:  what you are",
                 @"You're a lifesaver!",
                 @"I am so grateful for you.",
                 @"You go, girl!",
                 @"You totally made my day!",
                 @"You are my superhero! ",
                 @"Wonderful: That's you in every way.",
                 @"Lucky for me: You exist.",
                 @"THX for making me LOL.",
                 @"Time spent with you? Priceless!",
                 @"Work + You = 1/2 Effort + (2 x Fun)",
                 @"You are truly amazing!",
                 @"You da man!",
                 @"My face hurts from smiling. Thank you!",
                 @"Awww, that was so sweet of you!",
                 @"The best thing about today? You!",
                 @"Thanks for having my back.",
                 @"Together, we are unstoppable!",
                 @"You are awesome!",
                 @"I cherish the time we spend together.", nil];
    [[NSUserDefaults standardUserDefaults]setObject:tableData forKey:@"defaultMessageData"];
    imageArray = [NSArray arrayWithObjects:@"whatwouldido.png",@"sog8ful4u.png",@"yougogirl.png",@"youareamazing.png",@"awesomewhatuare.png",@"yourawesomeness.png",@"whenigrowup.png",@"iamsoblessed.png",@"thanksforlettingshare.png",@"icherishthetime.png",@"youaremysuperhero.png",@"ioweyoubigtime.png",@"uralifesaver.png",@"wemakeateam.png",@"togetherunstoppable.png",@"thxforlol.png",@"youmakemelaugh.png",@"awwthatwassweet.png",@"youmademyday.png",@"youmadeadifference.png", nil];
    
    [[NSUserDefaults standardUserDefaults]setObject:imageArray forKey:@"defaultImageData"];
    NSMutableArray *defaultSpinsorArray = [[NSMutableArray alloc]initWithObjects:@"Proud to partner with the Pan-Mass Challenge",@"http://api.wegush.com/1to1/sponsors/pmc1/pmc2.png",@"Learn more about the PMC:",@"http://api.wegush.com/1to1/sponsors/pmc1/index.html",@"http://www.pmc.org", nil];
    [[NSUserDefaults standardUserDefaults]setObject:defaultSpinsorArray forKey:@"defaultSponsorData"];
    NSMutableArray *defaultQuoteArray =[[NSMutableArray alloc]initWithObjects:@"Feeling gratitude and not expressing it is like wrapping a present and not giving it.",
                                        @"Silent gratitude isn't very much to anyone.",
                                        @"Truly appreciate those around you and you'll soon find many others around you.",
                                        @"Everyone wants to be appreciated, so if you appreciate someone, don't keep it a secret.",
                                        @"There isn't anyone who doesn't appreciate kindness and compassion.",
                                        @"Gratitude is the most exquisite form of courtesy.",
                                        @"We are constituted so that simple acts of kindness...have a positive impact on our long-term moods.",
                                        @"Sometimes we should express our gratitude for the small and simple things.",
                                        @"Gratitude is the fairest blossom which springs from the soul.",
                                        @"The way to develop the best that is in a man is by appreciation and encouragement.",
                                        @"If the only prayer you ever say in your entire life is thank you, it will be enough.",
                                        @"No duty is more urgent than that of returning thanks.",
                                        @"The man who forgets to be thankful has fallen asleep in life.",
                                        @"Gratitude bestows reverence, allowing us to encounter everyday epiphanies.",
                                        @"I just believe in the goodwill of people, the power of people to do something positive.",
                                        @"Each person holds so much power within themselves that needs to be let out.",
                                        @"As we need food, so do we need emotional nourishment: love, kindness, appreciation, and support from others.",
                                        @"Love is the only force capable of transforming an enemy into a friend.",
                                        @"We invest less in our friendships and expect more of friends than any other relationship.",
                                        @"If we should cast the gift of a loving thought into the heart of a friend, that would be giving as the angels give.",
                                        @"What sweetness is left in life, if you take away friendship?",
                                        @"It takes a long time to grow an old friend.",
                                        @"A friend may well be reckoned the masterpiece of nature.",
                                        @"Most folks are as happy at they make up their minds to be.",
                                        @"Try to make at least one person happy every day. If you cannot do a kind deed, speak a kind word.",
                                        @"The most worth-while thing is to try to put happiness into the lives of others.",
                                        @"Happiness depends more on how life strikes you than on what happens.",
                                        @"We don't find the meaning of life by ourselves alone, we find it in one another.",@"We need more kindness, more compassion, more laughter. I definitely want to contribute to that.",
                                        @"When autumn darkness falls, what we will remember are the small acts of kindness.",
                                        @"You cannot do a kindness too soon, for you never know how soon it will be too late.",
                                        @"As the sun makes ice melt, kindness causes misunderstanding, mistrust, and hostility to evaporate.",
                                        @"Ask yourself:  Have you been kind today? Make kindness your daily modus operandi and change your world.",
                                        @"You can be rich in spirit, kindness, love and all those things that you can't put a dollar sign on.",
                                        @"Remember there's no such thing as a small act of kindness. Every act creates a ripple with no logical end",
                                        @"Kindness makes a fellow feel good whether it's being done to him or by him.",
                                        @"As much as we need a prosperous economy, we also need a prosperity of kindness and decency.",
                                        @"A kindness received should be returned with a freer hand.",
                                        @"God gave you a gift of 86,000 seconds today. Have you used one to say thank you?",
                                        @"Let us be grateful to the people who make us happy; they are the charming gardeners who make our souls blossom.",
                                        @"Forget injuries, never forget kindnesses",
                                        @"That best portion of a good man's life, His little, nameless, unremembered acts of kindness and love.",
                                        @"No act of kindness, no matter how small, is ever wasted.",
                                        @"I will not play at tug war, I'd rather play at hug o' war, where everyone hugs instead of tugs",nil];
    [[NSUserDefaults standardUserDefaults]setObject:defaultQuoteArray forKey:@"defaultQuoteData"];
    NSMutableArray *defaultAttributionArray = [[NSMutableArray alloc]initWithObjects: @"William Arthur Ward",
                                               @"Gertrude Stein",
                                               @"Ralph Marston",
                                               @"Mary Kay Ash",
                                               @"Dalai Lama",
                                               @"Jacques Maritain",
                                               @"Paul Bloom",
                                               @"Joseph B. Wirthlin",
                                               @"Henry Ward Beecher",
                                               @"Charles Schwab",
                                               @"Meister Eckhardt",
                                               @"James Allen",
                                               @"Robert Louis Stevenson",
                                               @"John Milton",
                                               @"Eddie Izzard",
                                               @"Pete Carroll",
                                               @"J. Donald Walters",
                                               @"Martin Luther King, Jr.",
                                               @"Mariella Frostrup",
                                               @"George MacDonald",
                                               @"Marcus Tullius Cicero",
                                               @"John Leonard",
                                               @"Ralph Waldo Emerson",
                                               @"Abraham Lincoln",
                                               @"Lawrence G. Lovasik",
                                               @"Robert Baden-Powell",
                                               @"Andy Rooney",
                                               @"Thomas Merton",
                                               @"Ellen DeGeneres",
                                               @"Jens Stoltenberg",
                                               @"Ralph Waldo Emerson",
                                               @"Albert Schweitzer",
                                               @"Annie Lennox",
                                               @"Dolly Parton",
                                               @"Scott Adams",
                                               @"Frank A. Clark",
                                               @"Caroline Kennedy",
                                               @"Saint Ambrose",
                                               @"William Arthur Ward",
                                               @"Marcel Proust",
                                               @"Confucius",
                                               @"William Wordsworth",
                                               @"Aesop",
                                               @"Shel Silverstein"

                                               , nil];
    [[NSUserDefaults standardUserDefaults]setObject:defaultAttributionArray forKey:@"defaultAttributionData"];
    NSMutableArray *defaultReminderArray = [[NSMutableArray alloc]initWithObjects:@"Time to make somebody feel amazing.",
                                            @"Who made your day today? Thank them!",
                                            @"Spread a little love today!",
                                            @"Ready to warm somebody's heart?",
                                            @"2, 4, 6, 8...Who do you appreciate?",
                                            @"Gratitude feels good. Pass it on!",
                                            @"Make someone smile today!",
                                            @"Time for your daily dose of gratitude.",
                                            @"Ready to dish up an extra helping of happy?",
                                            @"Time to strengthen your gratitude muscle.",
                                            @"Make appreciation a reflex.",
                                            @"Gratitude is good for you. Drink up!",
                                            @"Who's been awesome today? Tell 'em!"
                                            , nil];
    [[NSUserDefaults standardUserDefaults]setObject:defaultReminderArray forKey:@"defaultReminderData"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    //====================================//
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    vc.messageData = [[userDefaults arrayForKey:@"messageData"] mutableCopy];
    vc.quoteAttributeData = [[userDefaults arrayForKey:@"quoteAttributeData"] mutableCopy];
    vc.quoteData = [[userDefaults arrayForKey:@"quoteData"] mutableCopy];
    vc.sponsorInfo = [[userDefaults arrayForKey:@"sponsorInfo"] mutableCopy];
    vc.quoteData = [[userDefaults arrayForKey:@"quoteData"]mutableCopy];
    vc.quoteAttributeData = [[userDefaults arrayForKey:@"quoteAttributeData"]mutableCopy];
    vc.reminderData = [[userDefaults arrayForKey:@"reminderData"]mutableCopy];
    vc.imageURLData = [[userDefaults arrayForKey:@"imageURLData"]mutableCopy];
    NSArray *copy = [[NSArray alloc]init];
    if (vc.doneLoading == 1) {
        copy = vc.imageData;
        [userDefaults setObject:copy forKey:@"imageData"];
        [userDefaults synchronize];
    }
    else{
        
    }
    BOOL shouldUseServer = [[NSUserDefaults standardUserDefaults]boolForKey:@"useServer"];
    if (shouldUseServer == NO) {
        NSArray *sponsorArray = [[NSUserDefaults standardUserDefaults]objectForKey:@"defaultSponsorData"];
        [_sponsorButton setTitle:[sponsorArray objectAtIndex:0]forState:UIControlStateNormal];
    }
    else{
        NSString *label = [vc.sponsorInfo objectAtIndex:0];
        [_sponsorButton setTitle:label forState:UIControlStateNormal];
    }
    [self.navigationController setValue:[[navBar alloc]init]forKeyPath:@"navigationBar"];
    [self.navigationController.navigationBar setTranslucent:NO];
    UIView *overlayView = [[UIView alloc] initWithFrame:CGRectMake(0, self.navigationController.navigationBar.frame.size.height,self.navigationController.navigationBar.frame.size.width, 1)];
    [overlayView setBackgroundColor:[UIColor colorWithRed:84/255.0 green:173/255.0 blue:187/255.0 alpha:.6f]];
    [self.navigationController.navigationBar addSubview:overlayView];
    id tracker = [[GAI sharedInstance] defaultTracker];
    
    // This screen name value will remain set on the tracker and sent with
    // hits until it is set to a new value or to nil.
    [tracker set:kGAIScreenName
           value:@"Main Screen"];
    
    // manual screen tracking
    [tracker send:[[GAIDictionaryBuilder createScreenView] build]];

    messageTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    
    
    _barButton.target = self.revealViewController;
    _barButton.action = @selector(revealToggle:);
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    [self.view addGestureRecognizer:self.revealViewController.tapGestureRecognizer];
    SWRevealViewController *revealController = [self revealViewController];
    UITapGestureRecognizer *tap = [revealController tapGestureRecognizer];
    [self.view addGestureRecognizer:tap];
    if ([messageTableView respondsToSelector:@selector(layoutMargins)]) {
        messageTableView.layoutMargins = UIEdgeInsetsZero;
    }
    
    
    
    
}
-(void)viewDidAppear:(BOOL)animated{
    self.revealViewController.delegate = self;
    self.screenName = @"Message Screen";
    frame1 = self.navigationController.view.frame;
    frame1.origin.x = 0;
    frame1.origin.y = 0;
    messageTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;


    
    }
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    dataClass *obj = [dataClass getInstance];
    int num;
    BOOL shouldUseServer = [[NSUserDefaults standardUserDefaults]boolForKey:@"useServer"];
    if (shouldUseServer == NO) {
        num = (int)[tableData count];
        NSLog(@"shoudl use server is no");
    }
    else{
        num = (int)[obj.messageData count];
        NSLog(@"shoudl use server is yes");
    }
    return num;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    dataClass *obj = [dataClass getInstance];
    BOOL shouldUseServer = [[NSUserDefaults standardUserDefaults]boolForKey:@"useServer"];
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    if (shouldUseServer == NO) {
        cell.textLabel.text = [tableData objectAtIndex:indexPath.row];
    }
    else{
        cell.textLabel.text = [obj.messageData objectAtIndex:indexPath.row];
    }
    UIView *selectView = [[UIView alloc]init];
    selectView.backgroundColor = [UIColor colorWithRed:68/255.0 green:161/255.0 blue:175/255.0 alpha:1.0f];
    cell.selectedBackgroundView = selectView;
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.font = [UIFont systemFontOfSize:20];
    cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
    cell.textLabel.textColor = [UIColor whiteColor];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Remove seperator inset
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    // Prevent the cell from inheriting the Table View's margin settings
    if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
    
    // Explictly set your cell's layout margins
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    dataClass *obj = [dataClass getInstance];
    BOOL shouldUseServer = [[NSUserDefaults standardUserDefaults]boolForKey:@"useServer"];
    if ([segue.identifier isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.messageTableView indexPathForSelectedRow];
        NSString *label;
        if (shouldUseServer == NO) {
            label = [tableData objectAtIndex:indexPath.row];
            NSArray *savedIMageArray = [[NSUserDefaults standardUserDefaults]objectForKey:@"defualtImageData"];
            obj.chosenGush = [savedIMageArray objectAtIndex:indexPath.row];
        }
        else{
            obj.chosenGush = [obj.imageData objectAtIndex:indexPath.row];
            label = [obj.messageData objectAtIndex:indexPath.row];
        }
        id<GAITracker> tracker = [[GAI sharedInstance] trackerWithTrackingId:@"UA-41894678-4"];
        
        [tracker set:kGAIScreenName value:@"Preview Screen"];
        [tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"Preview Gushes"
                                                              action:@"touch"
                                                               label:label
                                                               value:nil] build]];
        [tracker set:kGAIScreenName value:nil];
        obj.chosenIndex = (int)indexPath.row;
        obj.chosenMessage = label;
    }
    else if ([segue.identifier isEqualToString:@"sponsor"]){
        id<GAITracker> tracker = [[GAI sharedInstance] trackerWithTrackingId:@"UA-41894678-4"];
        
        [tracker set:kGAIScreenName value:@"Main Screen"];
        [tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"Sponsor"
                                                              action:@"touch"
                                                               label:@"Main-to-Sponsor"
                                                               value:nil] build]];
        [tracker set:kGAIScreenName value:nil];

    }
}
@end
