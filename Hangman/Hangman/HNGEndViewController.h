//
//  HNGEndViewController.h
//  Hangman
//
//  Created by Bruno on 2015-02-04.
//  Copyright (c) 2015 Bruno Almeida. All rights reserved.
//


#import <Cocoa/Cocoa.h>

@class HNGGame;


@interface HNGEndViewController : NSViewController

@property (weak) IBOutlet NSTextField *feedbackLabel;
@property (weak) NSNotificationCenter *notificationCenter;

- (IBAction)newGame:(NSButton *)sender;
- (void)initViewWithGame:(HNGGame *)game;

@end
