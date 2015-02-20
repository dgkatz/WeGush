//
//  gushEditViewController.h
//  WeGush
//
//  Created by Family on 1/16/15.
//  Copyright (c) 2015 Stratton Apps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface gushEditViewController : UIViewController<UITextFieldDelegate>{
    
    
    
    
    IBOutlet UITextField *extraTextTF;
    
    
}
@property (weak, nonatomic) IBOutlet UIImageView *gushImageView;


- (IBAction)resignKeyboard:(id)sender;
@property(weak,nonatomic)UIImage *chosenImage;
- (IBAction)sendGush:(id)sender;
@end
