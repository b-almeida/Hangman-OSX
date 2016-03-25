//
//  HNGStartViewController.h
//  Hangman
//
//  Created by Bruno on 2015-02-04.
//  Copyright (c) 2015 Bruno Almeida. All rights reserved.
//


#import <Cocoa/Cocoa.h>

@class HNGGame;


@interface HNGStartViewController : NSViewController

@property (weak) IBOutlet NSTextField *phraseTextField;
@property (weak) IBOutlet NSTextField *livesTextField;
@property (weak) IBOutlet NSStepper *livesStepper;
@property (weak) IBOutlet NSTextField *feedbackLabel;
@property (weak) NSNotificationCenter *notificationCenter;

- (IBAction)changeLives:(NSStepper *)sender;
- (IBAction)startGame:(NSButton *)sender;
- (BOOL)verifyPhrase;
- (HNGGame *)makeGame;

@end
