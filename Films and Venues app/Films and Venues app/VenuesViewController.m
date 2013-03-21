//
//  VenuesViewController.m
//  Films and Venues app
//
//  Created by Jordan Carney on 2/18/13.
//  Copyright (c) 2013 Jordan Carney. All rights reserved.
//

#import "VenuesViewController.h"

@interface VenuesViewController ()

@end

@implementation VenuesViewController

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
    cell.imageView.image = img;
    
    cell.textLabel.font = [UIFont fontWithName:@"LTTetria Light" size:18];
    cell.textLabel.text = [dict objectForKey:@"name"];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_venuesArray count];
}
@end
