//
//  TopViewController.m
//  tango
//
//  Created by Hoang on 9/24/14.
//  Copyright (c) 2014 Hoang. All rights reserved.
//

#import "DBManager.h"
#import "Categories.h"
#import "TopViewController.h"
#import "CategoryTableViewCell.h"
#import "ConversationViewController.h"

@interface TopViewController (){
    NSString *current_language;
    NSMutableArray *categories;
    BOOL isFirstLoad;
}

@end

@implementation TopViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewDidAppear:(BOOL)animated{
    if (isFirstLoad==1) {
        isFirstLoad = 0;
        return;
    }
    
    NSString *check_language = [[NSUserDefaults standardUserDefaults] stringForKey:@"language"];
    if (![current_language isEqualToString:check_language]) {
        current_language = check_language;
        [self loadData];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UITabBar *tabBar = self.tabBarController.tabBar;
    
    UITabBarItem *item0 = [tabBar.items objectAtIndex:0];
    UITabBarItem *item1 = [tabBar.items objectAtIndex:1];
    UITabBarItem *item2 = [tabBar.items objectAtIndex:2];
    UITabBarItem *item3 = [tabBar.items objectAtIndex:3];
    
    item0.title = [Language get:@"Top" alter:nil];
    item1.title = [Language get:@"Favorites" alter:nil];
    item2.title = [Language get:@"History" alter:nil];
    item3.title = [Language get:@"Setting" alter:nil];
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    current_language = [[NSUserDefaults standardUserDefaults] stringForKey:@"language"];
    isFirstLoad = 1;
    [self loadData];
}

-(void) loadData{
    
    self.navigationItem.title = [Language get:@"categories" alter:nil];
    
    NSString *sql = [NSString stringWithFormat:@"select id, name from topics where language='%@'", current_language];
    categories = [[DBManager getSharedInstance] getCategory:sql];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [categories count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *row = @"categories-row";
    
    Categories *cat = [categories objectAtIndex:indexPath.row];
    CategoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:row];
    
    cell = [[CategoryTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:row];
    cell.textLabel.text = cat.name;
    cell.detailTextLabel.text = @"";
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    Categories *cat = [categories objectAtIndex:indexPath.row];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ConversationViewController *detail = [storyboard instantiateViewControllerWithIdentifier:@"ConversationViewController"];
    detail.topic_id = cat.id;
    
    [self.navigationController pushViewController:detail animated:YES];
}

@end
