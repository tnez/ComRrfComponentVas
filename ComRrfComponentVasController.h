//
//  ComRrfComponentVasController.h
//  ComRrfComponentVas
//
//  Created by Travis Nesland on 8/23/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <TKUtility/TKUtility.h>



@interface ComRrfComponentVasController : NSObject {

    /** INTERNAL ELEMENTS */
    NSInteger                                       targetQuestionCount;
    NSInteger                                       questionCount;
    TKQuestionSet                                   *questions;
    TKQuestion                                      *currentQuestion;
    TKTime                                          questionStartTime;
    TKTime                                          questionDuration;

    /** REFERENCED ELEMENTS */
    IBOutlet TKComponentController                  *delegate;
    IBOutlet NSDictionary                           *definition;
    IBOutlet TKLogging                              *mainLog;
    IBOutlet TKLogging                              *crashLog;
    IBOutlet TKSubject                              *subject;
    
    /** UI ELEMENTS */
    IBOutlet NSTextField                            *text;
    IBOutlet NSSlider                               *slider;    
    IBOutlet NSTextField                            *leftPrompt;
    IBOutlet NSTextField                            *middlePrompt;
    IBOutlet NSTextField                            *rightPrompt;
    IBOutlet NSButton                               *button;
}

/** INTERNAL ELEMENTS */
@property (retain) TKQuestion                       *currentQuestion;

/** REFERENCED ELEMENTS */
@property (assign) IBOutlet TKComponentController   *delegate;
@property (assign) IBOutlet NSDictionary            *definition;
@property (assign) IBOutlet TKLogging               *mainLog;
@property (assign) IBOutlet TKLogging               *crashLog;
@property (assign) IBOutlet TKSubject               *subject;

/** UI ELEMENTS */
@property (assign) IBOutlet NSTextField             *text;
@property (assign) IBOutlet NSSlider                *slider;    
@property (assign) IBOutlet NSTextField             *leftPrompt;
@property (assign) IBOutlet NSTextField             *middlePrompt;
@property (assign) IBOutlet NSTextField             *rightPrompt;
@property (assign) IBOutlet NSButton                *button;


/**
 Starts the component
 */
- (void)begin;

/**
 Ends the component gracefully. Should be called internally in most cases.
 */
- (void)end;

/**
 Returns YES if questions have loaded and super is also cleared to begin
 */
- (BOOL)isClearedToBegin;

/**
 Subject has moved the slider
 */
- (IBAction)sliderHasMoved: (id)sender;

/**
 Subject has submit response to question
 */
- (IBAction)submit: (id)sender;

@end

#pragma mark Preference Keys
extern NSString * const TKVasQuestionFileKey;
extern NSString * const TKVasQuestionAccessMethodKey;
extern NSString * const TKVasNumberOfIntededQuestionsKey;
extern NSString * const TKVasNumberOfTickMarksKey;
extern NSString * const TKVasLeftPromptKey;
extern NSString * const TKVasMiddlePromptKey;
extern NSString * const TKVasRightPromptKey;
extern NSString * const TKVasMinValueKey;
extern NSString * const TKVasMaxValueKey;

#pragma mark Enumerated Values
enum {
    TKVasQuestionAccessMethodSequential                 = 0,
    TKVasQuestionAccessMethodRandomWithoutReplacement   = 1,
    TKVasQuestionAccessMethodRandomWithReplacement      = 2
}; typedef NSInteger TKVasQuestionAccessMethod;


/** Private Methods -- should not be called from outside of class */
@interface ComRrfComponentVasController (ComRrfComponentVasControllerPrivate)

- (void)next;
- (void)logEvent;

@end
