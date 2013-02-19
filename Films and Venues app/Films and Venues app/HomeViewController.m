//
//  HomeViewController.m
//  Films and Venues app
//
//  Created by Jordan Carney on 2/15/13.
//  Copyright (c) 2013 Jordan Carney. All rights reserved.
//

#import "HomeViewController.h"

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
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationController.navigationBar.topItem.title = @"Waterfront Film Festival";
    
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
    
    _venuesViewController = [[VenuesViewController alloc] initWithNibName:@"VenuesViewController" bundle:nil];
    
    [self startScrolling];
    // Do any additional setup after loading the view from its nib.
}


-(void)btnClicked:(id)sender {
    if (sender == _scheduleButton) {
        
    } else if (sender == _ticketsButton) {
        
    } else if (sender == _venuesButton) {
        UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle: @"Home" style: UIBarButtonItemStyleBordered target: nil action: nil];
        [self.navigationItem setBackBarButtonItem: backButton];
        
        [self.navigationController pushViewController:_venuesViewController animated:YES];
    } else if (sender == _directionsButton) {
        
    } else if (sender == _playingButton) {
        
    } else if (sender == _favoritesButton) {
        
    }
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
		UIImage *image = [UIImage imageNamed:@"page.png"];
		button = [UIButton buttonWithType:UIButtonTypeCustom];
		button.frame = CGRectMake(0.0f, 0.0f, image.size.width, image.size.height);
		[button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
		[button setBackgroundImage:image forState:UIControlStateNormal];
		button.titleLabel.font = [button.titleLabel.font fontWithSize:50];
		[button addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
	}
	
	//set button label
	[button setTitle:[NSString stringWithFormat:@"%i", index] forState:UIControlStateNormal];
	
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
