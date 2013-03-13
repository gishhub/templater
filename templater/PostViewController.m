//
//  PostViewController.m
//  templater
//
//  Created by 奈良 貴仁 on 2013/02/24.
//  Copyright (c) 2013年 奈良 貴仁. All rights reserved.
//

#import "PostViewController.h"

@interface PostViewController ()

@end

@implementation PostViewController

@synthesize selectedTitle = _selectedTitle;
@synthesize selectedTemplateText = _selectedTemplateText;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *d = [defaults dataForKey:@"TEMPLATE"];
    NSMutableDictionary *reverse = [NSKeyedUnarchiver unarchiveObjectWithData:d];
    NSLog(@"%@",reverse);
    
    NSString *tmp = self.selectedTitle;

    selectedTemplateText = [[UITextField alloc] initWithFrame:CGRectMake(10.0, 100.0, 300.0, 40.0)];
    selectedTemplateText.borderStyle = UITextBorderStyleLine;

    selectedTemplateText.text = [reverse objectForKey:tmp];
   
    [self.view addSubview:selectedTemplateText];
}

-(BOOL)textFieldShouldReturn:(UITextField*)textField{
    [selectedTemplateText resignFirstResponder];
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)postFb:(id)sender {
    
    SLComposeViewController *facebookPostVC = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
    [facebookPostVC setInitialText:selectedTemplateText.text];
    
    [self presentViewController:facebookPostVC animated:YES completion:nil];
}

- (IBAction)updateTemplate:(id)sender {
    NSLog(@"Push updateTemplate. %@", selectedTemplateText.text);
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSData *d = [defaults dataForKey:@"TEMPLATE"];
    NSMutableDictionary *reverse = [NSKeyedUnarchiver unarchiveObjectWithData:d];
    
    [reverse setObject:selectedTemplateText.text forKey:self.selectedTitle];
    
    NSData *tmp_d = [NSKeyedArchiver archivedDataWithRootObject:reverse];
    [defaults setObject:tmp_d forKey:@"TEMPLATE"];
    
    [defaults synchronize];
    
}
@end
