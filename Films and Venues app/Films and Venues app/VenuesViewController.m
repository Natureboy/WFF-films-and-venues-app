//
//  VenuesViewController.m
//  Films and Venues app
//
//  Created by Jordan Carney on 2/18/13.
//  Copyright (c) 2013 Jordan Carney. All rights reserved.
//

#import "VenuesViewController.h"
#import "SingleVenueViewController.h"
#import "MFSideMenu.h"

@interface VenuesViewController ()

@end

@implementation VenuesViewController


-(void)viewDidAppear:(BOOL)animated {
    [self setupMenuBarButtonItems];
}

- (void)setupMenuBarButtonItems {
    switch (self.navigationController.sideMenu.menuState) {
        case MFSideMenuStateClosed:
            if([[self.navigationController.viewControllers objectAtIndex:0] isEqual:self]) {
                self.navigationItem.leftBarButtonItem = [self leftMenuBarButtonItem];
            } else {
                self.navigationItem.leftBarButtonItem = [self backBarButtonItem];
            }
            self.navigationItem.rightBarButtonItem = [self rightMenuBarButtonItem];
            break;
        case MFSideMenuStateLeftMenuOpen:
            self.navigationItem.leftBarButtonItem = [self leftMenuBarButtonItem];
            break;
        case MFSideMenuStateRightMenuOpen:
            self.navigationItem.rightBarButtonItem = [self rightMenuBarButtonItem];
            break;
    }
}

- (UIBarButtonItem *)backBarButtonItem {
    return [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back-arrow"]
                                            style:UIBarButtonItemStyleBordered
                                           target:self
                                           action:@selector(backButtonPressed:)];
}

- (UIBarButtonItem *)leftMenuBarButtonItem {
    return [[UIBarButtonItem alloc]
            initWithImage:[UIImage imageNamed:@"menu-icon.png"] style:UIBarButtonItemStyleBordered
            target:self.navigationController.sideMenu
            action:@selector(toggleLeftSideMenu)];
}

- (UIBarButtonItem *)rightMenuBarButtonItem {
    //    return [[UIBarButtonItem alloc]
    //            initWithImage:[UIImage imageNamed:@"menu-icon.png"] style:UIBarButtonItemStyleBordered
    //            target:self.navigationController.sideMenu
    //            action:@selector(toggleRightSideMenu)];
    return nil;
}

- (void)backButtonPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Venues";
        
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
    [super viewDidLoad];

    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SingleVenueViewController *svvc = [[SingleVenueViewController alloc] initWithNibName:@"SingleVenueViewController" bundle:nil];
    svvc.venueDict= [_venuesArray objectAtIndex:indexPath.row];
    svvc.venueValue = indexPath.row;
    [self.navigationController pushViewController:svvc animated:YES];
   [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIndentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIndentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIndentifier];
    }
    
    NSDictionary *dict = [_venuesArray objectAtIndex:indexPath.row];
    
    UIImage *img = [UIImage imageNamed:[dict objectForKey:@"image_name"]];
//    cell.imageView.image = img;
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 60, 60)];
    [imgView setImage:img];
    [cell addSubview:imgView];
    
//    cell.textLabel.frame = CGRectMake(90, 0, 180, 50);
//    cell.textLabel.font = [UIFont fontWithName:@"LTTetria Light" size:18];
//    cell.textLabel.text = [dict objectForKey:@"name"];
    
    UILabel *lbl1 = [[UILabel alloc]initWithFrame:CGRectMake(90, 20, 180, 50)];
    [lbl1 setFont:[UIFont fontWithName:@"LTTetria Bold" size:18.0]];
    [lbl1 setTextColor:[UIColor blackColor]];
    [lbl1 setBackgroundColor:[UIColor clearColor]];
    lbl1.text = [dict objectForKey:@"name"];
    [cell addSubview:lbl1];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_venuesArray count];
}
@end
