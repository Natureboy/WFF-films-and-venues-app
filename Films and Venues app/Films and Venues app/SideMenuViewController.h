//
//  SideMenuViewController.h
//  MFSideMenuDemo
//
//  Created by Michael Frederick on 3/19/12.

#import <UIKit/UIKit.h>
#import "MFSideMenu.h"
#import "SVModalWebViewController.h"
#import "MessageUI/MessageUI.h"

#define kAllPinsLoaded @"kAllPinsLoaded"

@interface SideMenuViewController : UITableViewController <MFMailComposeViewControllerDelegate>

@property (nonatomic, assign) MFSideMenu *sideMenu;

@property (nonatomic,strong) NSMutableArray *holderArray;
@property (strong,nonatomic) NSArray *tableElements;
@property (strong,nonatomic) NSArray *tableImages;
@property (strong,nonatomic) NSArray *viewControllers;
@property (nonatomic,strong) NSArray *venuesArray;

@property (nonatomic, strong) SVModalWebViewController *svmController;

@property (nonatomic) int val;

@end