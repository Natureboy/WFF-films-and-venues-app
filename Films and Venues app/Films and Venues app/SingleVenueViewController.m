//
//  SingleVenueViewController.m
//  Films and Venues app
//
//  Created by Jordan Carney on 4/9/13.
//  Copyright (c) 2013 Jordan Carney. All rights reserved.
//

#import "SingleVenueViewController.h"
#import "BButton.h"
#import <MapKit/MapKit.h>

@interface SingleVenueViewController ()

@end

@implementation SingleVenueViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(allPinsDone) name:kAllPinsDone object:nil];
    
    self.title = [_venueDict objectForKey:@"name"];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[_venueDict objectForKey:@"image_name"]]];
    [imageView setFrame:CGRectMake(10, 10, 100, 100)];
    [self.view addSubview:imageView];
    
    NSArray *strArray = [[_venueDict objectForKey:@"address"] componentsSeparatedByString:@"South"];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(130, 20, 200, 20)];
    [label setFont:[UIFont fontWithName:@"LTTetria Bold" size:18]];
    [label setText:[strArray objectAtIndex:0]];
    [label setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:label];
    
    
    UILabel *labelTwo = [[UILabel alloc] initWithFrame:CGRectMake(130, 40, 200, 20)];
    [labelTwo setFont:[UIFont fontWithName:@"LTTetria Light" size:14]];
    [labelTwo setText:[NSString stringWithFormat:@"South %@", [strArray objectAtIndex:1]]];
    [labelTwo setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:labelTwo];
    
    BButton *button = [[BButton alloc] initWithFrame:CGRectMake(130, 70, 150, 30)];
    [button setTitle:@"Get Directions!" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(getDirections:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    // Do any additional setup after loading the view from its nib.
}

-(void)getDirections:(id)sender {
    _holderArray = [[NSMutableArray alloc] init];
    
    NSString *location = [_venueDict objectForKey:@"address"];
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder geocodeAddressString:location
                 completionHandler:^(NSArray* placemarks, NSError* error){
                     if (placemarks && placemarks.count > 0) {
                         CLPlacemark *topResult = [placemarks objectAtIndex:0];
                         MKPlacemark *placemark = [[MKPlacemark alloc] initWithPlacemark:topResult];
                         MKMapItem *mapItem = [[MKMapItem alloc] initWithPlacemark:placemark];
                         [mapItem setName:[_venueDict objectForKey:@"name"]];
                         
                         [_holderArray addObject:mapItem];
                         _val++;
                         
                         if (_val == 1) {
                             [[NSNotificationCenter defaultCenter] postNotificationName:kAllPinsDone object:nil];
                         }
                     }
                 }
     ];
}

-(void)allPinsDone {
    _val = 0;
    [MKMapItem openMapsWithItems:_holderArray launchOptions:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end