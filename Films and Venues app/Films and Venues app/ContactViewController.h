//
//  ContactViewController.h
//  Films and Venues app
//
//  Created by Jordan Carney on 2/15/13.
//  Copyright (c) 2013 Jordan Carney. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageUI/MessageUI.h"

@interface ContactViewController : UIViewController 

@property (strong,nonatomic) MFMailComposeViewController *mailer;

@end
