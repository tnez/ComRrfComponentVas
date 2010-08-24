//
//  ComRrfComponentVasController.m
//  ComRrfComponentVas
//
//  Created by Travis Nesland on 8/23/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ComRrfComponentVasController.h"


@implementation ComRrfComponentVasController

@synthesize currentQuestion,errorLog,delegate,definition,text,slider,leftPrompt,middlePrompt,rightPrompt,button;
#pragma mark HOUSEKEEPING
- (void)dealloc {
    [errorLog release];
    [questions release];
    [super dealloc];
}

- (void)awakeFromNib {

    // load questions
    questions = [[TKQuestionSet questionSetFromFile:[definition valueForKey:TKVasQuestionFileKey]
                                  usingAccessMethod:[[definition valueForKey:TKVasQuestionAccessMethodKey] unsignedIntValue]] retain];

    questionCount = 0;
    if([[definition valueForKey:TKVasNumberOfIntededQuestionsKey] integerValue] == 0) {
        // ask all the questions in the set
        targetQuestionCount = [questions count];
    } else {
        targetQuestionCount = [[definition valueForKey:TKVasNumberOfIntededQuestionsKey] integerValue];
    }

    // configure interface elements
    [slider setNumberOfTickMarks:[[definition valueForKey:TKVasNumberOfTickMarksKey] integerValue]];
    [slider setMinValue:[[definition valueForKey:TKVasMinValueKey] doubleValue]];
    [slider setMaxValue:[[definition valueForKey:TKVasMaxValueKey] doubleValue]];
    [leftPrompt setStringValue:[definition valueForKey:TKVasLeftPromptKey]];
    [middlePrompt setStringValue:[definition valueForKey:TKVasMiddlePromptKey]];
    [rightPrompt setStringValue:[definition valueForKey:TKVasRightPromptKey]];
    
    [self begin];
    
}

- (void)begin {
    [self next];
}

- (BOOL)isClearedToBegin {
    if(questions) { // questions loaded successfully
        return YES;
    } else { // questions not loaded
        [self registerError:[NSString stringWithFormat:@"Could not load questions at path: %@",[definition valueForKey:TKVasQuestionFileKey]]];
        return NO;
    }
}

- (void)logEvent {
    NSString *logString = [NSString stringWithFormat:@"%d\t%@\t%d\t%d.%06d\t%@",
                           questionCount,
                           [currentQuestion uid],
                           [slider integerValue],
                           questionDuration.seconds, questionDuration.microseconds,
                           [currentQuestion text]];
    [delegate logString:logString];
}

- (NSView *)mainView {
    return view;
}

- (void)next {
    // release old question
    [currentQuestion release];
    if(questionCount++ < targetQuestionCount &&         // if we haven't reached our target count of questions
       ![questions isEmpty]) {                          // and there are still questions in the set
        // grab new question
        currentQuestion = [[questions nextQuestion] retain];
        // initialize interface for new question
        [button setEnabled:NO];
        [slider setDoubleValue:[slider minValue]];
        [text setStringValue:[currentQuestion text]];
        // mark start time
        questionStartTime = current_time_marker();
    } else {
        [delegate componentDidFinish:self];
    }
}

- (void)registerError: (NSString *)theError {
    NSString *old = errorLog;
    errorLog = [[[old stringByAppendingString:theError] stringByAppendingString:@"\n"] retain];
    [old release];
}

- (void)setup {
    
    /** Load Questions */
    questions = [[TKQuestionSet questionSetFromFile:[definition valueForKey:TKVasQuestionFileKey]
                                  usingAccessMethod:[[definition valueForKey:TKVasQuestionAccessMethodKey] unsignedIntValue]] retain];
    
    questionCount = 0;
    if([[definition valueForKey:TKVasNumberOfIntededQuestionsKey] integerValue] == 0) {
        // ask all the questions in the set
        targetQuestionCount = [questions count];
    } else {
        targetQuestionCount = [[definition valueForKey:TKVasNumberOfIntededQuestionsKey] integerValue];
    }
    
    /** Load Nib */
    if([NSBundle loadNibNamed:ComRrfComponentVasControllerNibName owner:self]) {
        // continue as is
    } else {
        [self registerError:@"Could not load Nib file"];
    }
    
    /** Configure Interface */
    [slider setNumberOfTickMarks:[[definition valueForKey:TKVasNumberOfTickMarksKey] integerValue]];
    [slider setMinValue:[[definition valueForKey:TKVasMinValueKey] doubleValue]];
    [slider setMaxValue:[[definition valueForKey:TKVasMaxValueKey] doubleValue]];
    [leftPrompt setStringValue:[definition valueForKey:TKVasLeftPromptKey]];
    [middlePrompt setStringValue:[definition valueForKey:TKVasMiddlePromptKey]];
    [rightPrompt setStringValue:[definition valueForKey:TKVasRightPromptKey]];
    
}
    
- (IBAction)sliderHasMoved: (id)sender {
    [button setEnabled:YES];
}

- (IBAction)submit: (id)sender {
    questionDuration = time_since(questionStartTime);
    [self logEvent];
    [self next];
}

- (void)tearDown {
    // nothing needed
}

@end

NSString * const TKVasQuestionFileKey = @"TKVasQuestionFile";
NSString * const TKVasQuestionAccessMethodKey = @"TKVasQuestionAccessMethod";
NSString * const TKVasNumberOfIntededQuestionsKey = @"TKVasNumberOfIntendedQuestions";
NSString * const TKVasNumberOfTickMarksKey = @"TKVasNumberOfTickMarks";
NSString * const TKVasLeftPromptKey = @"TKVasLeftPromptKey";
NSString * const TKVasMiddlePromptKey = @"TKVasMiddlePromptKey";
NSString * const TKVasRightPromptKey = @"TKVasRightPromptKey";
NSString * const TKVasMinValueKey = @"TKVasMinValueKey";
NSString * const TKVasMaxValueKey = @"TKVasMaxValueKey";
