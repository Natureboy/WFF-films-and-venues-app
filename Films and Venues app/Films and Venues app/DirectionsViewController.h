//
//  DirectionsViewController.h
//  Films and Venues app
//
//  Created by Jordan Carney on 3/20/13.
//  Copyright (c) 2013 Jordan Carney. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface DirectionsViewController : UIViewController <MKMapViewDelegate> 



@property (nonatomic,strong) IBOutlet MKMapView *mapView;
@property (strong,nonatomic) NSArray *venuesArray;

@end
