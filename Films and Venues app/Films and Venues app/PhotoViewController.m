//
//  PhotoViewController.m
//  Films and Venues app
//
//  Created by Jordan Carney on 3/20/13.
//  Copyright (c) 2013 Jordan Carney. All rights reserved.
//

#import "PhotoViewController.h"
#import "SampleAPIKey.h"
#import "MFSideMenu.h"

@interface PhotoViewController ()

@end

@implementation PhotoViewController

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
        // Custom initialization
        self.title = NSLocalizedString(@"Photos", @"Photos");
        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background_test"]]];
        
        _flickrContext = [[OFFlickrAPIContext alloc] initWithAPIKey:OBJECTIVE_FLICKR_SAMPLE_API_KEY sharedSecret:OBJECTIVE_FLICKR_SAMPLE_API_SHARED_SECRET];
        _flickrRequest = [[OFFlickrAPIRequest alloc] initWithAPIContext:_flickrContext];
        [_flickrRequest setDelegate:self];
        
        [self nextRandomPhotoAction:self];
    }
    return self;
}

- (IBAction)nextRandomPhotoAction:(id)sender
{
    
	if (![_flickrRequest isRunning]) {
		[_flickrRequest callAPIMethodWithGET:@"flickr.photosets.getPhotos" arguments:[NSDictionary dictionaryWithObjectsAndKeys: @"72157627054385034", @"photoset_id", nil]];
	}
}

-(void)clickedImage:(id)sender {
    UIButton *button = (UIButton *)sender;
    NSDictionary *photoDict = [_photos objectAtIndex:button.tag - 1];
    
    NSURL *photoURL = [_flickrContext photoSourceURLFromDictionary:photoDict size:OFFlickrMediumSize];
    NSString *htmlSource = [NSString stringWithFormat:
                            @"<html>"
                            @"<head>"
                            @" <style>body { margin: -20; padding: 0; max-width: 100%; width: auto; height: auto;} </style>"
                            @"</head>"
                            @"<body>"
                            @"  <table border=\"0\" align=\"left\" valign=\"left\" cellspacing=\"0\" cellpadding=\"0\" height=\"300\">"
                            @"    <tr><td><img src=\"%@\" /></td></tr>"
                            @"  </table>"
                            @"</body>"
                            @"</html>"
                            , photoURL];
    
    _bigWebView = [[UIWebView alloc] initWithFrame:CGRectMake(10, 60, 300, 300)];
    [_bigWebView.scrollView setScrollEnabled:NO];
    [_bigWebView loadHTMLString:htmlSource baseURL:nil];
    
    _dimmedView = [[UIView alloc] initWithFrame:_scrollView.bounds];
    [_dimmedView setBackgroundColor:[UIColor blackColor]];
    _dimmedView.alpha = 0.8f;
    
    UITapGestureRecognizer *tapped = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeImageButtonClicked:)];
    [_dimmedView addGestureRecognizer:tapped];
    
    [_scrollView addSubview:_dimmedView];
    [self.view addSubview:_bigWebView];
    
    [_scrollView setScrollEnabled:NO];
}

-(void)closeImageButtonClicked:(id)sender {
    [_bigWebView removeFromSuperview];
    [_dimmedView removeFromSuperview];
    _bigWebView = nil;
    _dimmedView = nil;
    
    [_scrollView setScrollEnabled:YES];
}

-(void)doStuff:(id)sender {
    
    int startingX = 15;
    int startingY = 20;
    
    _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    
    for (int i = 0; i < [_photos count]; i++) {
        NSDictionary *photoDict = [_photos objectAtIndex:i];
        NSURL *photoURL = [_flickrContext photoSourceURLFromDictionary:photoDict size:OFFlickrSmallSize];
        NSString *htmlSource = [NSString stringWithFormat:
                                @"<html>"
                                @"<head>"
                                @"<style type='text/css'>img {  margin: -10; padding: 0; width: 100%; height: 110%; }</style>"
                                @"</head>"
                                @"<body>"
                                @"  <table border=\"0\" align=\"left\" valign=\"left\" cellspacing=\"0\" cellpadding=\"0\" height=\"90\">"
                                @"    <tr><td><img src=\"%@\" /></td></tr>"
                                @"  </table>"
                                @"</body>"
                                @"</html>"
                                , photoURL];
        
        if (i % 3 == 0 && i != 0) {
            startingY += 100;
            startingX = 15;
        } else {
            startingX += 100;
        }
        
        if (i == 0) startingX = 15;
        
        UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(startingX, startingY, 90, 90)];
        [webView.scrollView setScrollEnabled:NO];
        [webView loadHTMLString:htmlSource baseURL:nil];
        
        UIButton *button = [[UIButton alloc] initWithFrame:webView.bounds];
        button.tag = i + 1;
        [button setBackgroundColor:[UIColor clearColor]];

        [button addTarget:self action:@selector(clickedImage:) forControlEvents:UIControlEventTouchUpInside];
        [webView addSubview:button];
        
        [_scrollView addSubview:webView];
    }
    
    [_scrollView setContentSize:CGSizeMake(self.view.bounds.size.width, startingY + 120)];
    [self.view addSubview:_scrollView];
    
//    NSDictionary *photoDict = [_photos objectAtIndex:_index];
//    
//    _index++;
//    
//    if (_index == [_photos count]) _index = 0;
//    
//	NSURL *photoURL = [_flickrContext photoSourceURLFromDictionary:photoDict size:OFFlickrSmallSize];
//    
//    NSDictionary *photoDict_two = [_photos objectAtIndex:_index];
//    
//    _index++;
//    
//    if (_index == [_photos count]) _index = 0;
//    
//	NSURL *photoURL_two = [_flickrContext photoSourceURLFromDictionary:photoDict_two size:OFFlickrSmallSize];
//    
//	NSString *htmlSource = [NSString stringWithFormat:
//							@"<html>"
//							@"<head>"
//							@"  <style>body { margin: 0; padding: 0; } </style>"
//							@"</head>"
//							@"<body>"
//							@"  <table border=\"0\" align=\"center\" valign=\"center\" cellspacing=\"0\" cellpadding=\"0\" height=\"80\">"
//							@"    <tr><td><img src=\"%@\" /></td></tr>"
//							@"  </table>"
//							@"</body>"
//							@"</html>"
//							, photoURL];
//    NSString *htmlSource_two = [NSString stringWithFormat:
//							@"<html>"
//							@"<head>"
//							@"<style type='text/css'>img { max-width: 100%; width: auto; height: auto; }</style>"
//							@"</head>"
//							@"<body>"
//							@"  <table border=\"0\" align=\"center\" valign=\"center\" cellspacing=\"0\" cellpadding=\"0\" height=\"80\">"
//							@"    <tr><td><img src=\"%@\" /></td></tr>"
//							@"  </table>"
//							@"</body>"
//							@"</html>"
//							, photoURL_two];
//	
//	[_webView loadHTMLString:htmlSource baseURL:nil];
//    [_webView_two loadHTMLString:htmlSource_two baseURL:nil];
}


- (void)flickrAPIRequest:(OFFlickrAPIRequest *)inRequest didCompleteWithResponse:(NSDictionary *)inResponseDictionary
{
//    NSLog(@"inResponseDict %@", inResponseDictionary);
    
    _photos = [[inResponseDictionary objectForKey:@"photoset"] objectForKey:@"photo"];
//    
//    [[NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(doStuff:) userInfo:nil repeats:YES] fire];
    
    [self doStuff:nil];
}

- (void)flickrAPIRequest:(OFFlickrAPIRequest *)inRequest didFailWithError:(NSError *)inError
{
    NSLog(@"%@", inError);
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

@end
