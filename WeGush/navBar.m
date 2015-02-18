//
//  navBar.m
//  WeGush
//
//  Created by Daniel Katz on 2/17/15.
//  Copyright (c) 2015 Stratton Apps. All rights reserved.
//

#import "navBar.h"
static CGFloat const CustomNavigationBarHeight = 75;
static CGFloat const NavigationBarHeight = 75;
static CGFloat const CustomNavigationBarHeightDelta = CustomNavigationBarHeight - NavigationBarHeight;

@implementation navBar
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //      UIColor *titleColor = [[HITheme currentTheme] fontColorForLabelForLocation:HIThemeLabelNavigationTitle];
        //      UIFont *titleFont = [[HITheme currentTheme] fontForLabelForLocation:HIThemeLabelNavigationTitle];
        [self setTitleVerticalPositionAdjustment:-100 forBarMetrics:UIBarMetricsDefault];
        UIImageView *imgv = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"logo.png"]];
        int result = frame.size.width - 160;
        int next = result/2;
        imgv.frame = CGRectMake(- next, 12, 131, 47.5);
        NSLog(@"%f",imgv.frame.origin.x);
        [self addSubview:imgv];
        UIView *overlayView = [[UIView alloc] initWithFrame:CGRectMake(0, frame.size.height, frame.size.width, 1)];
        [overlayView setBackgroundColor:[UIColor colorWithRed:84/255.0 green:173/255.0 blue:187/255.0 alpha:1.0f]];
        [self addSubview:overlayView];
        //      [self setTitleTextAttributes:@{ UITextAttributeFont : titleFont, UITextAttributeTextColor : titleColor }];
        
        CGAffineTransform translate = CGAffineTransformMakeTranslation(0, -CustomNavigationBarHeightDelta / 2.0);
        self.transform = translate;

        [self resetBackgroundImageFrame];
        
    }
    return self;
}
- (void)resetBackgroundImageFrame
{
    for (UIView *view in self.subviews) {
        if ([NSStringFromClass([view class]) rangeOfString:@"BarBackground"].length != 0) {
            view.frame = CGRectMake(0, CustomNavigationBarHeightDelta / 2.0, self.bounds.size.width, self.bounds.size.height);
        }
    }
}

- (void)setBackgroundImage:(UIImage *)backgroundImage forBarMetrics:(UIBarMetrics)barMetrics
{
    [super setBackgroundImage:backgroundImage forBarMetrics:barMetrics];
    [self resetBackgroundImageFrame];
}

- (CGSize)sizeThatFits:(CGSize)size
{
    size.width = self.frame.size.width;
    size.height = CustomNavigationBarHeight;
    return size;
}
- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    [self resetBackgroundImageFrame];
}
@end
