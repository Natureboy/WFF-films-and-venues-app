//
//  AboutViewController.h
//  Films and Venues app
//
//  Created by Jordan Carney on 3/20/13.
//  Copyright (c) 2013 Jordan Carney. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UAModalPanel.h"

@interface AboutViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UAModalPanelDelegate>

@property (strong,nonatomic) IBOutlet UITableView *tableView;

@property (strong,nonatomic) IBOutlet UITextView *textView;

@end
