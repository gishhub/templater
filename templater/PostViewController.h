//
//  PostViewController.h
//  templater
//
//  Created by 奈良 貴仁 on 2013/02/24.
//  Copyright (c) 2013年 奈良 貴仁. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Social/Social.h>

@interface PostViewController : UIViewController <UITextFieldDelegate> {
    NSString *selectedTitle;
    UITextField *selectedTemplateText;
}

@property (strong, nonatomic) NSString *selectedTitle;
@property (strong, nonatomic) UITextField *selectedTemplateText;

- (IBAction)postFb:(id)sender;
- (IBAction)updateTemplate:(id)sender;

@end
