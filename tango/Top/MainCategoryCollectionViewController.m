//
//  MainCategoryCollectionViewController.m
//  tango
//
//  Created by Hoang on 10/21/14.
//  Copyright (c) 2014 Hoang. All rights reserved.
//

#import "MainCategoryCollectionViewController.h"
#import "MainCategoryCollectionViewCell.h"
#import "ConversationViewController.h"
#import "DBManager.h"
#import "Categories.h"

@interface MainCategoryCollectionViewController (){
    NSString *current_language;
    NSMutableArray *categories;
    UIImageView *logo;
}
@end

@implementation MainCategoryCollectionViewController

static NSString * const reuseIdentifier = @"MainCategoryCollectionViewCell";


-(void)viewWillAppear:(BOOL)animated{
    [logo setHidden:NO];
    NSString *check_language = [[NSUserDefaults standardUserDefaults] stringForKey:@"language"];
    if (![current_language isEqualToString:check_language]) {
        current_language = check_language;
        [self loadData];
    }
    self.navigationItem.title = @"";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    current_language = [[NSUserDefaults standardUserDefaults] stringForKey:@"language"];
    [self loadData];
    logo = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2 - 38, 25, 76, 30)];
    logo.image = [UIImage imageNamed:@"logo_1.png"];
    [self.navigationController.view addSubview:logo];
  
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
    [logo setHidden:YES];
    [self.navigationController pushViewController:detail animated:YES];
}

@end
