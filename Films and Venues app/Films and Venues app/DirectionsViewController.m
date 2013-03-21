//
//  DirectionsViewController.m
//  Films and Venues app
//
//  Created by Jordan Carney on 3/20/13.
//  Copyright (c) 2013 Jordan Carney. All rights reserved.
//

#import "DirectionsViewController.h"

@interface DirectionsViewController ()

@end

@implementation DirectionsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Directions", @"Directions");
        
        // Path to the plist (in the application bundle)
        NSString *path = [[NSBundle mainBundle] pathForResource:
                          @"Venues" ofType:@"plist"];
        
        // Build the array from the plist
        _venuesArray = [[NSArray alloc] initWithContentsOfFile:path];
        
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    
    for (int i = 0; i < [_venuesArray count]; i++) {
        
    NSString *location = [[_venuesArray objectAtIndex:i] objectForKey:@"address"];
        
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder geocodeAddressString:location
                 completionHandler:^(NSArray* placemarks, NSError* error){
                     if (placemarks && placemarks.count > 0) {
                         CLPlacemark *topResult = [placemarks objectAtIndex:0];
                         MKPlacemark *placemark = [[MKPlacemark alloc] initWithPlacemark:topResult];
                         
                         MKCoordinateRegion region = self.mapView.region;
                         region.center = placemark.region.center;
                         region.span.longitudeDelta = .03;
                         region.span.latitudeDelta = .03;
                         
                         [_mapView setRegion:region animated:YES];
                         [_mapView addAnnotation:placemark];
                     }
                 }
     ];
    }
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
