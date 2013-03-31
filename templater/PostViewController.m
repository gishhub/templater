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
    
    // タイトルリストで選択したタイトルから、NSUserDefaultsに保存しているテンプレートを取り出す。
    NSUserDefaults      *defaults    = [NSUserDefaults standardUserDefaults];
    NSData              *data        = [defaults dataForKey:@"TEMPLATE"];
    NSMutableDictionary *templateDic = [NSKeyedUnarchiver unarchiveObjectWithData:data];

    // Post画面の設定をする。
    _selectedTemplateText                    = [[UITextView alloc] initWithFrame:CGRectMake(10.0, 20.0, 300.0, 200.0)];
    _selectedTemplateText.text               = [templateDic objectForKey:self.selectedTitle];
    _selectedTemplateText.layer.borderWidth  = 1;
    _selectedTemplateText.layer.borderColor  = [[UIColor blackColor] CGColor];
    _selectedTemplateText.layer.cornerRadius = 8;
    

    // キーボードの設定をする。
    UIButton* accessoryView = [UIButton buttonWithType:UIButtonTypeCustom];
    accessoryView.frame = CGRectMake(0,0,320,30);
    [accessoryView addTarget:self action:@selector(closeKeyboard:) forControlEvents:UIControlEventTouchUpInside];
    
    // "キーボード閉じるボタン"の作成をする。
    UIButton* closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    closeButton.frame = CGRectMake(320 - 50, 30 - 40, 50, 40);
    closeButton.backgroundColor = [UIColor grayColor];
    [closeButton setImage:[UIImage imageNamed:@"CloseTab.png"] forState:UIControlStateNormal];
    [closeButton addTarget:self action:@selector(closeKeyboard:) forControlEvents:UIControlEventTouchUpInside];
    
    // "キーボード閉じるボタン"をキーボードに配置する。
    [accessoryView addSubview:closeButton];
    
    // "キーボード閉じるボタン"付きキーボードを設定する。
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
    // NSUserDefaultsのデータを取得する。
    NSUserDefaults      *defaults          = [NSUserDefaults standardUserDefaults];
    NSData              *templateDicNSData = [defaults dataForKey:@"TEMPLATE"];
    NSMutableDictionary *templateDic       = [NSKeyedUnarchiver unarchiveObjectWithData:templateDicNSData];
    
    // テキストビューのテキスト内容を"NSUserDefaultsのデータ"に保存する。
    [templateDic setObject:_selectedTemplateText.text forKey:self.selectedTitle];
    NSData *newTemplateDicNSData = [NSKeyedArchiver archivedDataWithRootObject:templateDic];
    [defaults setObject:newTemplateDicNSData forKey:@"TEMPLATE"];
    
    [defaults synchronize];
    
}

- (IBAction)closeKeyboard:(id)sender {
    [_selectedTemplateText resignFirstResponder];
}

@end
