//
//  TableViewController.m
//  templater
//
//  Created by 奈良 貴仁 on 2013/02/16.
//  Copyright (c) 2013年 奈良 貴仁. All rights reserved.
//

#import "TableViewController.h"

@interface TableViewController ()

@end

@implementation TableViewController


@synthesize customAdView  = _customAdView;
@synthesize templateCell  = _templateCell;
@synthesize tableListData = _tableListData;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }

    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    // iAd広告を画面の下に表示する。
    self.customAdView = [[ADBannerView alloc] initWithFrame:CGRectMake(0.0, 480.0, 0.0, 0.0)];
    self.customAdView.currentContentSizeIdentifier = ADBannerContentSizeIdentifierPortrait;
    self.customAdView.delegate = self;
    

    // デフォルトでアプリ操作の説明を入れる。
    // テンプレート情報を初期化
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    // テンプレート情報が存在したら、取り出す
    if([defaults dataForKey:@"TEMPLATE"]){
        NSData *reverse_tmp = [defaults dataForKey:@"TEMPLATE"];
        dic = [NSKeyedUnarchiver unarchiveObjectWithData:reverse_tmp];
    }
    
    // 新規に入力したテンプレートを取得
    NSString *step0_key = @"STEP0 あいさつ";
    NSString *step0_value = @"Templaterアプリをインストールしてくれて、\nありがとうございますm(_ _)m\n\nこのアプリは、\nSNSへの投稿で使う『定型文』を、\n自分で作成し、\nSNSへの投稿を行うアプリです。\n\n論より証拠で、\nSTEP0 -> STEP1 -> STEP2\nを辿ってみて、\nこのアプリをインストールしたことをSNSに投稿してみてください！！\n";
    
    NSString *step1_key = @"STEP1 Facebookへ投稿";
    NSString *step1_value = @"1. 最初のページの「Sample」をタップ\n\n   「Templaterアプリをインストールしたよー(*´ω｀*)」\n   と書いているのを確認してください。\n   この文章が嫌な人は編集してください(´・ω・｀)\n      \n2. Facebookボタンをタップ\n\n   投稿確認ボタンがでてくるので、\n   文章に問題なければ、「投稿」ボタンをタップ\n   \n3. Facebookに投稿完了！！\n";

    NSString *step2_key = @"STEP2 テンプレート追加";
    NSString *step2_value = @"1. 最初のページの追加ボタン「+」をタップ\n   \n   新しい画面がでてきて、\n   「Title」と「Contents」の記入箇所があることを確認してください。\n   ↓ のように記入してみてください。\n   \n   Title:    はじめてのテンプレート\n   Contents: 作成成功( ･´ｰ･｀)\n\n2. 保存ボタン「Save」をタップ\n   \n   最初のページにもどると「はじめてのテンプレート」が追加されてることを確認してください！\n\n3. テンプレート追加成功！！\n";
    
    NSString *step3_key = @"STEP3 テンプレートを基に投稿";
    NSString *step3_value = @"1. 最初のページの「はじめてのテンプレート」をタップ\n   \n   「作成成功( ･´ｰ･｀)」と表示されていることを確認してください。\n      \n2. 顔文字を編集\n\n   テンプレートの顔文字「( ･´ｰ･｀)」がえらそうなので、\n   今の気分に合わせた顔文字に編集してください。\n\n3. 投稿！！\n   \n   あとは、「STEP1」と同じように、投稿するだけ！!\n\n\n    \nこれで、チュートリアルは終了です。\n他にもいろいろ機能があるので、試してみたください。\nお付き合い、ありがとうございましたm(_ _)m\n";
    

    NSString *sample_key = @"Sample";
    NSString *sample_value = @"Templaterアプリをインストールしたよー(*´ω｀*)";
    
    [dic setObject:step0_value forKey:step0_key];
    [dic setObject:step1_value forKey:step1_key];
    [dic setObject:step2_value forKey:step2_key];
    [dic setObject:step3_value forKey:step3_key];
    [dic setObject:sample_value forKey:sample_key];
    
    // 新規に入力したテンプレートを保存
    NSData *d = [NSKeyedArchiver archivedDataWithRootObject:dic];
    [defaults setObject:d forKey:@"TEMPLATE"];
    [defaults synchronize];
    
    [self.view addSubview:_customAdView];
    
    
}

- (void)viewWillAppear:(BOOL)animated{

    // HACK: このtableListDataを明示的に記述しなければいけない理由が分からないが、
    //       コメントアウトするとテンプレートタイトルのリストが表示されない。
    //       コードをよりシンプルなものにするためには、改善の余地あり。
    _tableListData = [[NSMutableArray alloc] initWithObjects:nil];  // 表示させるテンプレートタイトルのリスト
    
    // NSUserDefaultsからテンプレート情報{"TITLE" => "CONTENTS"}を取得する。
    // 例: { "first title" => "This is the first title.\nThere is not the second title." }
    NSUserDefaults      *defaults          = [NSUserDefaults standardUserDefaults];
    NSData              *templateDicNSData = [defaults dataForKey:@"TEMPLATE"];
    NSMutableDictionary *templateDic       = [NSKeyedUnarchiver
                                              unarchiveObjectWithData:templateDicNSData];
    
    // テンプレート情報の辞書から、生タイトルリストを作る。
    NSMutableArray *rowTitleList = [NSMutableArray array];
    for(NSString   *str in templateDic){
        [rowTitleList addObject:str];
    }
    
    // 生タイトルリストからABC順にソートされたタイトルリストを作成する。
    NSArray *sortedTitleList = [rowTitleList sortedArrayUsingComparator:^(id obj1, id obj2) {
        return [obj1 compare:obj2];
    }];
    
    // ソートされたタイトルリストを表示用のタイトルリストに代入する。
    // 以下のようにキャストをすると、不具合が発生するとネット上にあったので、
    // for文で１つ１つ要素を代入した。
    //     不具合を起こす代入: _tableListData =  (NSMutableArray *)sortedTitleList;
    for(NSString *str in sortedTitleList){
        [_tableListData addObject:str];
    }

    // 表示をリロードする。
    [self.tableView reloadData];
    [super viewWillAppear:animated];
}


#pragma mark - Table view data source


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_tableListData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    NSInteger row = [indexPath row];
    cell.textLabel.font = [UIFont boldSystemFontOfSize:18];
    cell.textLabel.text = [_tableListData objectAtIndex:row];
    cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        
        // 編集したするデータを取得する。
        NSInteger           row        = [indexPath row];
        NSUserDefaults      *defaults  = [NSUserDefaults standardUserDefaults];
        NSData              *release   = [defaults dataForKey:@"TEMPLATE"];
        NSMutableDictionary *mdic      = [NSKeyedUnarchiver unarchiveObjectWithData:release];
        [mdic removeObjectForKey:_tableListData[row]];
              
        // 新規に入力したテンプレートを保存する。
        NSData *dic = [NSKeyedArchiver archivedDataWithRootObject:mdic];
        [defaults setObject:dic forKey:@"TEMPLATE"];
        
        // 選択したセルを削除する。
        [_tableListData removeObjectAtIndex: row];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    // 選択したセル
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    // アニメーション動作で、Post画面に移動する。
    // 遷移方法を設定する。
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    PostViewController *postViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"detail"];
    
    // Post画面の設定をする。
    postViewController.title         = cell.textLabel.text;
    postViewController.selectedTitle = cell.textLabel.text;

    [[self navigationController] pushViewController:postViewController animated:YES];

}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGRect frame = [[UIScreen mainScreen] applicationFrame];
    float viewHeight = frame.size.height;
    float adViewWidth = self.customAdView.frame.size.width;
    float adViewHeight = self.customAdView.frame.size.height;
    float navBarHeight = self.navigationController.navigationBar.frame.size.height;
    self.customAdView.center = CGPointMake(adViewWidth / 2, self.tableView.contentOffset.y + viewHeight - navBarHeight - adViewHeight / 2);
    [self.view bringSubviewToFront:self.customAdView];
}

- (void)bannerViewDidLoadAd:(ADBannerView *)banner
{
    CGRect frame = [[UIScreen mainScreen] applicationFrame];
    float viewHeight = frame.size.height;
    float adViewWidth = self.customAdView.frame.size.width;
    float adViewHeight = self.customAdView.frame.size.height;
    float navBarHeight = self.navigationController.navigationBar.frame.size.height;
    [UIView animateWithDuration:2.0
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.customAdView.center = CGPointMake(adViewWidth / 2, self.tableView.contentOffset.y + viewHeight - navBarHeight - adViewHeight / 2);
                         self.customAdView.alpha = 1.0;
                     }
                     completion:nil];
}

@end
