//
//  HNGGameViewController.h
//  Hangman
//
//  Created by Bruno on 2015-02-04.
//  Copyright (c) 2015 Bruno Almeida. All rights reserved.
//


#import <Cocoa/Cocoa.h>

@class HNGGame;


@interface HNGGameViewController : NSViewController

@property (weak) IBOutlet NSTextField *livesLabel;
@property (weak) IBOutlet NSTextField *charactersLabel;
@property (weak) IBOutlet NSTextField *guessedLabel;
@property (weak) IBOutlet NSTextField *feedbackLabel;
@property (weak) NSNotificationCenter *notificationCenter;
@property (weak) HNGGame *game;

- (IBAction)guessLetter:(NSTextField *)sender;
- (IBAction)guessPhrase:(NSTextField *)sender;
- (IBAction)endGame:(id)sender;
- (void)initViewWithGame:(HNGGame *)game;
- (void)updateGame;

@end
