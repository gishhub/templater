//
//  AddTemplateViewController.m
//  templater
//
//  Created by 奈良 貴仁 on 2013/02/28.
//  Copyright (c) 2013年 奈良 貴仁. All rights reserved.
//

#import "AddTemplateViewController.h"

@interface AddTemplateViewController ()

@end

@implementation AddTemplateViewController
@synthesize titleTemplate = _titleTemplate;
@synthesize textTemplate = _textTemplate;

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
    _titleTemplate.delegate = self;
    _textTemplate.delegate = self;
    
    
    // タイトル部分設定
    _titleTemplate.placeholder = @"Title";
    
    // テキスト部分設定
    _textTemplate.placeholder = @"Contents";
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cancelAddTemplate:(id)sender {
    NSLog(@"push cancelAddTemplate");
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (IBAction)saveAddTemplate:(id)sender {
    NSLog(@"push saveAddTemplate");
    
    NSString *test_string = @"test_value";
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    // テンプレート保存
    [defaults setValue:test_string forKey:@"Key_TEST_STRING"];

    NSString *test_tmp = [defaults stringForKey:@"Key_TEST_STRING"];
    
    NSString *tmp_text = _titleTemplate.text;
    
    NSLog(@"Test template is %@.", test_tmp);
    NSLog(@"Title Template is %@.", tmp_text);
    
    // テンプレートリスト画面に戻る
    [self dismissViewControllerAnimated:YES completion:NULL];
}
@end
