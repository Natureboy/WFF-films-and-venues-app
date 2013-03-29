//
//  MainAppDelegate.h
//  Films and Venues app
//
//  Created by Jordan Carney on 1/15/13.
//  Copyright (c) 2013 Jordan Carney. All rights reserved.
//

#import <UIKit/UIKit.h>


@class HomeViewController, AboutViewController, SponsersViewController, ContactViewController, MoreViewController;

@interface MainAppDelegate : UIResponder <UIApplicationDelegate, UITabBarControllerDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) UITabBarController *tabBarController;

@property (strong, nonatomic) UINavigationController *homeNavController;
@property (strong, nonatomic) UINavigationController *aboutNavController;
@property (strong, nonatomic) UINavigationController *sponsersNavController;
@property (strong, nonatomic) UINavigationController *contactNavController;
@property (strong, nonatomic) UINavigationController *moreNavController;

@property (strong, nonatomic) HomeViewController *homeViewController;
@property (strong, nonatomic) AboutViewController *aboutViewController;
@property (strong, nonatomic) SponsersViewController *sponsersViewController;
@property (strong, nonatomic) ContactViewController *contactViewController;
@property (strong, nonatomic) MoreViewController *moreViewController;

@end
