//
//  ScheduleTableViewController.h
//  Films and Venues app
//
//  Created by Jordan Carney on 3/21/13.
//  Copyright (c) 2013 Jordan Carney. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LBYouTube.h"

@interface ScheduleTableViewController : UITableViewController <LBYouTubePlayerControllerDelegate> {
    LBYouTubePlayerController* _controller;
}

@property (strong,nonatomic) NSArray *movieArray;
@property (strong,nonatomic) NSArray *venuesArray;
@property (strong,nonatomic) NSMutableArray *splitMovieArray;
@property (strong,nonatomic) NSMutableArray *trailers;

@property (strong,nonatomic) NSString *lastClickedMovie;

@property (nonatomic, strong) LBYouTubePlayerController* controller;

@end
