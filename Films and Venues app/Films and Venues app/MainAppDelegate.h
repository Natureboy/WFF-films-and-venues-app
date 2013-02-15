//
//  MainAppDelegate.h
//  Films and Venues app
//
//  Created by Jordan Carney on 1/15/13.
//  Copyright (c) 2013 Jordan Carney. All rights reserved.
//

#import <UIKit/UIKit.h>


@class HomeViewController;
@class AboutViewController;
@class SponsersViewController;
@class ContactViewController;
@class MoreViewController;

@interface MainAppDelegate : UIResponder <UIApplicationDelegate, UITabBarControllerDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) UITabBarController *tabBarController;

@property (strong, nonatomic) HomeViewController *homeViewController;
@property (strong, nonatomic) AboutViewController *aboutViewController;
@property (strong, nonatomic) SponsersViewController *sponsersViewController;
@property (strong, nonatomic) ContactViewController *contactViewController;
@property (strong, nonatomic) MoreViewController *moreViewController;

@end
