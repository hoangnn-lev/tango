//
//  AppDelegate.m
//  tango
//
//  Created by Hoang on 9/24/14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{

    UITabBarController *tabBarController = (UITabBarController *)self.window.rootViewController;
    UITabBar *tabBar = tabBarController.tabBar;
    
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
    
    tabBar.tintColor = [UIColor colorWithRed:58/255.0f green:203/255.0f blue:124/255.0f alpha:1.0];
    //[tabBar setBackgroundImage:[[UIImage alloc] init]];
    [[UITabBar appearance] setShadowImage:[[UIImage alloc] init]];
    [[UITabBar appearance] setBarTintColor:[UIColor whiteColor]];
    
    //remove line in navigation
    [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
    
    //set background navigation
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:58/255.0f green:203/255.0f blue:124/255.0f alpha:1.0]];
    
    //back button color
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
   
    //text color
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    
    //set status bar color
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    //accessory tableview color
    [[UITableViewCell appearance] setTintColor:[UIColor colorWithRed:58/255.0f green:203/255.0f blue:124/255.0f alpha:1.0]];
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:NO];
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
