//
//  HomeViewController.m
//  Films and Venues app
//
//  Created by Jordan Carney on 2/15/13.
//  Copyright (c) 2013 Jordan Carney. All rights reserved.
//

#import "HomeViewController.h"
#import <MapKit/MapKit.h>
#import "SVModalWebViewController.h"
#import "ScheduleTableViewController.h"
#import "UIImage+Alpha.h"
#import "FavoritesTableViewController.h"
#import "MFSideMenu.h"

#define SCROLL_SPEED .15 //items per second, can be negative or fractional
#define NUMBER_OF_SPONSERS 10

@interface HomeViewController ()

@property (nonatomic, retain) NSMutableArray *items;
@property (nonatomic, assign) NSTimer *scrollTimer;
@property (nonatomic, assign) NSTimeInterval lastTime;

@end

@implementation HomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Home", @"Home");
        self.tabBarItem.image = [UIImage imageNamed:@"home_icon"];
        
        _reviewer = [[NSMutableArray alloc] init];
        _reviewInfo = [[NSMutableArray alloc] init];
        
        [_reviewInfo addObject:@"\"Ranked in the Top 5 Film Festivals!\""];
        [_reviewInfo addObject:@"\"One of the most refreshingly-laid back film events in the country.\""];
        [_reviewInfo addObject:@"\"An absolutely fun-filled weekend! The passion behind the festival is amazing!\""];
        
        [_reviewer addObject:@"-Sag Indie"];
        [_reviewer addObject:@"-DFP"];
        [_reviewer addObject:@"-Sean Elliott"];        
        
        _arrVal = 0;
        
        _origRect = _textView.frame;
        _origRectLabel = _label.frame;
    }
    return self;
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

- (UIBarButtonItem *)backBarButtonItem {
    return [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back-arrow"]
                                            style:UIBarButtonItemStyleBordered
                                           target:self
                                           action:@selector(backButtonPressed:)];
}

- (void)backButtonPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

//- (IBAction)pushAnotherPressed:(id)sender {
//    HomeViewController *demoController = [[HomeViewController alloc]
//                                          initWithNibName:@"DemoViewController"
//                                          bundle:nil];
//    
//    [self.navigationController pushViewController:demoController animated:YES];
//}


- (void)viewDidLoad
{
    
    [self setupMenuBarButtonItems];
    
    [super viewDidLoad];
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(allPinsLoaded) name:kAllPinsLoaded object:nil];
//    
//    UIImage *image = [UIImage imageNamed:@"wff-navBar"];
//    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
//    [self.navigationController.navigationBar.topItem setTitleView:imageView];
    
    _items = [NSMutableArray array];
    for (int i = 0; i < NUMBER_OF_SPONSERS; i++)
    {
        [_items addObject:[NSNumber numberWithInt:i]];
    }
    
    _lastTime = 0;
    
    _carousel.type = iCarouselTypeInvertedCylinder;
    
    [_scheduleButton setImage:[UIImage imageNamed:@"schedule_icon"] forState:UIControlStateNormal];
    [_ticketsButton setImage:[UIImage imageNamed:@"tickets_icon"] forState:UIControlStateNormal];
    [_venuesButton setImage:[UIImage imageNamed:@"venues_icon"] forState:UIControlStateNormal];
    [_directionsButton setImage:[UIImage imageNamed:@"directions_icon"] forState:UIControlStateNormal];
    [_playingButton setImage:[UIImage imageNamed:@"playing_icon"] forState:UIControlStateNormal];
    [_favoritesButton setImage:[UIImage imageNamed:@"favorites_icon"] forState:UIControlStateNormal];
    
    [_scheduleLabel setFont:[UIFont fontWithName:@"LTTetria Light" size:14]];
    [_ticketsLabel setFont:[UIFont fontWithName:@"LTTetria Light" size:14]];
    [_venuesLabel setFont:[UIFont fontWithName:@"LTTetria Light" size:14]];
    [_directionsLabel setFont:[UIFont fontWithName:@"LTTetria Light" size:14]];
    [_playingLabel setFont:[UIFont fontWithName:@"LTTetria Light" size:14]];
    [_favoritesLabel setFont:[UIFont fontWithName:@"LTTetria Light" size:14]];
    
    _venuesViewController = [[VenuesViewController alloc] initWithNibName:@"VenuesViewController" bundle:nil];
    
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background_test"]]];
    
    // Path to the plist (in the application bundle)
    NSString *path = [[NSBundle mainBundle] pathForResource:
                      @"Venues" ofType:@"plist"];
    
    // Build the array from the plist
    _venuesArray = [[NSArray alloc] initWithContentsOfFile:path];
    
    [self startScrolling];
    // Do any additional setup after loading the view from its nib.
}

-(void)allPinsLoaded {
    _val = 0;
    [MKMapItem openMapsWithItems:_holderArray launchOptions:nil];
}


-(void)btnClicked:(id)sender {
    if (sender == _scheduleButton) {
        ScheduleTableViewController *schedController = [[ScheduleTableViewController alloc] initWithNibName:@"ScheduleTableViewController" bundle:nil];
        [self.navigationController pushViewController:schedController animated:YES];
    } else if (sender == _ticketsButton) {
        SVModalWebViewController *modalWebView = [[SVModalWebViewController alloc] initWithAddress:@"http://www.waterfrontfilm.org/wordpress/?product_cat=tickets"];

        [self presentViewController:modalWebView animated:YES completion:nil];
    } else if (sender == _venuesButton) {
        UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle: @"Home" style: UIBarButtonItemStyleBordered target: nil action: nil];
        [self.navigationItem setBackBarButtonItem: backButton];
        
        [self.navigationController pushViewController:_venuesViewController animated:YES];
    } else if (sender == _directionsButton) {
        
//        _holderArray = [[NSMutableArray alloc] init];
//        
//        for (int i = 0; i < [_venuesArray count]; i++) {
//            
//            NSString *location = [[_venuesArray objectAtIndex:i] objectForKey:@"address"];
//            
//            CLGeocoder *geocoder = [[CLGeocoder alloc] init];
//            [geocoder geocodeAddressString:location
//                         completionHandler:^(NSArray* placemarks, NSError* error){
//                             if (placemarks && placemarks.count > 0) {
//                                 CLPlacemark *topResult = [placemarks objectAtIndex:0];
//                                 MKPlacemark *placemark = [[MKPlacemark alloc] initWithPlacemark:topResult];
//                                 MKMapItem *mapItem = [[MKMapItem alloc] initWithPlacemark:placemark];
//                                 [mapItem setName:[[_venuesArray objectAtIndex:i] objectForKey:@"name"]];
//                                 
//                                 [_holderArray addObject:mapItem];
//                                 _val++;
//                                 
//                                 if (_val == [_venuesArray count]) {
//                                     [[NSNotificationCenter defaultCenter] postNotificationName:kAllPinsLoaded object:nil];
//                                 }
//                             }
//                         }
//             ];
//        }
        
    } else if (sender == _playingButton) {
        
    } else if (sender == _favoritesButton) {
        FavoritesTableViewController *ftvc = [[FavoritesTableViewController alloc] initWithNibName:@"FavoritesTableViewController" bundle:nil];
        [self.navigationController pushViewController:ftvc animated:YES];
    }
}

-(void)webViewDidFinishLoad:(UIWebView *)webView {
    NSString *jsCommand = [NSString stringWithFormat:@"document.body.style.zoom = 1.5;"];
    [webView stringByEvaluatingJavaScriptFromString:jsCommand];
}

#pragma mark -
#pragma mark iCarousel methods

- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    //return the total number of items in the carousel
    return NUMBER_OF_SPONSERS;
}


- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index reusingView:(UIView *)view
{
	UIButton *button = (UIButton *)view;
	if (button == nil)
	{
		//no button available to recycle, so create new one
        NSString *imageName;
        
        NSLog(@"index = %d", index);
        
        if (index < 5) {
            imageName  = [NSString stringWithFormat:@"img%d.png", index + 1];
        } else if (index == 8) {
            imageName  = @"img4.png";
        } else if (index == 9) {
            imageName  = @"img5.png";
        }
        
		UIImage *image = [[UIImage imageNamed:imageName] transparentBorderImage:1];
        
        
		button = [UIButton buttonWithType:UIButtonTypeCustom];
		button.frame = CGRectMake(0.0f, 0.0f, image.size.width, image.size.height);
		[button setBackgroundImage:image forState:UIControlStateNormal];
		[button addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
	}

	return button;
}

#pragma mark -
#pragma mark Button tap event

- (void)buttonTapped:(UIButton *)sender
{
	//get item index for button
	NSInteger index = [_carousel indexOfItemViewOrSubview:sender];
	
    [[[UIAlertView alloc] initWithTitle:@"Button Tapped"
                                message:[NSString stringWithFormat:@"You tapped button number %i", index]
                               delegate:nil
                      cancelButtonTitle:@"OK"
                      otherButtonTitles:nil]show];
}

- (CGFloat)carousel:(iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value
{
    switch (option)
    {
        case iCarouselOptionSpacing:
            return value * 1.1;
        default:
            return value;
    }
}

#pragma mark -
#pragma mark Autoscroll

- (void)startScrolling
{
    [_scrollTimer invalidate];
    _scrollTimer = [NSTimer scheduledTimerWithTimeInterval:1.0/30.0
                                                    target:self
                                                  selector:@selector(scrollStep)
                                                  userInfo:nil
                                                   repeats:YES];
    
}

- (void)stopScrolling
{
    [_scrollTimer invalidate];
    _scrollTimer = nil;
}

- (void)scrollStep
{
    //calculate delta time
    NSTimeInterval now = [NSDate timeIntervalSinceReferenceDate];
    float delta = _lastTime - now;
    _lastTime = now;
    
    _incVal += 1;
    
    if (_incVal == 100) {
        _incVal = 0;
//        [UIView animateWithDuration:0.25 animations:^{_textView.alpha = 0.0;}];
//        [UIView animateWithDuration:0.25 animations:^{_textView.alpha = 1.0;}];
        [UIView animateWithDuration:1.0 animations:^{_textView.alpha = 0.0; _label.alpha = 0.0;} completion:^(BOOL tr)
         {
             _arrVal++;
             
             if (_arrVal == 3) _arrVal = 0;
             
             
             _textView.text = [_reviewInfo objectAtIndex:_arrVal]; _label.text = [_reviewer objectAtIndex:_arrVal];
             if (_arrVal == 0) {
                 _textView.transform = CGAffineTransformMakeTranslation(0,5);
                 _label.transform =CGAffineTransformMakeTranslation(0,0);
             } else if (_arrVal == 1) {
                  _textView.transform = CGAffineTransformMakeTranslation(-15, -30);
                  _label.transform = CGAffineTransformMakeTranslation(40, 27);
             } else {
                 _textView.transform = CGAffineTransformMakeTranslation(0, -20);
                  _label.transform = CGAffineTransformMakeTranslation(-10, 40);
             }
             
             [UIView animateWithDuration:1.0 animations:^{_textView.alpha = 1.0; _label.alpha = 1.0;}];}];
    }
    
    //don't autoscroll when user is manipulating carousel
    if (!_carousel.dragging && !_carousel.decelerating)
    {
        //scroll carousel
        _carousel.scrollOffset -= delta * (float)(SCROLL_SPEED);
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
