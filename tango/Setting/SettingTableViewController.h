//
//  SettingTableViewController.h
//  tango
//
//  Created by Hoang on 9/28/14.
//  Copyright (c) 2014 Hoang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingTableViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UITableViewCell *language;
@property (weak, nonatomic) IBOutlet UITableViewCell *share;
@property (weak, nonatomic) IBOutlet UITableViewCell *about;

@end
