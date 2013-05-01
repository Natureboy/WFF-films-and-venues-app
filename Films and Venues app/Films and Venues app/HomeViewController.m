//
//  HomeViewController.m
//  Films and Venues app
//
//  Created by Jordan Carney on 2/15/13.
//  Copyright (c) 2013 Jordan Carney. All rights reserved.
//

#import "HomeViewController.h"
#import "UIImage+Alpha.h"
#import "MFSideMenu.h"

#define SCROLL_SPEED .15 //items per second, can be negative or fractional
#define NUMBER_OF_SPONSERS 5

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
        self.title = @"Home";
        
        /* creates arrays for reviews and the owner of that review */
        _reviewer = @[@"-Sag Indie", @"-DFP", @"-Sean Elliott"];
        _reviewInfo = @[@"\"Ranked in the Top 5 Film Festivals!\"", @"\"One of the most refreshingly-laid back film events in the country.\"", @"\"An absolutely fun-filled weekend! The passion behind the festival is amazing!\""];
        
        /* creates an array of images used in the carousel */
        _carouselImages = @[[UIImage imageNamed:@"img1"], [UIImage imageNamed:@"img2"], [UIImage imageNamed:@"img3"], [UIImage imageNamed:@"img4"], [UIImage imageNamed:@"img5"]];
        
    }
    return self;
}

- (void)setupMenuBarButtonItems {
    switch (self.navigationController.sideMenu.menuState) {
        case MFSideMenuStateClosed:
            if([[self.navigationController.viewControllers objectAtIndex:0] isEqual:self]) {
                self.navigationItem.leftBarButtonItem = [self leftMenuBarButtonItem];
            }
            break;
        case MFSideMenuStateLeftMenuOpen:
            self.navigationItem.leftBarButtonItem = [self leftMenuBarButtonItem];
            break;
        case MFSideMenuStateRightMenuOpen:
            break;
    }
}

- (UIBarButtonItem *)leftMenuBarButtonItem {
    return [[UIBarButtonItem alloc]
            initWithImage:[UIImage imageNamed:@"menu-icon.png"] style:UIBarButtonItemStyleBordered
            target:self.navigationController.sideMenu
            action:@selector(toggleLeftSideMenu)];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupMenuBarButtonItems];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background_test"]]];
    
    /* makes home screen look better on iPhone 5 */
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        if (screenSize.height > 480.0f) {
            _reviewTextView.frame = CGRectMake(_reviewTextView.frame.origin.x, _reviewTextView.frame.origin.y + 50, _reviewTextView.frame.size.width, _reviewTextView.frame.size.height);
            _reviewerLabel.frame = CGRectMake(_reviewerLabel.frame.origin.x, _reviewerLabel.frame.origin.y + 50, _reviewerLabel.frame.size.width, _reviewerLabel.frame.size.height);
        }
    }
    
    _carousel.type = iCarouselTypeInvertedCylinder;
    
    /* start the carousel */
    [self startScrolling];
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
	UIImageView *imgView = (UIImageView *)view;

    UIImage *image = [[_carouselImages objectAtIndex:index] transparentBorderImage:1];
    
    imgView = [[UIImageView alloc] init];
    imgView.frame = CGRectMake(0, 0, image.size.width, image.size.height);
    [imgView setImage:image];

	return imgView;
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
    
    /* deals with changing the animated text */
    if (_incVal == 100) {
        _incVal = 0;
        [UIView animateWithDuration:1.0 animations:^{_reviewTextView.alpha = 0.0; _reviewerLabel.alpha = 0.0;} completion:^(BOOL tr)
         {
             _arrVal++;
             
             if (_arrVal == 3) _arrVal = 0;
             
             _reviewTextView.text = [_reviewInfo objectAtIndex:_arrVal]; _reviewerLabel.text = [_reviewer objectAtIndex:_arrVal];
             
             switch(_arrVal) {
                 case 0:
                     _reviewTextView.transform = CGAffineTransformMakeTranslation(0,5);
                     _reviewerLabel.transform =CGAffineTransformMakeTranslation(0,0);
                     break;
                 case 1:
                     _reviewTextView.transform = CGAffineTransformMakeTranslation(-5, -26);
                     _reviewerLabel.transform = CGAffineTransformMakeTranslation(40, 27);
                     break;
                 default:
                     _reviewTextView.transform = CGAffineTransformMakeTranslation(0, -20);
                     _reviewerLabel.transform = CGAffineTransformMakeTranslation(-10, 40);
                     break;
             }
             
             [UIView animateWithDuration:1.0 animations:^{_reviewTextView.alpha = 1.0; _reviewerLabel.alpha = 1.0;}];}];
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
