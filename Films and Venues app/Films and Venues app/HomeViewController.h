//
//  HomeViewController.h
//  Films and Venues app
//
//  Created by Jordan Carney on 2/15/13.
//  Copyright (c) 2013 Jordan Carney. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iCarousel.h"

@interface HomeViewController : UIViewController <iCarouselDataSource, iCarouselDelegate>

@property (nonatomic, retain) IBOutlet iCarousel *carousel;

@property (nonatomic,strong) NSArray *carouselImages;
@property (nonatomic) NSArray *reviewInfo;
@property (nonatomic) NSArray *reviewer;

@property (strong,nonatomic) IBOutlet UITextView *reviewTextView;
@property (strong,nonatomic) IBOutlet UILabel *reviewerLabel;

@property (nonatomic) int incVal;
@property (nonatomic) int arrVal;

@end
