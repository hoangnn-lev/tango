
//
//  LanguageTableViewController.m
//  tango
//
//  Created by Hoang on 9/28/14.
//  Copyright (c) 2014 Hoang. All rights reserved.
//

#import "LanguageTableViewController.h"

@interface LanguageTableViewController (){
    NSArray *lng;
}

@end

@implementation LanguageTableViewController

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
    [self init_views];
}

-(void) init_views{
    lng = [[NSArray alloc] initWithObjects:
           [Language get:@"English" alter:nil],
           [Language get:@"Japanese" alter:nil],
           [Language get:@"Korean" alter:nil], nil];
    self.tableView.tableFooterView  = [[UIView alloc] initWithFrame:CGRectZero];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [lng count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"language" forIndexPath:indexPath];
    cell.textLabel.text = lng[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.row) {
        case 0:
            [Language setLanguage:@"en"];
            break;
        case 1:
            [Language setLanguage:@"ja"];
            break;
        default:
            [Language setLanguage:@"ko"];
            break;
    }

    
    UITabBar *tabBar = self.tabBarController.tabBar;
    
    UITabBarItem *item0 = [tabBar.items objectAtIndex:0];
    UITabBarItem *item1 = [tabBar.items objectAtIndex:1];
    UITabBarItem *item2 = [tabBar.items objectAtIndex:2];
    UITabBarItem *item3 = [tabBar.items objectAtIndex:3];
    
    item0.title = [Language get:@"Top" alter:nil];
    item1.title = [Language get:@"Favorites" alter:nil];
    item2.title = [Language get:@"History" alter:nil];
    item3.title = [Language get:@"Setting" alter:nil];
    
    [self init_views];
    [self.tableView reloadData];
}

@end
