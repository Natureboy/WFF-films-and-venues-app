//
//  FavoritesTableViewController.h
//  Films and Venues app
//
//  Created by Jordan Carney on 4/8/13.
//  Copyright (c) 2013 Jordan Carney. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FavoritesTableViewController : UITableViewController <UIWebViewDelegate>

@property (strong,nonatomic) NSMutableArray *favoritesArray;
@property (strong,nonatomic) NSMutableArray *favoritesSplitArray;
@property (strong,nonatomic) NSMutableArray *trailers;
@property (strong,nonatomic) NSArray *venuesArray;

@end
