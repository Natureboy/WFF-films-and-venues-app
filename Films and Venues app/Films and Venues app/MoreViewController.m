//
//  MoreViewController.m
//  Films and Venues app
//
//  Created by Jordan Carney on 2/15/13.
//  Copyright (c) 2013 Jordan Carney. All rights reserved.
//

#import "MoreViewController.h"

@interface MoreViewController ()

@end

@implementation MoreViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"More", @"More");
        self.tabBarItem.image = [UIImage imageNamed:@"more_icon"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [_photosButton setImage:[UIImage imageNamed:@"photos_icon"] forState:UIControlStateNormal];
    [_websiteButton setImage:[UIImage imageNamed:@"website_icon"] forState:UIControlStateNormal];
    [_volunteerButton setImage:[UIImage imageNamed:@"volunteer_icon"] forState:UIControlStateNormal];
    [_donateButton setImage:[UIImage imageNamed:@"donate_icon"] forState:UIControlStateNormal];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
