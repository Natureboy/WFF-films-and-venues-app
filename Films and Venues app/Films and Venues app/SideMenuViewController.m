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

@implementation SideMenuViewController

@synthesize sideMenu;

- (void) viewDidLoad {
    [super viewDidLoad];
//    CGRect searchBarFrame = CGRectMake(0, 0, self.tableView.frame.size.width, 45.0);
//    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:searchBarFrame];
//    searchBar.delegate = self;
//    self.tableView.tableHeaderView = searchBar;
    
    _tableElements = [[NSMutableArray alloc] initWithArray:@[@[@"Home"], @[@"Schedule", @"Venues", @"Directions", @"Favorites", @"Photos", @"Tickets"], @[@"Facebook", @"Twitter", @"Pinterest"]]];
    _tableImages = [[NSMutableArray alloc] initWithArray:@[@[[UIImage imageNamed:@"home_icon"]], @[[UIImage imageNamed:@"schedule_icon"], [UIImage imageNamed:@"venues_icon"], [UIImage imageNamed:@"directions_icon"], [UIImage imageNamed:@"favorites_icon"], [UIImage imageNamed:@"photos_icon"], [UIImage imageNamed:@"tickets_icon"]], @[[UIImage imageNamed:@"facebook_icon"], [UIImage imageNamed:@"twitter_icon"], [UIImage imageNamed:@"pinterest_icon"]]]];
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
    HomeViewController *homeViewController = [[HomeViewController alloc] initWithNibName:@"HomeViewController" bundle:nil];
    ScheduleTableViewController *scheduleViewController = [[ScheduleTableViewController alloc] initWithNibName:@"ScheduleTableViewController" bundle:nil];
    VenuesViewController *venuesViewController = [[VenuesViewController alloc] initWithNibName:@"VenuesViewController" bundle:nil];
    FavoritesTableViewController *favoritesTableViewController = [[FavoritesTableViewController alloc] initWithNibName:@"FavoritesTableViewController" bundle:nil];
    PhotoViewController *photoViewController = [[PhotoViewController                                                 alloc] initWithNibName:@"PhotoViewController" bundle:nil];
    
    _viewControllers = [[NSMutableArray alloc] initWithArray:@[homeViewController, scheduleViewController, venuesViewController, favoritesTableViewController, photoViewController]];
    
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
