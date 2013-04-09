//
//  SponsorsViewController.m
//  Films and Venues app
//
//  Created by Jordan Carney on 4/9/13.
//  Copyright (c) 2013 Jordan Carney. All rights reserved.
//

#import "SponsorsViewController.h"

@interface SponsorsViewController ()

@end

@implementation SponsorsViewController

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
    
    [_titleLabel setFont:[UIFont fontWithName:@"LTTetria Bold" size:18]];
    
    //[self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background"]]];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
