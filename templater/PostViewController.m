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
    [self configureView];
}

- (void)configureView
{

    UITextView *customTextView = [[UITextView alloc] initWithFrame:CGRectMake(10, 10, 100, 100)];
    
    NSLog(@"テキストは『aaaa』");
    customTextView.text = @"aaaa";
    
    customTextView.delegate = self;
    
    [self.view addSubview:customTextView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
