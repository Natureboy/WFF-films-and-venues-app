//
//  ScheduleTableViewController.m
//  Films and Venues app
//
//  Created by Jordan Carney on 3/21/13.
//  Copyright (c) 2013 Jordan Carney. All rights reserved.
//

#import "ScheduleTableViewController.h"
#import "ADLivelyTableView.h"
#import "DMSlidingTableViewCell.h"

@interface ScheduleTableViewController () {
    NSMutableIndexSet* revealedCells;
}

@end

@implementation ScheduleTableViewController

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Schedule";
        
        // Path to the plist (in the application bundle)
        NSString *path = [[NSBundle mainBundle] pathForResource:
                          @"Movies" ofType:@"plist"];
        
        // Build the array from the plist
        _movieArray = [[NSArray alloc] initWithContentsOfFile:path];
        
        path = [[NSBundle mainBundle] pathForResource:
                @"Venues" ofType:@"plist"];
        
        _venuesArray = [[NSArray alloc] initWithContentsOfFile:path]; 
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    revealedCells= [[NSMutableIndexSet alloc] init];
    
    
    ADLivelyTableView * livelyTableView = (ADLivelyTableView *)self.tableView;
//    livelyTableView.initialCellTransformBlock = ADLivelyTransformFan;
        livelyTableView.initialCellTransformBlock = ADLivelyTransformHelix;
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [_movieArray count];
}

- (void) resetCellsState {
    [revealedCells enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL *stop) {
        DMSlidingTableViewCell *cell = ((DMSlidingTableViewCell*)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:idx inSection:0]]);
        [cell setBackgroundVisible:NO];
    }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    DMSlidingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[DMSlidingTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        cell.swipeDirection = DMSlidingTableViewCellSwipeBoth;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.eventHandler = ^(DMEventType eventType, BOOL backgroundRevealed, DMSlidingTableViewCellSwipe swipeDirection) {
        if (eventType == DMEventTypeDidOccurr) {
            if (backgroundRevealed)
                NSLog(@"revealed");
            else [revealedCells removeIndex:indexPath.row];
        }
    };
    
    for(UIView *eachView in [cell subviews])
        [eachView removeFromSuperview];
    
    NSMutableString *str = [[NSMutableString alloc] init];
    
    NSString *time = [[_movieArray objectAtIndex:indexPath.row] objectForKey:@"time"];
    NSString *date = [[_movieArray objectAtIndex:indexPath.row] objectForKey:@"day"];
    
    int index = [[[_movieArray objectAtIndex:indexPath.row] objectForKey:@"venue"] intValue];
    
    NSString *img_name = [[_venuesArray objectAtIndex:index] objectForKey:@"image_name"];
    
    UIImage *img = [UIImage imageNamed:img_name];
    
    [str appendFormat:@"%@ -- %@", date, time];
    
    // Configure the cell...
    UILabel *lbl1 = [[UILabel alloc]initWithFrame:CGRectMake(90, 0, 220, 50)];
    [lbl1 setFont:[UIFont fontWithName:@"LTTetria Bold" size:18.0]];
    [lbl1 setTextColor:[UIColor blackColor]];
    [lbl1 setBackgroundColor:[UIColor clearColor]];
    lbl1.text = [[_movieArray objectAtIndex:indexPath.row] objectForKey:@"movie"];
    [cell addSubview:lbl1];

    
    UILabel *lbl2 = [[UILabel alloc]initWithFrame:CGRectMake(90, 40, 200, 20)];
    [lbl2 setFont:[UIFont fontWithName:@"LTTetria Light" size:14.0]];
    [lbl2 setTextColor:[UIColor grayColor]];
    [lbl2 setBackgroundColor:[UIColor clearColor]];
    lbl2.text = str;
    [cell addSubview:lbl2];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:img];
    imageView.frame = CGRectMake(10, 10, 60, 60);
    [cell addSubview:imageView];
    
    return cell;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    // Navigation logic may go here. Create and push another view controller.
    /*
     ; *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
