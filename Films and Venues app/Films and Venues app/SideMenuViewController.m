//
//  SideMenuViewController.m
//  MFSideMenuDemo
//
//  Created by Michael Frederick on 3/19/12.

#import "SideMenuViewController.h"
#import "MFSideMenu.h"
#import "HomeViewController.h"

@implementation SideMenuViewController

@synthesize sideMenu;

- (void) viewDidLoad {
    [super viewDidLoad];
//    CGRect searchBarFrame = CGRectMake(0, 0, self.tableView.frame.size.width, 45.0);
//    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:searchBarFrame];
//    searchBar.delegate = self;
//    self.tableView.tableHeaderView = searchBar;
    
    _tableElements = [[NSMutableArray alloc] initWithArray:@[@[@"Home"], @[@"Schedule", @"Venues", @"Directions", @"Favorites", @"Photos", @"Tickets"], @[@"Facebook", @"Twitter", @"Pinterest"]]];
    _tableImages = [[NSMutableArray alloc] initWithArray:@[@[[UIImage imageNamed:@"home_icon"]], @[[UIImage imageNamed:@"schedule_icon"], [UIImage imageNamed:@"venues_icon"], [UIImage imageNamed:@"directions_icon"], [UIImage imageNamed:@"favorites_icon"], [UIImage imageNamed:@"photos_icon"], [UIImage imageNamed:@"tickets_icon"]], @[[UIImage imageNamed:@"facebook_icon"], [UIImage imageNamed:@"twitter_icon"], [UIImage imageNamed:@"twitter_icon"]]]];
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
    cell.imageView.image = [[_tableImages objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    return cell;
}




#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    HomeViewController *demoController = [[HomeViewController alloc] initWithNibName:@"HomeViewController" bundle:nil];
    demoController.title = [NSString stringWithFormat:@"Demo Controller #%d-%d", indexPath.section, indexPath.row];
    
    NSArray *controllers = [NSArray arrayWithObject:demoController];
    self.sideMenu.navigationController.viewControllers = controllers;
    [self.sideMenu setMenuState:MFSideMenuStateClosed];
}

#pragma mark - UISearchBarDelegate

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar {
    return YES;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
}

@end
