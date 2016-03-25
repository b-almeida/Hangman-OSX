//
//  HNGGame.h
//  Hangman
//
//  Created by Bruno on 2015-01-30.
//  Copyright (c) 2015 Bruno Almeida. All rights reserved.
//


#import <Foundation/Foundation.h>


@interface HNGGame : NSObject

@property NSString *phraseToGuess;
@property NSMutableString *phraseGuessed;
@property NSUInteger *numLivesRemaining;
@property NSMutableString *charactersRemaining;

+ (HNGGame *)game;
+ (HNGGame *)gameWithPhraseToGuess:(NSString *)phraseToGuess
				 numLivesRemaining:(NSUInteger *)numLivesRemaining;
- (instancetype)init;
- (instancetype)initWithPhraseToGuess:(NSString *)phraseToGuess
		  numLivesRemaining:(NSUInteger *)numLivesRemaining;
+ (BOOL)isValidPhrase:(NSString *)phrase;
+ (BOOL)isValidLetter:(NSString *)letter;
- (BOOL)isRemainingLetter:(NSString *)letter;
- (BOOL)guessLetter:(NSString *)letter;
- (BOOL)guessPhrase:(NSString *)phrase;
- (BOOL)isGameOver;
- (BOOL)hasPlayerWon;

@end
