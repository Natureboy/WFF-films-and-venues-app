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

@end
