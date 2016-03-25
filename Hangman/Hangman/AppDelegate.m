//
//  AppDelegate.m
//  Hangman
//
//  Created by Bruno on 2015-01-29.
//  Copyright (c) 2015 Bruno Almeida. All rights reserved.
//


#import "AppDelegate.h"
#import "HNGWindowController.h"


@implementation AppDelegate

/* Default
   Initializes window. */
- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	// window
	self.windowController = [[HNGWindowController alloc]
							 initWithWindowNibName:@"HNGWindow"];
	[self.windowController showWindow:self];
}

/* Default */
- (void)applicationWillTerminate:(NSNotification *)aNotification {
}

@end
