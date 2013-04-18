//
//  SideMenuViewController.m
//  MFSideMenuDemo
//
//  Created by Michael Frederick on 3/19/12.

#import "SideMenuViewController.h"
#import "MFSideMenu.h"
#import "HomeViewController.h"
#import "VenuesViewController.h"
#import "ScheduleTableViewController.h"
#import "FavoritesTableViewController.h"
#import "PhotoViewController.h"
#import <MapKit/MapKit.h>
#import "SponsorsViewController.h"

@implementation SideMenuViewController

@synthesize sideMenu;

-(void)allPinsLoaded {
    _val = 0;
    [MKMapItem openMapsWithItems:_holderArray launchOptions:nil];
}

- (void) viewDidLoad {
    [super viewDidLoad];
    
    // Path to the plist (in the application bundle)
    NSString *path = [[NSBundle mainBundle] pathForResource:
                      @"Venues" ofType:@"plist"];
    
    // Build the array from the plist
    _venuesArray = [[NSArray alloc] initWithContentsOfFile:path];
    
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(allPinsLoaded) name:kAllPinsLoaded object:nil];
//    CGRect searchBarFrame = CGRectMake(0, 0, self.tableView.frame.size.width, 45.0);
//    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:searchBarFrame];
//    searchBar.delegate = self;
//    self.tableView.tableHeaderView = searchBar;
    
    _tableElements = [[NSMutableArray alloc] initWithArray:@[@[@"Home"], @[@"Schedule", @"Venues", @"Directions", @"Favorites", @"Photos", @"Tickets", @"Sponsers"], @[@"Website", @"Facebook", @"Twitter", @"Pinterest"]]];
    _tableImages = [[NSMutableArray alloc] initWithArray:@[@[[UIImage imageNamed:@"home_icon"]], @[[UIImage imageNamed:@"schedule_icon"], [UIImage imageNamed:@"venues_icon"], [UIImage imageNamed:@"directions_icon"], [UIImage imageNamed:@"favorites_icon"], [UIImage imageNamed:@"photos_icon"], [UIImage imageNamed:@"tickets_icon"], [UIImage imageNamed:@"sponsers_icon"]], @[[UIImage imageNamed:@"website_icon"], [UIImage imageNamed:@"facebook_icon"], [UIImage imageNamed:@"twitter_icon"], [UIImage imageNamed:@"pinterest_icon"]]]];
}

- (UIImage *)imageWithImage:(UIImage *)image convertToSize:(CGSize)size {
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *destImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return destImage;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return @"";
    } else if (section == 1) {
        return @"Information";
    } else {
        return @"Social";
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_tableElements count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[_tableElements objectAtIndex:section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text = [[_tableElements objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    cell.imageView.image = [self imageWithImage:[[_tableImages objectAtIndex:indexPath.section] objectAtIndex:indexPath.row]  convertToSize:CGSizeMake(35, 35)];
    return cell;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 1 && indexPath.row == 2) {
        _holderArray = [[NSMutableArray alloc] init];
        
        for (int i = 0; i < [_venuesArray count]; i++) {
            
            NSString *location = [[_venuesArray objectAtIndex:i] objectForKey:@"address"];
            
            CLGeocoder *geocoder = [[CLGeocoder alloc] init];
            [geocoder geocodeAddressString:location
                         completionHandler:^(NSArray* placemarks, NSError* error){
                             if (placemarks && placemarks.count > 0) {
                                 CLPlacemark *topResult = [placemarks objectAtIndex:0];
                                 MKPlacemark *placemark = [[MKPlacemark alloc] initWithPlacemark:topResult];
                                 MKMapItem *mapItem = [[MKMapItem alloc] initWithPlacemark:placemark];
                                 [mapItem setName:[[_venuesArray objectAtIndex:i] objectForKey:@"name"]];
                                 
                                 [_holderArray addObject:mapItem];
                                 _val++;
                                 
                                 if (_val == [_venuesArray count]) {
                                     [[NSNotificationCenter defaultCenter] postNotificationName:kAllPinsLoaded object:nil];
                                 }
                             }
                         }
             ];
         
    }
        [self.sideMenu setMenuState:MFSideMenuStateClosed];
        return;
    }
    
    if (indexPath.section == 1 && indexPath.row == 5 ) {
        SVModalWebViewController *modalWebView = [[SVModalWebViewController alloc] initWithAddress:@"http://www.waterfrontfilm.org/wordpress/?product_cat=tickets"];
        //[self.sideMenu setMenuState:MFSideMenuStateClosed];
        [self.sideMenu.navigationController presentViewController:modalWebView animated:YES completion:nil];
        return;
    }
    
    if (indexPath.section == 2 && indexPath.row == 0) {
        NSString *url = @"http://www.waterfrontfilm.org";
        _svmController = [[SVModalWebViewController alloc] initWithAddress:url];
        [self.sideMenu.navigationController presentViewController:_svmController animated:YES completion:nil];
        return;
    }
    
    if (indexPath.section == 2 && indexPath.row == 1 ) {
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"fb://"]]){
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"fb://profile/waterfrontfilm"]];
        } else {
            NSString *url = @"https://facebook.com/waterfrontfilm";
            _svmController = [[SVModalWebViewController alloc] initWithAddress:url];
            [self.sideMenu.navigationController presentViewController:_svmController animated:YES completion:nil];
        }
        return;
    }
    
    if (indexPath.section == 2 && indexPath.row == 2) {
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"twitter://"]]){
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"twitter://user?screen_name=waterfrontfilm"]];
        } else {
            NSString *url = @"https://twitter.com/WaterfrontFilm";
            _svmController = [[SVModalWebViewController alloc] initWithAddress:url];
            [self.sideMenu.navigationController presentViewController:_svmController animated:YES completion:nil];
        }
        return;
    }
    
    if (indexPath.section == 2 && indexPath.row == 3) {
        NSString *url = @"http://www.pinterest.com/waterfrontfilm";
        _svmController = [[SVModalWebViewController alloc] initWithAddress:url];
        [self.sideMenu.navigationController presentViewController:_svmController animated:YES completion:nil];
        return;
    }
    
    HomeViewController *homeViewController = [[HomeViewController alloc] initWithNibName:@"HomeViewController" bundle:nil];
    ScheduleTableViewController *scheduleViewController = [[ScheduleTableViewController alloc] initWithNibName:@"ScheduleTableViewController" bundle:nil];
    VenuesViewController *venuesViewController = [[VenuesViewController alloc] initWithNibName:@"VenuesViewController" bundle:nil];
    FavoritesTableViewController *favoritesTableViewController = [[FavoritesTableViewController alloc] initWithNibName:@"FavoritesTableViewController" bundle:nil];
    PhotoViewController *photoViewController = [[PhotoViewController                                                 alloc] initWithNibName:@"PhotoViewController" bundle:nil];
    SponsorsViewController *sponsorsViewController = [[SponsorsViewController alloc] initWithNibName:@"SponsorsViewController" bundle:nil];
    
    _viewControllers = [[NSMutableArray alloc] initWithArray:@[homeViewController, scheduleViewController, venuesViewController, favoritesTableViewController, photoViewController, sponsorsViewController]];
    
    int accessValue = -1;
    
    if (indexPath.section == 0) accessValue = 0;
    
    if (indexPath.section == 1) {
        switch (indexPath.row) {
            case 0:
                accessValue = 1;
                break;
            case 1:
                accessValue = 2;
                break;
            case 3:
                accessValue = 3;
                break;
            case 4:
                accessValue = 4;
                break;
            case 6:
                accessValue = 5;
                break;
            default:
                break; 
        }
    }
    
    if (accessValue != -1) {
        NSArray *controllers = [NSArray arrayWithObject:[_viewControllers objectAtIndex:accessValue]];
        [self.sideMenu.navigationController popViewControllerAnimated:NO];
        self.sideMenu.navigationController.viewControllers = controllers;
        [self.sideMenu setMenuState:MFSideMenuStateClosed];
    }
}


#pragma mark - UISearchBarDelegate

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar {
    return YES;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
}

@end
