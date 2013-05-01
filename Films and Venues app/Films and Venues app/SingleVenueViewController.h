//
//  SingleVenueViewController.h
//  Films and Venues app
//
//  Created by Jordan Carney on 4/9/13.
//  Copyright (c) 2013 Jordan Carney. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LBYouTube.h"

#define kAllPinsDone @"kAllPinsDone"

@interface SingleVenueViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, LBYouTubePlayerControllerDelegate>

@property (nonatomic, strong) LBYouTubePlayerController* controller;

@property (strong,nonatomic) NSDictionary *venueDict;

@property (strong,nonatomic) NSMutableArray *movies;
@property (strong,nonatomic) NSMutableArray *trailers;

@property (strong,nonatomic) IBOutlet UIImageView *imageView;
@property (strong,nonatomic) NSMutableArray *holderArray;

@property (nonatomic) int val;

@property (nonatomic) int venueValue;

@end
