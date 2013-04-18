//
//  AdvisoryModalPanel.m
//  Films and Venues app
//
//  Created by Jordan Carney on 3/20/13.
//  Copyright (c) 2013 Jordan Carney. All rights reserved.
//

#import "AdvisoryModalPanel.h"

@implementation AdvisoryModalPanel

- (id)initWithFrame:(CGRect)frame title:(NSString *)title {
	if ((self = [super initWithFrame:frame])) {
		self.margin = UIEdgeInsetsMake(15,15,15,15);
        self.padding = UIEdgeInsetsMake(15,15,15,15);
        self.contentColor = [UIColor lightGrayColor];
        self.shouldBounce = YES;
        self.headerLabel.text = title;
        self.headerLabel.font = [UIFont fontWithName:@"LTTetria Bold" size:20];
        
        
        if ([title isEqualToString:@"Advisory Board & Staff"]) {
            [[NSBundle mainBundle] loadNibNamed:@"AdvisoryView" owner:self options:nil];
        } else if ([title isEqualToString:@"Past Highlights"]) {
            [[NSBundle mainBundle] loadNibNamed:@"HighlightsView" owner:self options:nil];
        } else if ([title isEqualToString:@"Reviews"]) {
            [[NSBundle mainBundle] loadNibNamed:@"ReviewsView" owner:self options:nil];
        }
        
        _textView.font = [UIFont fontWithName:@"LTTetria Light" size:14];
        
        self.contentView.clipsToBounds = TRUE;
        [self.contentView addSubview:_viewLoadedFromXib];
	}
	return self;
}





@end
