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
#import <MessageUI/MessageUI.h>

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
    
    /* table element titles and images associated with them -- add more elements here */
    _tableElements = @[@[@"Home"], @[@"Schedule", @"Venues", @"Directions", @"Bookmarks", @"Photos", @"Tickets", @"Sponsors"], @[@"Website", @"Facebook", @"Twitter", @"Pinterest", @"Contact"]];
    _tableImages = @[@[[UIImage imageNamed:@"home_icon"]], @[[UIImage imageNamed:@"schedule_icon"], [UIImage imageNamed:@"venues_icon"], [UIImage imageNamed:@"directions_icon"], [UIImage imageNamed:@"favorites_icon"], [UIImage imageNamed:@"photos_icon"], [UIImage imageNamed:@"tickets_icon"], [UIImage imageNamed:@"sponsers_icon"]], @[[UIImage imageNamed:@"website_icon"], [UIImage imageNamed:@"facebook_icon"], [UIImage imageNamed:@"twitter_icon"], [UIImage imageNamed:@"pinterest_icon"], [UIImage imageNamed:@"contact_icon"]]];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        return @"Information";
    } else if (section == 2) {
        return @"Social";
    }
    
    return @"";
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [imgView setImage:[UIImage imageNamed:@"section-head"]];
        return imgView;
    } else {
        return nil;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    	return 150;
    
    return 22;
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
    cell.imageView.image = [[_tableImages objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    cell.textLabel.font = [UIFont fontWithName:@"LTTetria Bold" size:22.0];
    return cell;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
   [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
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
        return;
    }
    
    if (indexPath.section == 1 && indexPath.row == 5 ) {
        SVModalWebViewController *modalWebView = [[SVModalWebViewController alloc] initWithAddress:@"http://www.waterfrontfilm.org/index.php?p=2&s=2"];
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
            NSString *url = @"https://facebook.com/waterfrontfilm";
            _svmController = [[SVModalWebViewController alloc] initWithAddress:url];
            [self.sideMenu.navigationController presentViewController:_svmController animated:YES completion:nil];
        return;
    }
    
    if (indexPath.section == 2 && indexPath.row == 2) {
            NSString *url = @"https://twitter.com/WaterfrontFilm";
            _svmController = [[SVModalWebViewController alloc] initWithAddress:url];
            [self.sideMenu.navigationController presentViewController:_svmController animated:YES completion:nil];
        return;
    }
    
    if (indexPath.section == 2 && indexPath.row == 3) {
        NSString *url = @"http://www.pinterest.com/waterfrontfilm";
        _svmController = [[SVModalWebViewController alloc] initWithAddress:url];
        [self.sideMenu.navigationController presentViewController:_svmController animated:YES completion:nil];
        return;
    }
    
    if (indexPath.section == 2 && indexPath.row == 4) {
        if ([MFMailComposeViewController canSendMail]) {
             MFMailComposeViewController *mailer = [[MFMailComposeViewController alloc] init];
            mailer.mailComposeDelegate = self;
            [mailer setToRecipients:@[@"info@waterfrontfilm.org"]];
            [self.sideMenu.navigationController presentViewController:mailer animated:YES completion:nil];
        }
        
        return;
    }
    
    HomeViewController *homeViewController = [[HomeViewController alloc] initWithNibName:@"HomeViewController" bundle:nil];
    ScheduleTableViewController *scheduleViewController = [[ScheduleTableViewController alloc] initWithNibName:@"ScheduleTableViewController" bundle:nil];
    VenuesViewController *venuesViewController = [[VenuesViewController alloc] initWithNibName:@"VenuesViewController" bundle:nil];
    FavoritesTableViewController *favoritesTableViewController = [[FavoritesTableViewController alloc] initWithNibName:@"FavoritesTableViewController" bundle:nil];
    PhotoViewController *photoViewController = [[PhotoViewController                                                 alloc] initWithNibName:@"PhotoViewController" bundle:nil];
    SponsorsViewController *sponsorsViewController = [[SponsorsViewController alloc] initWithNibName:@"SponsorsViewController" bundle:nil];
    
    _viewControllers = @[homeViewController, scheduleViewController, venuesViewController, favoritesTableViewController, photoViewController, sponsorsViewController];
    
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

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    // Remove the mail view
    [self.sideMenu.navigationController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UISearchBarDelegate

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar {
    return YES;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
}

@end
