//
//  FavoritesTableViewController.m
//  tango
//
//  Created by Hoang on 9/29/14.
//  Copyright (c) 2014 Hoang. All rights reserved.
//

#import "DBManager.h"
#import "Conversation.h"
#import "ConversationTableViewCell.h"
#import "FavoritesTableViewController.h"
#import "DetailConversationViewController.h"

@interface FavoritesTableViewController (){
    NSString *current_language;
    NSMutableArray *datas;
}

@end

@implementation FavoritesTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    self.navigationItem.title = [Language get:@"Favorites" alter:nil];
}

-(void)viewDidAppear:(BOOL)animated{
    
    
    NSString *check_language = [[NSUserDefaults standardUserDefaults] stringForKey:@"language"];
    if (![current_language isEqualToString:check_language]) {
        current_language = check_language;
    }
    [self getRecord];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    current_language = [[NSUserDefaults standardUserDefaults] stringForKey:@"language"];
    
    [self getRecord];
}

-(void) getRecord{
    
    if (datas==nil) {
        datas = [[NSMutableArray alloc] init];
    }
    
    NSString *sql = [NSString stringWithFormat: @"select id, native_language, second_language, favorite from conversations where favorite=1 and language='%@'", current_language];
    datas = [[DBManager getSharedInstance] getConversation:sql];
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
    return [datas count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ConversationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"row"];
    cell = [[ConversationTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"row"];
    Conversation *conv = [datas objectAtIndex:indexPath.row];
    cell.textLabel.text = conv.second_language;
    cell.detailTextLabel.text = conv.native_language;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    DetailConversationViewController *detail = [storyboard instantiateViewControllerWithIdentifier:@"DetailConversationViewController"];
    detail.conv = [datas objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:detail animated:YES];
}


@end
