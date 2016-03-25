//
//  HNGStartViewController.m
//  Hangman
//
//  Created by Bruno on 2015-02-04.
//  Copyright (c) 2015 Bruno Almeida. All rights reserved.
//


#import "HNGStartViewController.h"
#import "HNGWindowController.h"
#import "HNGGame.h"


@implementation HNGStartViewController

/* Default
   Initializes notifications. */
- (void)viewDidLoad {
    [super viewDidLoad];
	
	// notifications
	self.notificationCenter = [NSNotificationCenter defaultCenter];
	
	// update lives text field
	[self changeLives:self.livesStepper];
}

/* Updates lives text field using lives stepper. */
- (IBAction)changeLives:(NSStepper *)sender {
	if (sender.integerValue == 1)
		self.livesTextField.stringValue = @"1 Life";
	else
		self.livesTextField.stringValue =
		[NSString stringWithFormat:@"%ld Lives", (long)sender.integerValue];
}

/* If phrase is valid, sends notification. */
- (IBAction)startGame:(NSButton *)sender {
	if ([self verifyPhrase])
		[self.notificationCenter postNotificationName:changeViewControllerNotificationName
											   object:self
											 userInfo:@{
		viewControllerNotificationKey : [NSNumber numberWithUnsignedInteger:gameViewController],
		gameNotificationKey : [self makeGame]
		}];
}

/* Verifies phrase text field, updates feedback label.
   Returns YES if phrase is valid. */
- (BOOL)verifyPhrase {
	if ([HNGGame isValidPhrase:self.phraseTextField.stringValue]) {
		return YES;
	}
	else {
		self.feedbackLabel.stringValue = @"Invalid phrase.";
		return NO;
	}
}

/* Creates a new game object. */
- (HNGGame *)makeGame {
	return [HNGGame gameWithPhraseToGuess:self.phraseTextField.stringValue
						numLivesRemaining:(NSUInteger *)self.livesStepper.integerValue];
}

@end
