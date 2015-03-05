
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

-(void)viewWillAppear:(BOOL)animated{
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.tableFooterView  = [[UIView alloc] initWithFrame:CGRectZero];
    self.navigationItem.title =[Language get:@"Language" alter:nil];
    self.navigationController.navigationBar.topItem.title = @"";
    lng = [[NSArray alloc] initWithObjects:@"en_vn_1.png",@"jp_vn_1.png",@"kr_vn_1.png", nil];
    
    
}
-(BOOL)hidesBottomBarWhenPushed{
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
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
    UITabBarItem *item4 = [tabBar.items objectAtIndex:4];
    
    item0.title = [Language get:@"Translate" alter:nil];
    item1.title = [Language get:@"History" alter:nil];
    item2.title = [Language get:@"Home" alter:nil];
    item3.title = [Language get:@"Favorites" alter:nil];
    item4.title = [Language get:@"Setting" alter:nil];
    
    [tableView reloadData];
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *cellId = [NSString stringWithFormat:@"cell-%li", (long)indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell==nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
        UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(20, 13, 18, 18)];
        img.image = [UIImage imageNamed:lng[indexPath.row]];
        
        [cell addSubview:img];
        
    }
    NSString *language = [[NSUserDefaults standardUserDefaults] stringForKey:@"language"];
    if ([language isEqualToString:@"en"] && indexPath.row==0) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }else if ([language isEqualToString:@"ja"] && indexPath.row==1) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }else if ([language isEqualToString:@"ko"] && indexPath.row==2) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }else{
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.row==0) {
        cell.textLabel.text = [Language get:@"english" alter:nil];
    }else{
        cell.textLabel.text = [Language get:@"japan" alter:nil];
    }
    
    
    return cell;
}

@end

    

    
    