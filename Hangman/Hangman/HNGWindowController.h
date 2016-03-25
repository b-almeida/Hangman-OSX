//
//  HNGWindowController.h
//  Hangman
//
//  Created by Bruno on 2015-02-04.
//  Copyright (c) 2015 Bruno Almeida. All rights reserved.
//


#import <Cocoa/Cocoa.h>

@class HNGStartViewController;
@class HNGGameViewController;
@class HNGEndViewController;
@class HNGGame;


extern NSString *const changeViewControllerNotificationName;

extern NSString *const viewControllerNotificationKey;
extern NSString *const gameNotificationKey;

typedef NS_ENUM(NSUInteger, viewControllers) {
	startViewController,
	gameViewController,
	endViewController
};


@interface HNGWindowController : NSWindowController

@property (weak) IBOutlet NSView *view;
@property (weak) NSNotificationCenter *notificationCenter;
@property (weak) NSViewController *currentViewController;
@property HNGStartViewController *startViewController;
@property HNGGameViewController *gameViewController;
@property HNGEndViewController *endViewController;
@property HNGGame *game;

- (void)changeViewController:(NSNotification *)notification;

@end
