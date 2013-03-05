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
    
    tableListData = [[NSArray alloc] initWithObjects:nil];
    
    // NSUserDefaultsからデータを取得
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *d = [defaults dataForKey:@"TEMPLATE"];
    NSDictionary *dic = [NSKeyedUnarchiver unarchiveObjectWithData:d];
    
    // cellのリストに取得したデータを入れる
    for(NSString *str in dic){
        tableListData = [tableListData arrayByAddingObject:str];
    }
    
    // 表示をリロード
    [self.tableView reloadData];
    [super viewWillAppear:animated];
}

- (IBAction)pressComposeButton:(id)sender {

    NSLog(@"press button.");
}


#pragma mark - Table view data source


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tableListData count];
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
    cell.textLabel.text = [tableListData objectAtIndex:row];
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

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

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
    
    NSUInteger row = [indexPath row];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    PostViewController *postViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"detail"];
    
    postViewController.title = cell.textLabel.text;
    postViewController.selectedTitle = cell.textLabel.text;
        
    
    [[self navigationController] pushViewController:postViewController animated:YES];

    
    NSLog(@"選択された行は『%d行目』です！", row);

}



@end
