//
//  ComRrfComponentVasController.h
//  ComRrfComponentVas
//
//  Created by Travis Nesland on 8/23/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <TKUtility/TKUtility.h>

@interface ComRrfComponentVasController : NSObject <TKComponentBundleLoading> {

    /** INTERNAL ELEMENTS */
    NSInteger                                       targetQuestionCount;
    NSInteger                                       questionCount;
    NSString                                        *errorLog;
    TKQuestionSet                                   *questions;
    TKQuestion                                      *currentQuestion;
    TKTime                                          questionStartTime;
    TKTime                                          questionDuration;

    /** REFERENCED ELEMENTS */
    id <TKComponentBundleDelegate>                  delegate;
    NSDictionary                                    *definition;

    /** UI ELEMENTS */
    IBOutlet NSView                                 *view;
    IBOutlet NSTextField                            *text;
    IBOutlet NSSlider                               *slider;
    IBOutlet NSTextField                            *leftPrompt;
    IBOutlet NSTextField                            *middlePrompt;
    IBOutlet NSTextField                            *rightPrompt;
    IBOutlet NSButton                               *button;

}

/** INTERNAL ELEMENTS */
@property (retain) TKQuestion                       *currentQuestion;
@property (nonatomic, retain) NSString              *errorLog;

/** REFERENCED ELEMENTS */
@property (assign) TKComponentController            *delegate;
@property (assign) NSDictionary                     *definition;

/** UI ELEMENTS */
@property (assign) IBOutlet NSView                  *view;
@property (assign) IBOutlet NSTextField             *text;
@property (assign) IBOutlet NSSlider                *slider;
@property (assign) IBOutlet NSTextField             *leftPrompt;
@property (assign) IBOutlet NSTextField             *middlePrompt;
@property (assign) IBOutlet NSTextField             *rightPrompt;
@property (assign) IBOutlet NSButton                *button;

#pragma mark Interface
/**
 Subject has moved the slider
 */
- (IBAction)sliderHasMoved: (id)sender;

/**
 Subject has submit response to question
 */
- (IBAction)submit: (id)sender;

#pragma mark Protocol
- (void)begin;
- (NSString *)dataDirectory;
- (BOOL)isClearedToBegin;
- (NSView *)mainView;
- (NSString *)rawDataFile;
- (void)recover;
- (void)setup;
- (BOOL)shouldRecover;
- (NSString *)taskName;
- (void)tearDown;

@end

#pragma mark Preference Keys
extern NSString * const TKVasTaskNameKey;
extern NSString * const TKVasDataDirectoryKey;
extern NSString * const TKVasQuestionFileKey;
extern NSString * const TKVasQuestionAccessMethodKey;
extern NSString * const TKVasNumberOfIntededQuestionsKey;
extern NSString * const TKVasNumberOfTickMarksKey;
extern NSString * const TKVasLeftPromptKey;
extern NSString * const TKVasMiddlePromptKey;
extern NSString * const TKVasRightPromptKey;
extern NSString * const TKVasMinValueKey;
extern NSString * const TKVasMaxValueKey;

#pragma mark Internal Strings
extern NSString * const ComRrfComponentVasNibName;

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
- (void)registerError: (NSString *)theError;
@end
