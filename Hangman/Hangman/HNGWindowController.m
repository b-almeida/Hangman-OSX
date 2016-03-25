//
//  HNGWindowController.m
//  Hangman
//
//  Created by Bruno on 2015-02-04.
//  Copyright (c) 2015 Bruno Almeida. All rights reserved.
//


#import "HNGWindowController.h"
#import "HNGStartViewController.h"
#import "HNGGameViewController.h"
#import "HNGEndViewController.h"
#import "HNGGame.h"


NSString *const changeViewControllerNotificationName = @"Change View Controller";

NSString *const viewControllerNotificationKey = @"View Controller";
NSString *const gameNotificationKey = @"Game";


@implementation HNGWindowController

/* Default
   Initializes notifications, sends notification. */
- (void)windowDidLoad {
    [super windowDidLoad];
	
	// notifications
	self.notificationCenter = [NSNotificationCenter defaultCenter];
	[self.notificationCenter addObserver:self
								selector:@selector(changeViewController:)
									name:changeViewControllerNotificationName
								  object:nil];
	
	// start view
	[self.notificationCenter postNotificationName:changeViewControllerNotificationName
										   object:self
										 userInfo:@{
	viewControllerNotificationKey : [NSNumber numberWithUnsignedInteger:startViewController]
	}];
}

/* Changes view controller. */
- (void)changeViewController:(NSNotification *)notification {
	// remove old view
	if (self.currentViewController)
		[self.currentViewController.view removeFromSuperview];
	
	// select new view
	switch (((NSNumber *)notification.userInfo[viewControllerNotificationKey]).integerValue) {
		// start
		case startViewController: {
			self.startViewController = [[HNGStartViewController alloc]
										initWithNibName:@"HNGStartView"
										bundle:nil];
			self.currentViewController = self.startViewController;
			break;
		}
		// game
		case gameViewController: {
			self.gameViewController = [[HNGGameViewController alloc]
									   initWithNibName:@"HNGGameView"
									   bundle:nil];
			self.currentViewController = self.gameViewController;
			break;
		}
		// end
		case endViewController: {
			self.endViewController = [[HNGEndViewController alloc]
									  initWithNibName:@"HNGEndView"
									  bundle:nil];
			self.currentViewController = self.endViewController;
			break;
		}
	}
	
	// add new view
	[self.view addSubview:self.currentViewController.view];
	self.currentViewController.view.frame = self.view.bounds;
	
	// initialize new view properties
	switch (((NSNumber *)notification.userInfo[viewControllerNotificationKey]).integerValue) {
			// game
		case gameViewController: {
			self.game = notification.userInfo[gameNotificationKey];
			[self.gameViewController initViewWithGame:self.game];
			break;
		}
			// end
		case endViewController: {
			[self.endViewController initViewWithGame:notification.userInfo[gameNotificationKey]];
			break;
		}
	}
}

@end
