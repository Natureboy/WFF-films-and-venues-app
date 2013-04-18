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
        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background"]]];
        
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
    
//    if (![_flickrRequest isRunning]) {
//		[_flickrRequest callAPIMethodWithGET:@"flickr.photos.getRecent" arguments:[NSDictionary dictionaryWithObjectsAndKeys:@"1", @"per_page", nil]];
//	}
}

-(void)doStuff:(id)sender {
    NSDictionary *photoDict = [_photos objectAtIndex:_index];
    
    _index++;
    
    if (_index == [_photos count]) _index = 0;
    
	NSURL *photoURL = [_flickrContext photoSourceURLFromDictionary:photoDict size:OFFlickrSmallSize];
    
    NSDictionary *photoDict_two = [_photos objectAtIndex:_index];
    
    _index++;
    
    if (_index == [_photos count]) _index = 0;
    
	NSURL *photoURL_two = [_flickrContext photoSourceURLFromDictionary:photoDict_two size:OFFlickrSmallSize];
    
	NSString *htmlSource = [NSString stringWithFormat:
							@"<html>"
							@"<head>"
							@"  <style>body { margin: 0; padding: 0; } </style>"
							@"</head>"
							@"<body>"
							@"  <table border=\"0\" align=\"center\" valign=\"center\" cellspacing=\"0\" cellpadding=\"0\" height=\"240\">"
							@"    <tr><td><img src=\"%@\" /></td></tr>"
							@"  </table>"
							@"</body>"
							@"</html>"
							, photoURL];
    NSString *htmlSource_two = [NSString stringWithFormat:
							@"<html>"
							@"<head>"
							@"  <style>body { margin: 0; padding: 0; } </style>"
							@"</head>"
							@"<body>"
							@"  <table border=\"0\" align=\"center\" valign=\"center\" cellspacing=\"0\" cellpadding=\"0\" height=\"240\">"
							@"    <tr><td><img src=\"%@\" /></td></tr>"
							@"  </table>"
							@"</body>"
							@"</html>"
							, photoURL_two];
	
	[_webView loadHTMLString:htmlSource baseURL:nil];
    [_webView_two loadHTMLString:htmlSource_two baseURL:nil];
}


- (void)flickrAPIRequest:(OFFlickrAPIRequest *)inRequest didCompleteWithResponse:(NSDictionary *)inResponseDictionary
{
//    NSLog(@"inResponseDict %@", inResponseDictionary);
    
    _photos = [[inResponseDictionary objectForKey:@"photoset"] objectForKey:@"photo"];
    
    [[NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(doStuff:) userInfo:nil repeats:YES] fire];
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
