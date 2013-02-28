//
//  AddTemplateViewController.h
//  templater
//
//  Created by 奈良 貴仁 on 2013/02/28.
//  Copyright (c) 2013年 奈良 貴仁. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddTemplateViewController : UIViewController <UITextFieldDelegate>
{
    UITextField *_titleTemplate;
    UITextField *_textTemplate;
}

- (IBAction)cancelAddTemplate:(id)sender;
- (IBAction)saveAddTemplate:(id)sender;

@property (strong, nonatomic) IBOutlet UITextField *titleTemplate;
@property (strong, nonatomic) IBOutlet UITextField *textTemplate;

@end
