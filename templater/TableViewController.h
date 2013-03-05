//
//  TableViewController.h
//  templater
//
//  Created by 奈良 貴仁 on 2013/02/16.
//  Copyright (c) 2013年 奈良 貴仁. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PostViewController.h"

@interface TableViewController : UITableViewController
{
    NSArray *tableListData;
}
- (IBAction)pressComposeButton:(id)sender;

@property (weak, nonatomic) IBOutlet UITableViewCell *templateCell;
@property (strong, nonatomic) PostViewController *postViewController;

@end
