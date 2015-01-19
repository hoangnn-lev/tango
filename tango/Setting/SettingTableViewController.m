//
//  SettingTableViewController.m
//  tango
//
//  Created by Hoang on 9/28/14.
//  Copyright (c) 2014 Hoang. All rights reserved.
//

#import "SettingTableViewController.h"

@interface SettingTableViewController ()

@end

@implementation SettingTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    self.navigationItem.title = [Language get:@"Setting" alter:nil];
    self.language.textLabel.text = [Language get:@"Language" alter:nil];
    self.share.textLabel.text = [Language get:@"Share" alter:nil];
    self.about.textLabel.text = [Language get:@"About" alter:nil];
    self.contact.textLabel.text = [Language get:@"Contact" alter:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.tableFooterView = [[UIView alloc] init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==1) {
        NSArray *activityItems = @[@"Share app"];
        UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:nil];
        activityVC.hidesBottomBarWhenPushed = YES;
        [self presentViewController:activityVC animated:YES completion:nil];
        
    }else  if (indexPath.row==2) {
        UIAlertView *v = [[UIAlertView alloc] initWithTitle:@"Contact" message:@"Contact Info ..." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [v show];
    }else  if (indexPath.row==3) {
        UIAlertView *v = [[UIAlertView alloc] initWithTitle:@"About" message:@"Abour app" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [v show];
    }
}



@end
