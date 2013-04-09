//
//  ScheduleTableViewController.h
//  Films and Venues app
//
//  Created by Jordan Carney on 3/21/13.
//  Copyright (c) 2013 Jordan Carney. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScheduleTableViewController : UITableViewController

@property (strong,nonatomic) NSArray *movieArray;
@property (strong,nonatomic) NSArray *venuesArray;
@property (strong,nonatomic) NSMutableArray *splitMovieArray;

@end
