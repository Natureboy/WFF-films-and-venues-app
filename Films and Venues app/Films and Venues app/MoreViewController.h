//
//  MoreViewController.h
//  Films and Venues app
//
//  Created by Jordan Carney on 2/15/13.
//  Copyright (c) 2013 Jordan Carney. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MoreViewController : UIViewController

@property (nonatomic, strong) IBOutlet UIButton *photosButton;
@property (nonatomic, strong) IBOutlet UIButton *websiteButton;
@property (nonatomic, strong) IBOutlet UIButton *volunteerButton;
@property (nonatomic, strong) IBOutlet UIButton *donateButton;
@property (nonatomic, strong) IBOutlet UIButton *twitterButton;

-(IBAction)btnClicked:(id)sender;

@end
