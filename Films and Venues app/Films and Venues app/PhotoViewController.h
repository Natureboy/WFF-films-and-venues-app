//
//  PhotoViewController.h
//  Films and Venues app
//
//  Created by Jordan Carney on 3/20/13.
//  Copyright (c) 2013 Jordan Carney. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ObjectiveFlickr.h"

@interface PhotoViewController : UIViewController <OFFlickrAPIRequestDelegate>

@property (strong,nonatomic) OFFlickrAPIContext *flickrContext;
@property (strong,nonatomic) OFFlickrAPIRequest *flickrRequest;
@property (strong,nonatomic) IBOutlet UIWebView *webView;
@property (strong,nonatomic) IBOutlet UIWebView *webView_two;

@property (strong,nonatomic) UIWebView *bigWebView;
@property (strong,nonatomic) UIScrollView *scrollView;
@property (strong,nonatomic) UIView *dimmedView;

@property (strong,nonatomic) NSArray *photos;

@property (nonatomic) int index;

@end
