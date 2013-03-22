//
//  MainAppDelegate.m
//  Films and Venues app
//
//  Created by Jordan Carney on 1/15/13.
//  Copyright (c) 2013 Jordan Carney. All rights reserved.
//

#import "MainAppDelegate.h"
#import "HomeViewController.h"
#import "AboutViewController.h"
#import "SponsersViewController.h"
#import "ContactViewController.h"
#import "MoreViewController.h"

@implementation MainAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    /* changes default text of the tab bar */
    NSMutableDictionary *attributes = [NSMutableDictionary dictionaryWithDictionary: [[UITabBarItem appearance] titleTextAttributesForState:UIControlStateNormal]];
    [attributes setValue:[UIFont fontWithName:@"LTTetria Bold" size:12] forKey:UITextAttributeFont];
    [[UITabBarItem appearance] setTitleTextAttributes:attributes forState:UIControlStateNormal];
    
    [[UINavigationBar appearance] setTitleTextAttributes: @{
                                UITextAttributeTextColor: [UIColor whiteColor],
                          UITextAttributeTextShadowColor: [UIColor grayColor],
                         UITextAttributeTextShadowOffset: [NSValue valueWithUIOffset:UIOffsetMake(0.0f, 1.0f)],
                                     UITextAttributeFont: [UIFont fontWithName:@"FISHfingers" size:28.0f]
     }];
    
    /* sets up all the various view controllers and corresponding nav controllers */
    
    /* home tab */
    _homeViewController = [[HomeViewController alloc] initWithNibName:@"HomeViewController" bundle:nil];
    _homeNavController = [[UINavigationController alloc] initWithRootViewController:_homeViewController];
    _homeNavController.navigationBar.barStyle = UIBarStyleBlack;
    
    /* about tab */
    _aboutViewController = [[AboutViewController alloc] initWithNibName:@"AboutViewController" bundle:nil];
    _aboutNavController = [[UINavigationController alloc] initWithRootViewController:_aboutViewController];
    _aboutNavController.navigationBar.barStyle = UIBarStyleBlack;
    
    /* sponsers tab */
    _sponsersViewController = [[SponsersViewController alloc] initWithNibName:@"SponsersViewController" bundle:nil];
    _sponsersNavController = [[UINavigationController alloc] initWithRootViewController:_sponsersViewController];
    _sponsersNavController.navigationBar.barStyle = UIBarStyleBlack;
    
    /* contact tab */
    _contactViewController = [[ContactViewController alloc] initWithNibName:@"ContactViewController" bundle:nil];
    _contactNavController = [[UINavigationController alloc] initWithRootViewController:_contactViewController];
    _contactNavController.navigationBar.barStyle = UIBarStyleBlack;
    
    /* more tab */
    _moreViewController = [[MoreViewController alloc] initWithNibName:@"MoreViewController" bundle:nil];
    _moreNavController = [[UINavigationController alloc] initWithRootViewController:_moreViewController];
    _moreNavController.navigationBar.barStyle = UIBarStyleBlack;
    
    /* sets up tab bar and adds nav controllers to it respectively */
    _tabBarController = [[UITabBarController alloc] init];
    _tabBarController.viewControllers = @[_homeNavController, _aboutNavController, _sponsersNavController, _contactNavController, _moreNavController];
    
    
    self.window.rootViewController = _tabBarController;
    [self.window makeKeyAndVisible];
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
