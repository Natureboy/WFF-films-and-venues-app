//
//  MainAppDelegate.h
//  Films and Venues app
//
//  Created by Jordan Carney on 1/15/13.
//  Copyright (c) 2013 Jordan Carney. All rights reserved.
//

#import <UIKit/UIKit.h>


@class HomeViewController;

@interface MainAppDelegate : UIResponder <UIApplicationDelegate, UITabBarControllerDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) HomeViewController *homeViewController;

@end
