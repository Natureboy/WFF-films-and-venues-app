//
//  SideMenuViewController.h
//  MFSideMenuDemo
//
//  Created by Michael Frederick on 3/19/12.

#import <UIKit/UIKit.h>
#import "MFSideMenu.h"

@interface SideMenuViewController : UITableViewController<UISearchBarDelegate>

@property (nonatomic, assign) MFSideMenu *sideMenu;

@property (strong,nonatomic) NSMutableArray *tableElements;
@property (strong,nonatomic) NSMutableArray *tableImages;
@property (strong,nonatomic) NSMutableArray *viewControllers;
@end