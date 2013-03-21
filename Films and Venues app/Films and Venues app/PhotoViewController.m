//
//  PhotoViewController.m
//  Films and Venues app
//
//  Created by Jordan Carney on 3/20/13.
//  Copyright (c) 2013 Jordan Carney. All rights reserved.
//

#import "PhotoViewController.h"
#import "SampleAPIKey.h"

@interface PhotoViewController ()

@end

@implementation PhotoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _flickrContext = [[OFFlickrAPIContext alloc] initWithAPIKey:OBJECTIVE_FLICKR_SAMPLE_API_KEY sharedSecret:OBJECTIVE_FLICKR_SAMPLE_API_SHARED_SECRET];
        _flickrRequest = [[OFFlickrAPIRequest alloc] initWithAPIContext:_flickrContext];
        [_flickrRequest setDelegate:self];
        
        [self nextRandomPhotoAction:self];
        
        [[NSTimer scheduledTimerWithTimeInterval:10.0 target:self selector:@selector(nextRandomPhotoAction:) userInfo:nil repeats:YES] fire];
    }
    return self;
}

- (IBAction)nextRandomPhotoAction:(id)sender
{
	if (![_flickrRequest isRunning]) {
		[_flickrRequest callAPIMethodWithGET:@"flickr.photos.getRecent" arguments:[NSDictionary dictionaryWithObjectsAndKeys:@"1", @"per_page", nil]];
	}
}


- (void)flickrAPIRequest:(OFFlickrAPIRequest *)inRequest didCompleteWithResponse:(NSDictionary *)inResponseDictionary
{
	NSDictionary *photoDict = [[inResponseDictionary valueForKeyPath:@"photos.photo"] objectAtIndex:0];
	
	NSString *title = [photoDict objectForKey:@"title"];
	if (![title length]) {
		title = @"No title";
	}
	
	//NSURL *photoSourcePage = [_flickrContext photoWebPageURLFromDictionary:photoDict];
	//NSDictionary *linkAttr = [NSDictionary dictionaryWithObjectsAndKeys:photoSourcePage, NSFontAttributeName, nil];
	//NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:title attributes:linkAttr];
	//[[textView textStorage] setAttributedString:attrString];
    
	NSURL *photoURL = [_flickrContext photoSourceURLFromDictionary:photoDict size:OFFlickrSmallSize];
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
	
	[_webView loadHTMLString:htmlSource baseURL:nil];
}

- (void)flickrAPIRequest:(OFFlickrAPIRequest *)inRequest didFailWithError:(NSError *)inError
{
    NSLog(@"problem yo");
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
