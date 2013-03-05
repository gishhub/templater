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
    
    NSString *tmp = self.selectedTitle;

    UITextField *selectedTemplateText = [[UITextField alloc] initWithFrame:CGRectMake(10.0, 100.0, 300.0, 40.0)];
    selectedTemplateText.borderStyle = UITextBorderStyleLine;
    
    selectedTemplateText.text = reverse[tmp];
    
    
    [self.view addSubview:selectedTemplateText];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
