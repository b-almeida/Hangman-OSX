//
//  HNGGame.m
//  Hangman
//
//  Created by Bruno on 2015-01-30.
//  Copyright (c) 2015 Bruno Almeida. All rights reserved.
//


#import "HNGGame.h"


NSString *const fullCharacterSet = @"abcdefghijklmnopqrstuvwxyz!&()-;:'\",. ";
NSString *const standardCharacterSet = @"abcdefghijklmnopqrstuvwxyz";


@implementation HNGGame

/* Default factory method. */
+ (HNGGame *)game {
	return [[HNGGame alloc] init];
}

/* Designated factory method. */
+ (HNGGame *)gameWithPhraseToGuess:(NSString *)phraseToGuess
				 numLivesRemaining:(NSUInteger *)numLivesRemaining {
	return [[HNGGame alloc] initWithPhraseToGuess:phraseToGuess
								numLivesRemaining:numLivesRemaining];
}

/* Default initializer. */
- (instancetype)init {
	return [self initWithPhraseToGuess:@"Hangman"
					 numLivesRemaining:(NSUInteger *)3];
}

/* Designated initializer. */
- (instancetype)initWithPhraseToGuess:(NSString *)phraseToGuess
					numLivesRemaining:(NSUInteger *)numLivesRemaining {
	self = [super init];
	
	if (self) {
		_phraseToGuess = phraseToGuess;
		
		// reveal non-standard characters, fill unknowns with '?'
		_phraseGuessed = [NSMutableString string];
		for (int i = 0; i < [phraseToGuess length]; i++) {
			NSString *character = [phraseToGuess substringWithRange:NSMakeRange(i, 1)];
			if ([standardCharacterSet rangeOfString:[character lowercaseString]].length == 0)
				[_phraseGuessed appendString:character];
			else
				[_phraseGuessed appendString:@"-"];
		}
		
		_numLivesRemaining = numLivesRemaining;
		_charactersRemaining = [NSMutableString stringWithString:standardCharacterSet];
	}
	
	return self;
}

/* Determines if string is a valid phrase (contains only characters in the full character set). */
+ (BOOL)isValidPhrase:(NSString *)phrase {
	if ([phrase length] == 0)
		return NO;
	
	for (int i = 0; i < [phrase length]; i++) {
		NSString *character = [phrase substringWithRange:NSMakeRange(i, 1)];
		if ([fullCharacterSet rangeOfString:[character lowercaseString]].length == 0)
			return NO;
	}
	
	return YES;
}

/* Determines if string is a valid letter (a single character in the standard character set). */
+ (BOOL)isValidLetter:(NSString *)letter {
	if ([letter length] == 1 && [standardCharacterSet rangeOfString:[letter lowercaseString]].length != 0)
		return YES;
	else
		return NO;
}

/* Determines if letter is remaining (has not been guessed). */
- (BOOL)isRemainingLetter:(NSString *)letter {
	if ([self.charactersRemaining rangeOfString:[letter lowercaseString]].length != 0)
		return YES;
	else
		return NO;
}

/* Guesses letter and updates game. Returns YES if guess is correct. */
- (BOOL)guessLetter:(NSString *)letter {
	// remove letter from remaining set
	[self.charactersRemaining deleteCharactersInRange:[self.charactersRemaining rangeOfString:[letter lowercaseString]]];
	
	// if letter occurs in answer, reveal occurences of letter
	if ([[self.phraseToGuess lowercaseString] rangeOfString:[letter lowercaseString]].length != 0) {
		for (int i = 0; i < [self.phraseToGuess length]; i++) {
			NSString *character = [self.phraseToGuess substringWithRange:NSMakeRange(i, 1)];
			if ([[letter lowercaseString] isEqualToString:[character lowercaseString]]) {
				[self.phraseGuessed deleteCharactersInRange:NSMakeRange(i, 1)];
				[self.phraseGuessed insertString:character
										 atIndex:i];
			}
		}
		return YES;
	}
	// if letter does not occur in answer, remove 1 life
	else {
		self.numLivesRemaining = (NSUInteger *)((unsigned long)self.numLivesRemaining - 1);
		return NO;
	}
}

/* Guesses phrase and updates game. Returns YES if guess is correct. */
- (BOOL)guessPhrase:(NSString *)phrase {
	// if phrase is correct, set phraseGuessed to exact answer
	if ([[phrase lowercaseString] isEqualToString:[self.phraseToGuess lowercaseString]]) {
		self.phraseGuessed = (NSMutableString *)self.phraseToGuess;
		return YES;
	}
	// if phrase is not correct, remove 1 life
	else {
		self.numLivesRemaining = (NSUInteger *)((unsigned long)self.numLivesRemaining - 1);
		return NO;
	}
}

/* Determines if game is over. */
- (BOOL)isGameOver {
	// if player wins
	if ([self hasPlayerWon])
		return YES;
	// if player runs out of lives
	else if (self.numLivesRemaining == 0)
		return YES;
	// if there are no more characters to guess
	else if ([self.charactersRemaining length] == 0)
		return YES;
	// otherwise
	else
		return NO;
}

/* Determines if player has won. */
- (BOOL)hasPlayerWon {
	if ([self.phraseGuessed isEqualToString:self.phraseToGuess])
		return YES;
	else
		return NO;
}

@end
