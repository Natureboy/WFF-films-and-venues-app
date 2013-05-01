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
#import "LBYouTubePlayerController.h"

@interface SingleVenueViewController ()

@end

@implementation SingleVenueViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        _trailers = [[NSMutableArray alloc] init];
        NSArray *movieNames = @[@"Wild Horse, Wild Ride", @"It's in the Blood", @"Cinema Six", @"Five Time Champion", @"Shouting Secrets"];
        NSArray *trailerURL = @[@"http://www.youtube.com/watch?v=iPeW_cLC04k&feature=player_embedded", @"http://www.youtube.com/watch?v=ZSg_WtRTRjU&feature=player_embedded", @"http://www.youtube.com/watch?v=4SIASWxfwWc&feature=player_embedded", @"http://www.youtube.com/watch?v=Tty2h_OYEVA&feature=player_embedded", @"http://www.youtube.com/watch?v=-G3Yu0O5o7Q&feature=player_embedded"];
        for (int i = 0; i < 5; i++) {
            NSDictionary *dict = [[NSDictionary alloc] initWithObjects:@[[movieNames objectAtIndex:i], [trailerURL objectAtIndex:i] ] forKeys:@[@"movie", @"url"]];
            [_trailers addObject:dict];
        }
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Path to the plist (in the application bundle)
    NSString *path = [[NSBundle mainBundle] pathForResource:
                      @"Movies" ofType:@"plist"];
    
    // Build the array from the plist
    NSArray *movieArray = [[NSArray alloc] initWithContentsOfFile:path];
    
    _movies = [[NSMutableArray alloc] init];
    
    for (NSDictionary *dict in movieArray) {
        if ([[dict objectForKey:@"venue"] intValue] == _venueValue) {
            [_movies addObject:dict];
        }
    }
    
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


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"Movies";
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [_movies count];
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    for(UIView *eachView in [cell subviews]) {
        if ([eachView isKindOfClass:[UILabel class]] || [eachView isKindOfClass:[UIButton class]]) {
            [eachView removeFromSuperview];
        }
    }
    
    NSString *str = [NSString stringWithFormat:@"%@ -- %@", [[_movies objectAtIndex:indexPath.row] objectForKey:@"day"],[[_movies objectAtIndex:indexPath.row] objectForKey:@"time"]];
    
    // Configure the cell...
    UILabel *lbl1 = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 180, 50)];
    [lbl1 setFont:[UIFont fontWithName:@"LTTetria Bold" size:18.0]];
    [lbl1 setTextColor:[UIColor blackColor]];
    [lbl1 setBackgroundColor:[UIColor clearColor]];
    lbl1.text = [[_movies objectAtIndex:indexPath.row] objectForKey:@"movie"];
    [cell addSubview:lbl1];
    
    
    UILabel *lbl2 = [[UILabel alloc]initWithFrame:CGRectMake(20, 35, 200, 20)];
    [lbl2 setFont:[UIFont fontWithName:@"LTTetria Light" size:14.0]];
    [lbl2 setTextColor:[UIColor grayColor]];
    [lbl2 setBackgroundColor:[UIColor clearColor]];
    lbl2.text = str;
    [cell addSubview:lbl2];
    
    UIButton *favButton = [[UIButton alloc] initWithFrame:CGRectMake(275, 7, 40, 40)];
    favButton.tag = indexPath.row + 1000;
    
    [favButton setImage:[UIImage imageNamed:@"bttn-favorites-selected"] forState:UIControlStateSelected];
    [favButton setImage:[UIImage imageNamed:@"bttn-favorites"] forState:UIControlStateNormal];
    
    NSString *movie = [[_movies objectAtIndex:indexPath.row] objectForKey:@"movie"];
    NSString *day = [[_movies objectAtIndex:indexPath.row] objectForKey:@"day"];
    NSString *time = [[_movies objectAtIndex:indexPath.row] objectForKey:@"time"];
    
    if ([self isMovieFavorited:movie withTime:time withDay:day]) {
        [favButton setSelected:YES];
    } else {
        [favButton setSelected:NO];
    }
    
    [favButton addTarget:self action:@selector(favoriteButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [cell addSubview:favButton];
    
    for (int i = 0; i < [_trailers count]; i++) {
        NSDictionary *dict = [_trailers objectAtIndex:i];
        if ([movie isEqualToString:[dict objectForKey:@"movie"]]) {
            UIButton *playButton = [[UIButton alloc] initWithFrame:CGRectMake(240, 15, 30, 30)];
            playButton.tag = i + 100;
            [playButton addTarget:self action:@selector(playTrailer:) forControlEvents:UIControlEventTouchUpInside];
            [playButton setImage:[UIImage imageNamed:@"play-button"] forState:UIControlStateNormal];
            [cell addSubview:playButton];
            break;
        }
    }
    
    return cell;
}

-(void)playTrailer:(id)sender {
    UIButton *btnClicked = (UIButton *)sender;
    int tagVal = btnClicked.tag - 100;
    
    NSString *url = [[_trailers objectAtIndex:tagVal] objectForKey:@"url"];
    
    self.controller = [[LBYouTubePlayerController alloc] initWithYouTubeURL:[NSURL URLWithString:url] quality:LBYouTubeVideoQualityLarge];
    self.controller.controlStyle = MPMovieControlStyleFullscreen;
    self.controller.delegate = self;
    self.controller.view.frame = self.view.window.frame;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(videoPlayBackDidFinish:) name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
    [self.view.window addSubview:self.controller.view];
    [self.controller play];
    
}

-(void)videoPlayBackDidFinish:(NSNotification*)notification  {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
    [self.controller stop];
    [self.controller.view removeFromSuperview];
    self.controller = nil;
}

-(void)youTubePlayerViewController:(LBYouTubePlayerController *)controller didSuccessfullyExtractYouTubeURL:(NSURL *)videoURL {
    NSLog(@"Did extract video source:%@", videoURL);
}

-(void)youTubePlayerViewController:(LBYouTubePlayerController *)controller failedExtractingYouTubeURLWithError:(NSError *)error {
    NSLog(@"Failed loading video due to error:%@", error);
}

-(BOOL)isMovieFavorited:(NSString *)movie withTime:(NSString *)time withDay:(NSString *)day {
    NSMutableArray *favoritesArray = [[NSMutableArray alloc] initWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"favoritedMovies"]];
    
    /* checks if project is favorited */
    for (int i = 0; i < [favoritesArray count]; i++) {
        NSString *testMovieName = [[favoritesArray objectAtIndex:i] objectAtIndex:0];
        NSString *testTime = [[favoritesArray objectAtIndex:i] objectAtIndex:1];
        NSString *testDay = [[favoritesArray objectAtIndex:i] objectAtIndex:2];
        
        if ([movie isEqualToString:testMovieName]) {
            if ([time isEqualToString:testTime]) {
                if ([day isEqualToString:testDay]) {
                    return YES;
                }
            }
        }
    }
    
    return NO;
}

/* removes the specified project from favorites */
-(void)removeClickedMovie:(NSString *)movie withTime:(NSString *)time withDay:(NSString *)day {
    NSMutableArray *favoritesArray = [[NSMutableArray alloc] initWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"favoritedMovies"]];
    
    /* finds the project to remove */
    for (int i = 0; i < [favoritesArray count]; i++) {
        NSString *testMovieName = [[favoritesArray objectAtIndex:i] objectAtIndex:0];
        NSString *testTime = [[favoritesArray objectAtIndex:i] objectAtIndex:1];
        NSString *testDay = [[favoritesArray objectAtIndex:i] objectAtIndex:2];
        
        if ([movie isEqualToString:testMovieName]) {
            if ([testTime isEqualToString:time]) {
                if ([testDay isEqualToString:day]) {
                    [favoritesArray removeObjectAtIndex:i];
                    [[NSUserDefaults standardUserDefaults] setObject:favoritesArray forKey:@"favoritedMovies"];
                    break;
                }
            }
        }
    }
    
    [[NSUserDefaults standardUserDefaults] synchronize];
}

/* adds the specified project to favorites */
-(void)addClickedMovie:(NSString *)movie withTime:(NSString *)time withDay:(NSString *)day {
    NSMutableArray *favoritesArray = [[NSMutableArray alloc] initWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"favoritedMovies"]];
    NSArray *comparativeFavoritesValues = [[NSArray alloc] initWithObjects:movie, time, day, nil];
    [favoritesArray addObject:comparativeFavoritesValues];
    [[NSUserDefaults standardUserDefaults] setObject:favoritesArray forKey:@"favoritedMovies"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

-(void)favoriteButtonClicked:(id)sender {
    UIButton *btnClicked = (UIButton *)sender;
    [btnClicked setSelected:![btnClicked isSelected]];
    
    int tagVal = btnClicked.tag - 1000;
    
    NSString *movie = [[_movies objectAtIndex:tagVal] objectForKey:@"movie"];
    NSString *day = [[_movies objectAtIndex:tagVal] objectForKey:@"day"];
    NSString *time = [[_movies objectAtIndex:tagVal] objectForKey:@"time"];
    
    if ([btnClicked isSelected]) {
        [self addClickedMovie:movie withTime:time withDay:day];
    } else {
        [self removeClickedMovie:movie withTime:time withDay:day];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end
