//
//  SingleVenueViewController.h
//  Films and Venues app
//
//  Created by Jordan Carney on 4/9/13.
//  Copyright (c) 2013 Jordan Carney. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kAllPinsDone @"kAllPinsDone"

@interface SingleVenueViewController : UIViewController

@property (strong,nonatomic) NSDictionary *venueDict;

@property (strong,nonatomic) IBOutlet UIImageView *imageView;
@property (strong,nonatomic) NSMutableArray *holderArray;

@property (nonatomic) int val;

@end
