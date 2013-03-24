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
    _titleTemplate.layer.borderWidth = 1;
    _titleTemplate.layer.borderColor =[[UIColor blackColor] CGColor];
    _titleTemplate.layer.cornerRadius = 8;
    
    // テキスト部分設定
    _textTemplate.layer.borderWidth = 1;
    _textTemplate.layer.borderColor =[[UIColor blackColor] CGColor];
    _textTemplate.layer.cornerRadius = 8;

    _textTemplate.text = @"Contents";
    _textTemplate.textColor = [UIColor lightGrayColor];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    if (_textTemplate.textColor == [UIColor lightGrayColor]) {
        _textTemplate.text = @"";
        _textTemplate.textColor = [UIColor blackColor];
    }

    return YES;
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView {
    if (_textTemplate.text.length == 0) {
        _textTemplate.text = @"Contents";
        _textTemplate.textColor = [UIColor lightGrayColor];
    }
    
    return YES;
}

- (IBAction)cancelAddTemplate:(id)sender {
    NSLog(@"push cancelAddTemplate");
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [_textTemplate insertText:@"\n"];
    return YES;
}


- (IBAction)saveAddTemplate:(id)sender {
    NSLog(@"push saveAddTemplate");
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    // テンプレート情報を初期化
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    // テンプレート情報が存在したら、取り出す
    if([defaults dataForKey:@"TEMPLATE"]){
        NSData *reverse_tmp = [defaults dataForKey:@"TEMPLATE"];
        dic = [NSKeyedUnarchiver unarchiveObjectWithData:reverse_tmp];
    }
    
    // 新規に入力したテンプレートを取得
    NSString *tmp_key = _titleTemplate.text;
    NSString *tmp_value = _textTemplate.text;
    
    [dic setObject:tmp_value forKey:tmp_key];
    
    // 新規に入力したテンプレートを保存
    NSData *d = [NSKeyedArchiver archivedDataWithRootObject:dic];
    [defaults setObject:d forKey:@"TEMPLATE"];
    
    
    // デバッグ用
    NSData *release = [defaults dataForKey:@"TEMPLATE"];
    NSMutableDictionary *tmp = [NSKeyedUnarchiver unarchiveObjectWithData:release];
    NSLog(@"aaa %@", tmp);
    
    [defaults synchronize];
    
    // テンプレートリスト画面に戻る
    [self dismissViewControllerAnimated:YES completion:NULL];
    
}

@end
