//
//  HNGGameViewController.m
//  Hangman
//
//  Created by Bruno on 2015-02-04.
//  Copyright (c) 2015 Bruno Almeida. All rights reserved.
//


#import "HNGGameViewController.h"
#import "HNGWindowController.h"
#import "HNGGame.h"


@implementation HNGGameViewController

/* Default
   Initializes notifications, updates game. */
- (void)viewDidLoad {
    [super viewDidLoad];
	
	// notifications
	self.notificationCenter = [NSNotificationCenter defaultCenter];
}

/* Guesses letter, updates feedback label. */
- (IBAction)guessLetter:(NSTextField *)sender {
	// if letter is valid
	if ([HNGGame isValidLetter:sender.stringValue]) {
		// if letter is remaining
		if ([self.game isRemainingLetter:sender.stringValue]) {
			// if letter is correct
			if ([self.game guessLetter:sender.stringValue])
				self.feedbackLabel.stringValue = @"Correct!";
			else
				self.feedbackLabel.stringValue = @"Incorrect.";
		}
		else {
			self.feedbackLabel.stringValue = @"Already guessed.";
		}
	}
	else {
		self.feedbackLabel.stringValue = @"Invalid letter.";
	}
	
	[self updateGame];
}

/* Guesses phrase, updates feedback label. */
- (IBAction)guessPhrase:(NSTextField *)sender {
	// if phrase is valid
	if ([HNGGame isValidPhrase:sender.stringValue]) {
		// if phrase is correct
		if ([self.game guessPhrase:sender.stringValue])
			self.feedbackLabel.stringValue = @"Correct!";
		else
			self.feedbackLabel.stringValue = @"Incorrect.";
	}
	else {
		self.feedbackLabel.stringValue = @"Invalid phrase.";
	}
	
	[self updateGame];
}

/* Sends notification. */
- (IBAction)endGame:(id)sender {
	[self.notificationCenter postNotificationName:changeViewControllerNotificationName
										   object:self
										 userInfo:@{
	viewControllerNotificationKey : [NSNumber numberWithUnsignedInteger:endViewController],
	gameNotificationKey : self.game
	}];
}

/* Initializes view properties. */
- (void)initViewWithGame:(HNGGame *)game {
	self.game = game;
	
	// update game
	[self updateGame];
}

/* If game is over, ends game.
   Updates view. */
- (void)updateGame {
	// if game is over, send notification
	if ([self.game isGameOver])
		[self endGame:self];
	
	// update lives label
	if ((int)self.game.numLivesRemaining == 1)
		self.livesLabel.stringValue = @"1 Life";
	else
		self.livesLabel.stringValue =
		[NSString stringWithFormat:@"%lu Lives", (unsigned long)self.game.numLivesRemaining];
	
	// update characters label
	NSMutableString *characters = [NSMutableString stringWithFormat:@"%C",
								   [self.game.charactersRemaining characterAtIndex:0]];
	for (int i = 1; i < [self.game.charactersRemaining length]; i++)
		[characters appendFormat:@" %C", [self.game.charactersRemaining characterAtIndex:i]];
	self.charactersLabel.stringValue = characters;
	
	// update guessed label
	self.guessedLabel.stringValue = self.game.phraseGuessed;
}

@end
