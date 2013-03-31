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


@synthesize templateCell = _templateCell;
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



@end
