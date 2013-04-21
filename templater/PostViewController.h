//
//  PostViewController.h
//  templater
//
//  Created by 奈良 貴仁 on 2013/02/24.
//  Copyright (c) 2013年 奈良 貴仁. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Social/Social.h>
#import <iAd/iAd.h> 
#import <QuartzCore/QuartzCore.h>

@interface PostViewController : UIViewController <UITextViewDelegate> {
    NSString *selectedTitle;
    UITextView *selectedTemplateText;
}

@property (strong, nonatomic) NSString *selectedTitle;
@property (strong, nonatomic) UITextView *selectedTemplateText;

- (IBAction)postFb:(id)sender;
- (IBAction)updateTemplate:(id)sender;
- (IBAction)closeKeyboard:(id)sender ;

@end
