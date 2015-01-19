//
//  ConversationViewController.m
//  tango
//
//  Created by Hoang on 9/24/14.
//  Copyright (c) 2014 Hoang. All rights reserved.
//
#import "DBManager.h"
#import "Conversation.h"
#import "ConversationViewController.h"
#import "ConversationTableViewCell.h"
#import "DetailConversationViewController.h"

@interface ConversationViewController (){
    NSMutableArray *datas;
    NSString *current_language;
}

@end

@implementation ConversationViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated{
    self.navigationItem.title = self.topic_name;
    NSString *check_language = [[NSUserDefaults standardUserDefaults] stringForKey:@"language"];
    if (![current_language isEqualToString:check_language]) {
        [self.navigationController popToRootViewControllerAnimated:NO];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    current_language = [[NSUserDefaults standardUserDefaults] stringForKey:@"language"];
    
    datas = [[NSMutableArray alloc] init];
    
    NSString *sql = [NSString stringWithFormat:@"select id, native_language, second_language, favorite from conversations where topic_id='%d'", self.topic_id];
    datas = [[DBManager getSharedInstance] getConversation:sql];
    self.tableView.tableFooterView = [[UIView alloc] init];

}

-(BOOL) hidesBottomBarWhenPushed{
    return YES;
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
    cell.textLabel.text = conv.native_language;
    cell.detailTextLabel.text = conv.second_language;
    cell.detailTextLabel.textColor = [UIColor grayColor];
     
    return cell;
 }

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
       
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    DetailConversationViewController *detail = [storyboard instantiateViewControllerWithIdentifier:@"DetailConversationViewController"];
    detail.conv = [datas objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:detail animated:YES];
}

@end
