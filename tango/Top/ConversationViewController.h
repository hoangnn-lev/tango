//
//  ConversationViewController.h
//  tango
//
//  Created by Hoang on 9/24/14.
//  Copyright (c) 2014 Hoang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConversationViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
@property int topic_id;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property NSString* topic_name;
@end
