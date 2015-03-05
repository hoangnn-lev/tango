//
//  MainCategoryCollectionViewController.m
//  tango
//
//  Created by Hoang on 10/21/14.
//  Copyright (c) 2014 Hoang. All rights reserved.
//

#import "MainCategoryCollectionViewController.h"
#import "MainCategoryCollectionViewCell.h"
#import "DetailConversationViewController.h"
#import "ConversationViewController.h"
#import "ConversationTableViewCell.h"
#import "Conversation.h"
#import "DBManager.h"
#import "Categories.h"

@interface MainCategoryCollectionViewController (){
    NSString *current_language;
    NSMutableArray *categories;
    UISearchBar *searchBar;
    UITableView *searchResult;
    NSMutableArray *dataSearch;
}
@end

@implementation MainCategoryCollectionViewController

static NSString * const reuseIdentifier = @"MainCategoryCollectionViewCell";


-(void)viewWillAppear:(BOOL)animated{
    NSString *check_language = [[NSUserDefaults standardUserDefaults] stringForKey:@"language"];
    if (![current_language isEqualToString:check_language]) {
        current_language = check_language;
        [self loadData];
        [searchBar removeFromSuperview];
        [self searchButton];
    }
    self.navigationItem.title = @"";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    current_language = [[NSUserDefaults standardUserDefaults] stringForKey:@"language"];
    [self loadData];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
    [self searchButton];
  
}



-(void) searchButton{
    
    UIToolbar* keyboardDoneButtonView = [[UIToolbar alloc] init];
    [keyboardDoneButtonView sizeToFit];
    UIBarButtonItem *flexBarButton = [[UIBarButtonItem alloc]
                                      initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                      target:nil action:nil];
    UIBarButtonItem* doneButton = [[UIBarButtonItem alloc] initWithTitle:[Language get:@"cancel" alter:nil]
                                                                   style:UIBarButtonItemStyleBordered target:self
                                                                  action:@selector(doneClicked:)];
    [keyboardDoneButtonView setItems:[NSArray arrayWithObjects:flexBarButton, doneButton, nil]];
    
    searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 44.0)];
    searchBar.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
    UIView *searchBarView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 44.0)];
    searchBarView.autoresizingMask = 0;
    searchBar.barTintColor = [UIColor clearColor];
    searchBar.backgroundImage = [UIImage new];
    searchBar.delegate = self;
    searchBar.placeholder = @"Search...";
    searchBar.inputAccessoryView = keyboardDoneButtonView;
    
    [searchBarView addSubview:searchBar];
    self.navigationItem.titleView = searchBarView;
}

- (IBAction)doneClicked:(id)sender
{
    [self.view endEditing:YES];
    [searchBar resignFirstResponder];
}

-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{

    if (searchResult==nil) {
        searchResult = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, 320, 200)];
        searchResult.backgroundColor = [UIColor whiteColor];
        searchResult.delegate = self;
        searchResult.dataSource = self;
        searchResult.tableFooterView  =[[UIView alloc] init];
        [self.view addSubview:searchResult];
        
    }
    searchResult.hidden = NO;
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    if (dataSearch==nil) {
        dataSearch = [[NSMutableArray alloc] init];
    }
    if ([searchText isEqualToString:@""]) {
        dataSearch = nil;
    }else{
        NSString *sql = [NSString stringWithFormat:@"select id, native_language, second_language, favorite from conversations where native_language like '%%%@%%' and language='%@'", searchText, current_language];
        dataSearch = [[DBManager getSharedInstance] getConversation:sql];
        
    }
   [searchResult reloadData];
}

-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    searchResult.hidden = YES;
}

- (void)keyboardWillChange:(NSNotification *)notification {
    CGRect keyboardRect = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    keyboardRect = [self.view convertRect:keyboardRect fromView:nil];

    searchResult.frame = CGRectMake(0, 64, 320, self.view.frame.size.height -  64 - keyboardRect.size.height);
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [dataSearch count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ConversationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"row"];
    cell = [[ConversationTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"row"];
    Conversation *conv = [dataSearch objectAtIndex:indexPath.row];
    cell.textLabel.text = conv.native_language;
    cell.detailTextLabel.text = conv.second_language;
    cell.detailTextLabel.textColor = [UIColor grayColor];
    
    return cell;
}

-(void) loadData{

    NSString *sql = [NSString stringWithFormat:@"select id, name, img from topics where language='%@'", current_language];
    categories = [[DBManager getSharedInstance] getCategory:sql];
    [self.collectionView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [categories count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MainCategoryCollectionViewCell *cell = (MainCategoryCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    Categories *cat = [categories objectAtIndex:indexPath.row];
    cell.title.text = cat.name;
    [cell setBackgroundView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:cat.img]]];

    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    Categories *cat = [categories objectAtIndex:indexPath.row];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ConversationViewController *detail = [storyboard instantiateViewControllerWithIdentifier:@"ConversationViewController"];
    detail.topic_id = cat.id;
    detail.topic_name = cat.name;
    [self.navigationController pushViewController:detail animated:YES];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    DetailConversationViewController *detail = [storyboard instantiateViewControllerWithIdentifier:@"DetailConversationViewController"];
    detail.conv = [dataSearch objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:detail animated:YES];
}


@end
