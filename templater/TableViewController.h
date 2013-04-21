//
//  TableViewController.h
//  templater
//
//  Created by 奈良 貴仁 on 2013/02/16.
//  Copyright (c) 2013年 奈良 貴仁. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h> 
#import "PostViewController.h"

@interface TableViewController : UITableViewController<ADBannerViewDelegate>

@property (retain, nonatomic) ADBannerView *customAdView;
@property (weak, nonatomic)   IBOutlet UITableViewCell *templateCell;
@property (strong, nonatomic) PostViewController       *postViewController;
@property (strong, nonatomic) NSMutableArray           *tableListData;

@end
