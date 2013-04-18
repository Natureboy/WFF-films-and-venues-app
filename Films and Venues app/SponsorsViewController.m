//
//  SponsorsViewController.m
//  Films and Venues app
//
//  Created by Jordan Carney on 4/9/13.
//  Copyright (c) 2013 Jordan Carney. All rights reserved.
//

#import "SponsorsViewController.h"
#import "MFSideMenu.h"

@interface SponsorsViewController ()

@end

@implementation SponsorsViewController


-(void)viewDidAppear:(BOOL)animated {
    [self setupMenuBarButtonItems];
}

- (void)setupMenuBarButtonItems {
    switch (self.navigationController.sideMenu.menuState) {
        case MFSideMenuStateClosed:
            if([[self.navigationController.viewControllers objectAtIndex:0] isEqual:self]) {
                self.navigationItem.leftBarButtonItem = [self leftMenuBarButtonItem];
            } else {
                self.navigationItem.leftBarButtonItem = [self backBarButtonItem];
            }
            self.navigationItem.rightBarButtonItem = [self rightMenuBarButtonItem];
            break;
        case MFSideMenuStateLeftMenuOpen:
            self.navigationItem.leftBarButtonItem = [self leftMenuBarButtonItem];
            break;
        case MFSideMenuStateRightMenuOpen:
            self.navigationItem.rightBarButtonItem = [self rightMenuBarButtonItem];
            break;
    }
}

- (UIBarButtonItem *)backBarButtonItem {
    return [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back-arrow"]
                                            style:UIBarButtonItemStyleBordered
                                           target:self
                                           action:@selector(backButtonPressed:)];
}

- (UIBarButtonItem *)leftMenuBarButtonItem {
    return [[UIBarButtonItem alloc]
            initWithImage:[UIImage imageNamed:@"menu-icon.png"] style:UIBarButtonItemStyleBordered
            target:self.navigationController.sideMenu
            action:@selector(toggleLeftSideMenu)];
}

- (UIBarButtonItem *)rightMenuBarButtonItem {
    //    return [[UIBarButtonItem alloc]
    //            initWithImage:[UIImage imageNamed:@"menu-icon.png"] style:UIBarButtonItemStyleBordered
    //            target:self.navigationController.sideMenu
    //            action:@selector(toggleRightSideMenu)];
    return nil;
}

- (void)backButtonPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = NSLocalizedString(@"Sponsors", @"Sponsors");
        self.tabBarItem.image = [UIImage imageNamed:@"sponsers_icon"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [_titleLabel setFont:[UIFont fontWithName:@"LTTetria Bold" size:24]];
    
    //[self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background"]]];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
