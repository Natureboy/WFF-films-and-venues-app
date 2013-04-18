//
//  SideMenuViewController.h
//  MFSideMenuDemo
//
//  Created by Michael Frederick on 3/19/12.

#import <UIKit/UIKit.h>
#import "MFSideMenu.h"
#import "SVModalWebViewController.h"

#define kAllPinsLoaded @"kAllPinsLoaded"

@interface SideMenuViewController : UITableViewController<UISearchBarDelegate>

@property (nonatomic, assign) MFSideMenu *sideMenu;

@property (strong,nonatomic) NSMutableArray *tableElements;
@property (strong,nonatomic) NSMutableArray *tableImages;
@property (strong,nonatomic) NSMutableArray *viewControllers;
@property (nonatomic,strong) NSMutableArray *holderArray;
@property (nonatomic,strong) NSArray *venuesArray;


@property (nonatomic, strong) SVModalWebViewController *svmController;

@property (nonatomic) int val;

@end