//
//  HNGEndViewController.m
//  Hangman
//
//  Created by Bruno on 2015-02-04.
//  Copyright (c) 2015 Bruno Almeida. All rights reserved.
//


#import "HNGEndViewController.h"
#import "HNGWindowController.h"
#import "HNGGame.h"


@implementation HNGEndViewController

/* Default
   Initializes notifications. */
- (void)viewDidLoad {
    [super viewDidLoad];
	
	// notifications
	self.notificationCenter = [NSNotificationCenter defaultCenter];
}

/* Sends notification. */
- (IBAction)newGame:(NSButton *)sender {
	[self.notificationCenter postNotificationName:changeViewControllerNotificationName
										   object:self
										 userInfo:@{
	viewControllerNotificationKey : [NSNumber numberWithUnsignedInteger:startViewController]
	}];
}

/* Initializes view properties. */
- (void)initViewWithGame:(HNGGame *)game {
	if ([game hasPlayerWon])
		self.feedbackLabel.stringValue = @"You Won!";
	else
		self.feedbackLabel.stringValue = @"You Lost...";
}

@end
