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
#import "SVModalWebViewController.h"
#import "SVWebViewController.h"

//#define kAllPinsLoaded @"kAllPinsLoaded"

@interface HomeViewController : UIViewController <iCarouselDataSource, iCarouselDelegate, UIWebViewDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) VenuesViewController *venuesViewController;

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

@property (nonatomic,strong) NSArray *venuesArray;

@property (nonatomic,strong) NSMutableArray *holderArray;

@property (nonatomic) int val;

@property (strong,nonatomic) IBOutlet UITextView *textView;
@property (strong,nonatomic) IBOutlet UILabel *label;

@property (nonatomic) int incVal;
@property (nonatomic) int arrVal;

@property (nonatomic) NSMutableArray *reviewInfo;
@property (nonatomic) NSMutableArray *reviewer;

@property (nonatomic) CGRect origRect;
@property (nonatomic) CGRect origRectLabel;

-(IBAction)btnClicked:(id)sender;

@end
