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
    
    // タイトルリストで選択したタイトルから、テンプレートの中身を取り出す
    NSUserDefaults      *defaults    = [NSUserDefaults standardUserDefaults];
    NSData              *data        = [defaults dataForKey:@"TEMPLATE"];
    NSMutableDictionary *templateDic = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    
    NSString *tmp = self.selectedTitle;

    _selectedTemplateText = [[UITextView alloc] initWithFrame:CGRectMake(10.0, 20.0, 300.0, 200.0)];
    _selectedTemplateText.layer.borderWidth = 1;
    _selectedTemplateText.layer.borderColor =[[UIColor blackColor] CGColor];
    _selectedTemplateText.layer.cornerRadius = 8;
    

    _selectedTemplateText.text = [templateDic objectForKey:tmp];
    
    
    //ベースの作成
    UIButton* accessoryView = [UIButton buttonWithType:UIButtonTypeCustom];
    accessoryView.frame = CGRectMake(0,0,320,30);
    [accessoryView addTarget:self action:@selector(closeKeyboard:) forControlEvents:UIControlEventTouchUpInside];
    
    // ボタンを作成する。
    UIButton* closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    // closeButton.frame = CGRectMake(320 - 25,30 - 25,25,25);
    closeButton.frame = CGRectMake(320 - 40, 30 - 40, 40, 40);
    closeButton.backgroundColor = [UIColor grayColor];
    
    [closeButton setImage:[UIImage imageNamed:@"SampleIcon.png"] forState:UIControlStateNormal];
    [closeButton addTarget:self action:@selector(closeKeyboard:) forControlEvents:UIControlEventTouchUpInside];
    
    // ボタンをベースに配置する。
    [accessoryView addSubview:closeButton];
    //アクセサリーに設定する
    _selectedTemplateText.inputAccessoryView = accessoryView;
    
    
    [self.view addSubview:_selectedTemplateText];
}

-(BOOL)textFieldShouldReturn:(UITextField*)textField{
    [_selectedTemplateText resignFirstResponder];
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)postFb:(id)sender {
    
    SLComposeViewController *facebookPostVC = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
    [facebookPostVC setInitialText:_selectedTemplateText.text];
    
    [self presentViewController:facebookPostVC animated:YES completion:nil];
}

- (IBAction)updateTemplate:(id)sender {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSData *d = [defaults dataForKey:@"TEMPLATE"];
    NSMutableDictionary *reverse = [NSKeyedUnarchiver unarchiveObjectWithData:d];
    
    [reverse setObject:_selectedTemplateText.text forKey:self.selectedTitle];
    
    NSData *tmp_d = [NSKeyedArchiver archivedDataWithRootObject:reverse];
    [defaults setObject:tmp_d forKey:@"TEMPLATE"];
    
    [defaults synchronize];
    
}

- (IBAction)closeKeyboard:(id)sender {
    [_selectedTemplateText resignFirstResponder];
}

@end
