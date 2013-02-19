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
    [_twitterButton setImage:[UIImage imageNamed:@"twitter_icon"] forState:UIControlStateNormal];
    [_facebookButton setImage:[UIImage imageNamed:@"facebook_icon"] forState:UIControlStateNormal];
    
    // Do any additional setup after loading the view from its nib.
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)btnClicked:(id)sender {
    if (sender == _photosButton) {
        
    } else if (sender == _websiteButton) {
        [self goToWebsite];
    } else if (sender == _volunteerButton) {
        [self volunteer];
    } else if (sender == _donateButton) {
        [self donate];
    } else if (sender == _twitterButton) {
        [self goToTwitter];
    } else if (sender == _facebookButton) {
        [self goToFacebook];
    }
}

-(void)volunteer {

}

-(void)goToFacebook {
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"fb://"]]){
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"fb://profile/waterfrontfilm"]];
    } else {
        NSURL *url = [NSURL URLWithString:@"https://facebook.com/waterfrontfilm"];
        if (![[UIApplication sharedApplication] openURL:url]) {
            NSLog(@"%@%@",@"Failed to open url:",[url description]);
        }
    }
}

-(void)goToWebsite {
    NSString *wffURL = @"http://www.waterfrontfilm.org";
    NSURL *url = [NSURL URLWithString:wffURL];
    if (![[UIApplication sharedApplication] openURL:url]) {
        NSLog(@"%@%@",@"Failed to open url:",[url description]);
    }
}

-(void)goToTwitter {
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"twitter://"]]){
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"twitter://user?screen_name=waterfrontfilm"]];
    } else {
        NSURL *url = [NSURL URLWithString:@"https://twitter.com/WaterfrontFilm"];
        if (![[UIApplication sharedApplication] openURL:url]) {
            NSLog(@"%@%@",@"Failed to open url:",[url description]);
        }
    }
}

-(void)donate {

}

@end
