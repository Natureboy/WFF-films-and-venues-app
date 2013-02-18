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
    
    [self startScrolling];
    // Do any additional setup after loading the view from its nib.
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
    UILabel *label = nil;
    
    //create new view if no view is available for recycling
    if (view == nil)
    {
        //don't do anything specific to the index within
        //this `if (view == nil) {...}` statement because the view will be
        //recycled and used with other index values later
        view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 300.0f, 200.0f)];
        ((UIImageView *)view).image = [UIImage imageNamed:@"page.png"];
        view.contentMode = UIViewContentModeCenter;
        
        label = [[UILabel alloc] initWithFrame:view.bounds];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [label.font fontWithSize:50];
        label.tag = 1;
        [view addSubview:label];
    }
    else
    {
        //get a reference to the label in the recycled view
        label = (UILabel *)[view viewWithTag:1];
    }
    
    //set item label
    //remember to always set any properties of your carousel item
    //views outside of the `if (view == nil) {...}` check otherwise
    //you'll get weird issues with carousel item content appearing
    //in the wrong place in the carousel
    label.text = [[_items objectAtIndex:index] stringValue];
    
    return view;
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
