//
//  AdvisoryModalPanel.h
//  Films and Venues app
//
//  Created by Jordan Carney on 3/20/13.
//  Copyright (c) 2013 Jordan Carney. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UATitledModalPanel.h"

@interface AdvisoryModalPanel : UATitledModalPanel

@property (nonatomic, retain) IBOutlet UIView *viewLoadedFromXib;
@property (nonatomic, retain) IBOutlet UITextView *textView;

- (id)initWithFrame:(CGRect)frame title:(NSString *)title;

@end