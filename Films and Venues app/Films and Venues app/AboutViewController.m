//
//  AboutViewController.m
//  Films and Venues app
//
//  Created by Jordan Carney on 3/20/13.
//  Copyright (c) 2013 Jordan Carney. All rights reserved.
//

#import "AboutViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "AdvisoryModalPanel.h"

@interface AboutViewController ()

@end

@implementation AboutViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = NSLocalizedString(@"About", @"About");
        self.tabBarItem.image = [UIImage imageNamed:@"about_icon"];
        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background"]]];
        [_textView setFont:[UIFont fontWithName:@"LTTetria Light" size:18]];
        _tableView.layer.cornerRadius = 10.0f;
    }
    return self;
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
            [self setupAdvisoryStaffView];
            break;
        case 1:
            [self setupPastHighlights];
            break;
        case 2:
            [self setupPhotoGallery];
            break;
        case 3:
            [self setupReviews];
            break;
        default:
            break;
    }
}

-(void)setupAdvisoryStaffView {
    AdvisoryModalPanel *advModalPanel = [[AdvisoryModalPanel alloc] initWithFrame:self.view.bounds title:@"Advisory Board & Staff"];
    advModalPanel.delegate = self;
    [self.view addSubview:advModalPanel];
    [advModalPanel showFromPoint:self.view.center];
    
    advModalPanel.onClosePressed = ^(UAModalPanel* panel) {
        // [panel hide];
        [panel hideWithOnComplete:^(BOOL finished) {
            [panel removeFromSuperview];
        }];
    };
}

-(void)setupPastHighlights {
    AdvisoryModalPanel *advModalPanel = [[AdvisoryModalPanel alloc] initWithFrame:self.view.bounds title:@"Past Highlights"];
    advModalPanel.delegate = self;
    [self.view addSubview:advModalPanel];
    [advModalPanel showFromPoint:self.view.center];
    
    advModalPanel.onClosePressed = ^(UAModalPanel* panel) {
        // [panel hide];
        [panel hideWithOnComplete:^(BOOL finished) {
            [panel removeFromSuperview];
        }];
    };
}

-(void)setupPhotoGallery {
    
}

-(void)setupReviews {
    AdvisoryModalPanel *advModalPanel = [[AdvisoryModalPanel alloc] initWithFrame:self.view.bounds title:@"Reviews"];
    advModalPanel.delegate = self;
    [self.view addSubview:advModalPanel];
    [advModalPanel showFromPoint:self.view.center];
    
    advModalPanel.onClosePressed = ^(UAModalPanel* panel) {
        // [panel hide];
        [panel hideWithOnComplete:^(BOOL finished) {
            [panel removeFromSuperview];
        }];
    };
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIndentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIndentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIndentifier];
    }
    
    cell.textLabel.font = [UIFont fontWithName:@"LTTetria Light" size:16];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    switch(indexPath.row) {
        case 0:
            cell.textLabel.text = @"Advisory Board & Staff";
            break;
        case 1:
            cell.textLabel.text = @"Past Highlights";
            break;
        case 2:
            cell.textLabel.text = @"Photo Gallery";
            break;
        case 3:
            cell.textLabel.text = @"Reviews";
            break;
        default:
            break;
    }
    
    return cell;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}
@end
