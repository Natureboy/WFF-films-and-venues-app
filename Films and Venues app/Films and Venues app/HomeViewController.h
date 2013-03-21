//
//  HomeViewController.h
//  Films and Venues app
//
//  Created by Jordan Carney on 2/15/13.
//  Copyright (c) 2013 Jordan Carney. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iCarousel.h"
#import "VenuesViewController.h"
#import "DirectionsViewController.h"

@interface HomeViewController : UIViewController <iCarouselDataSource, iCarouselDelegate>

@property (nonatomic, strong) VenuesViewController *venuesViewController;
@property (nonatomic, strong) DirectionsViewController *directionsViewController;

@property (nonatomic, retain) IBOutlet iCarousel *carousel;

@property (nonatomic, strong) IBOutlet UIButton *scheduleButton;
@property (nonatomic, strong) IBOutlet UIButton *ticketsButton;
@property (nonatomic, strong) IBOutlet UIButton *venuesButton;
@property (nonatomic, strong) IBOutlet UIButton *directionsButton;
@property (nonatomic, strong) IBOutlet UIButton *playingButton;
@property (nonatomic, strong) IBOutlet UIButton *favoritesButton;

@property (nonatomic,strong) IBOutlet UILabel *scheduleLabel;
@property (nonatomic,strong) IBOutlet UILabel *ticketsLabel;
@property (nonatomic,strong) IBOutlet UILabel *venuesLabel;
@property (nonatomic,strong) IBOutlet UILabel *directionsLabel;
@property (nonatomic,strong) IBOutlet UILabel *playingLabel;
@property (nonatomic,strong) IBOutlet UILabel *favoritesLabel;

-(IBAction)btnClicked:(id)sender;

@end
