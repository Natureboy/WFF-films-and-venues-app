//
//  FavoritesTableViewController.m
//  Films and Venues app
//
//  Created by Jordan Carney on 4/8/13.
//  Copyright (c) 2013 Jordan Carney. All rights reserved.
//

#import "FavoritesTableViewController.h"
#import "LBYouTubePlayerController.h"
#import "MFSideMenu.h"

@interface FavoritesTableViewController ()

@end

@implementation FavoritesTableViewController

//- (id)initWithStyle:(UITableViewStyle)style
//{
//    self = [super initWithStyle:style];
//    if (self) {
//        // Custom initialization
//        self.title = @"Favorites";
//    }
//    return self;
//}

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

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Favorites";
        
        // Path to the plist (in the application bundle)
        NSString *path = [[NSBundle mainBundle] pathForResource:
                          @"Movies" ofType:@"plist"];
        
        // Build the array from the plist
        NSArray *movieArray = [[NSArray alloc] initWithContentsOfFile:path];
        
        path = [[NSBundle mainBundle] pathForResource:
                @"Venues" ofType:@"plist"];
        
        NSArray *favs = [[NSUserDefaults standardUserDefaults] objectForKey:@"favoritedMovies"];
        
        _favoritesArray = [[NSMutableArray alloc] init];
        
        for (NSMutableArray *arr in favs) {
            NSString *movie = [arr objectAtIndex:0];
            NSString *time = [arr objectAtIndex:1];
            NSString *day = [arr objectAtIndex:2];
            
            for (NSDictionary *dict in movieArray) {
                NSString *testMovie = [dict objectForKey:@"movie"];
                NSString *testTime = [dict objectForKey:@"time"];
                NSString *testDay = [dict objectForKey:@"day"];
                
                if ([movie isEqualToString:testMovie] && [time isEqualToString:testTime] && [day isEqualToString:testDay]) {
                    [_favoritesArray addObject:dict];
                }
            }
        }
        
        _favoritesSplitArray = [[NSMutableArray alloc] init];
        
        for (int i = 0; i < 3; i++) {
            NSMutableArray *holderArray = [[NSMutableArray alloc] init];
            [_favoritesSplitArray addObject:holderArray];
        }
        
        for (NSDictionary *dict in _favoritesArray) {
            if ([[dict objectForKey:@"day"] isEqualToString:@"June 15"]) {
                [[_favoritesSplitArray objectAtIndex:0] addObject:dict];
            } else if ([[dict objectForKey:@"day"] isEqualToString:@"June 16"]) {
                [[_favoritesSplitArray objectAtIndex:1] addObject:dict];
            } else {
                [[_favoritesSplitArray objectAtIndex:2] addObject:dict];
            }
        }
        
        path = [[NSBundle mainBundle] pathForResource:@"Venues" ofType:@"plist"];
        _venuesArray = [[NSArray alloc] initWithContentsOfFile:path];
        
        
        // add this
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

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString *date;
    
    if (section == 0) {
        date = @"June 15";
    } else if (section == 1) {
        date = @"June 16";
    } else if (section == 2) {
        date = @"June 17";
    }
    
    return date;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    
    return [_favoritesSplitArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [[_favoritesSplitArray objectAtIndex:section] count];
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    for(UIView *eachView in [cell subviews])
        [eachView removeFromSuperview];
    
    NSMutableString *str = [[NSMutableString alloc] init];
    
    NSString *time = [[[_favoritesSplitArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectForKey:@"time"];
    
    int index = [[[[_favoritesSplitArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectForKey:@"venue"] intValue];
    
    NSString *img_name = [[_venuesArray objectAtIndex:index] objectForKey:@"image_name"];
    
    UIImage *img = [UIImage imageNamed:img_name];
    
    [str appendFormat:@"%@", time];
    
    // Configure the cell...
    UILabel *lbl1 = [[UILabel alloc]initWithFrame:CGRectMake(90, 0, 180, 50)];
    [lbl1 setFont:[UIFont fontWithName:@"LTTetria Bold" size:18.0]];
    [lbl1 setTextColor:[UIColor blackColor]];
    [lbl1 setBackgroundColor:[UIColor clearColor]];
    lbl1.text = [[[_favoritesSplitArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectForKey:@"movie"];
    [cell addSubview:lbl1];
    
    UILabel *lbl2 = [[UILabel alloc]initWithFrame:CGRectMake(90, 40, 200, 20)];
    [lbl2 setFont:[UIFont fontWithName:@"LTTetria Light" size:14.0]];
    [lbl2 setTextColor:[UIColor grayColor]];
    [lbl2 setBackgroundColor:[UIColor clearColor]];
    lbl2.text = str;
    [cell addSubview:lbl2];
    
    UIButton *imageButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 60, 60)];
    [imageButton setImage:img forState:UIControlStateNormal];
    [cell addSubview:imageButton];
    
    NSString *movie = [[[_favoritesSplitArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectForKey:@"movie"];
    
    for (int i = 0; i < [_trailers count]; i++) {
        NSDictionary *dict = [_trailers objectAtIndex:i];
        if ([movie isEqualToString:[dict objectForKey:@"movie"]]) {
            UIButton *playButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 40, 40)];
            playButton.tag = i + 100;
            [playButton addTarget:self action:@selector(playTrailer:) forControlEvents:UIControlEventTouchUpInside];
            [playButton setImage:[UIImage imageNamed:@"play-button"] forState:UIControlStateNormal];
            [imageButton addSubview:playButton];
            break;
        }
    }
    
    return cell;
}

    
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        //[tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        NSString *movie = [[[_favoritesSplitArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectForKey:@"movie"];
        NSString *time = [[[_favoritesSplitArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectForKey:@"time"];
        NSString *day = [[[_favoritesSplitArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectForKey:@"day"];
        
        [[_favoritesSplitArray objectAtIndex:indexPath.section] removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        [self removeClickedMovie:movie withTime:time withDay:day];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}

-(void)playTrailer:(id)sender {
    UIButton *btnClicked = (UIButton *)sender;
    int tagVal = btnClicked.tag - 100;
    
    NSString *url = [[_trailers objectAtIndex:tagVal] objectForKey:@"url"];
    
    self.controller = [[LBYouTubePlayerController alloc] initWithYouTubeURL:[NSURL URLWithString:url] quality:LBYouTubeVideoQualityLarge];
    self.controller.controlStyle = MPMovieControlStyleFullscreen;
    self.controller.delegate = self;
    //self.controller.view.transform = CGAffineTransformConcat(self.controller.view.transform, CGAffineTransformMakeRotation(M_PI_2));
    
    self.controller.view.frame = self.view.window.frame;
    //self.controller.view.center = self.view.center;
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
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
