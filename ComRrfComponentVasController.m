//
//  ComRrfComponentVasController.m
//  ComRrfComponentVas
//
//  Created by Travis Nesland on 8/23/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ComRrfComponentVasController.h"


@implementation ComRrfComponentVasController

@synthesize currentQuestion,errorLog,delegate,definition,view,text,slider,leftPrompt,middlePrompt,rightPrompt,button;

#pragma mark Housekeeping
- (void)dealloc {
    [errorLog release];
    [questions release];
    [super dealloc];
}

#pragma mark User Interface
- (IBAction)sliderHasMoved: (id)sender {
    [button setEnabled:YES];
}
- (IBAction)submit: (id)sender {
    questionDuration = time_since(questionStartTime);
    [self logEvent];
    [self next];
}

#pragma mark Internal Logic
- (void)logEvent {
    NSString *logString = [NSString stringWithFormat:@"%d\t%@\t%d\t%d.%06d\t%@",
                           questionCount,
                           [currentQuestion uid],
                           [slider integerValue],
                           questionDuration.seconds, questionDuration.microseconds,
                           [currentQuestion text]];
    [delegate logStringToDefaultTempFile:logString];
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
    [self setErrorLog:[[errorLog stringByAppendingString:theError] stringByAppendingString:@"\n"]];
}

#pragma mark Component Protocol
- (void)begin {
    [self next];
}
- (NSString *)dataDirectory {
  return [[definition valueForKey:TKVasDataDirectoryKey]
          stringByStandardizingPath];
}
- (BOOL)isClearedToBegin {
    if([errorLog isEqualToString:@""]) { // if error log is an empty string...
        return YES;
    } else { // ...else errors have been logged
        return NO;
    }
}
- (NSView *)mainView {
    return view;
}
- (NSString *)rawDataFile {
    return [delegate defaultTempFile];
}
- (void)recover {
    // TODO: implement crash recovery
}
- (void)setup {

    /** Reset Error Log */
    [self setErrorLog:@""];

    /** Check Data Directory - and try to create if !exist */
    BOOL exists, isDirectory;
    exists = [[NSFileManager defaultManager]
              fileExistsAtPath:[[definition valueForKey:TKVasDataDirectoryKey] stringByStandardizingPath]
                                            isDirectory:&isDirectory];
    if(exists) {
        if(isDirectory) {
            // expected case - file exists and is directory: do nothing
        } else {
            [self registerError:[NSString stringWithFormat:@"Data directory: %@ is not valid",
                                 [[definition valueForKey:TKVasDataDirectoryKey] stringByStandardizingPath]]];
        }
    } else {
        // try to create directory
        NSError *creationError = nil;
        [[NSFileManager defaultManager] createDirectoryAtPath:[[definition valueForKey:TKVasDataDirectoryKey] stringByStandardizingPath]
                                  withIntermediateDirectories:YES attributes:nil error:&creationError];
        if(creationError) { // there was an error creating the directory
            [self registerError:[NSString stringWithFormat:@"Could not create data directory: %@",
                                 [[definition valueForKey:TKVasDataDirectoryKey] stringByStandardizingPath]]];
        } else { // there was no error creating the directory
            // no error to report: do nothing
        }
    }

    /** Load Questions */
    questions = [[TKQuestionSet questionSetFromFile:[definition valueForKey:TKVasQuestionFileKey]
                                  usingAccessMethod:[[definition valueForKey:TKVasQuestionAccessMethodKey] unsignedIntegerValue]] retain];
    if(questions) { // if questions loaded
        questionCount = 0;
        if([[definition valueForKey:TKVasNumberOfIntededQuestionsKey] integerValue] == 0) {
            // ask all the questions in the set
            targetQuestionCount = [questions count];
        } else {
            targetQuestionCount = [[definition valueForKey:TKVasNumberOfIntededQuestionsKey] integerValue];
        }
    } else { //questions did not load
        [self registerError:[NSString stringWithFormat:@"Could not load questions from file: %@",[definition valueForKey:TKVasQuestionFileKey]]];
    }

    /** Load Nib */
    if([NSBundle loadNibNamed:ComRrfComponentVasNibName owner:self]) {
        // configure interface
        [slider setNumberOfTickMarks:[[definition valueForKey:TKVasNumberOfTickMarksKey] integerValue]];
        [slider setMinValue:[[definition valueForKey:TKVasMinValueKey] doubleValue]];
        [slider setMaxValue:[[definition valueForKey:TKVasMaxValueKey] doubleValue]];
        [leftPrompt setStringValue:[definition valueForKey:TKVasLeftPromptKey]];
        [middlePrompt setStringValue:[definition valueForKey:TKVasMiddlePromptKey]];
        [rightPrompt setStringValue:[definition valueForKey:TKVasRightPromptKey]];
    } else { // nib did not load
        [self registerError:@"Could not load Nib file"];
    }
}

- (BOOL)shouldRecover {
    return [[NSFileManager defaultManager] fileExistsAtPath:[delegate defaultTempFile]];
}
- (NSString *)taskName {
  return [definition valueForKey:TKVasTaskNameKey];
}
- (void)tearDown {
    // remove temporary data file
    [[NSFileManager defaultManager] removeItemAtPath:[[delegate tempDirectory] stringByAppendingPathComponent:[delegate defaultTempFile]] error:NULL];
}
@end

#pragma mark Preference Keys
NSString * const TKVasTaskNameKey = @"TKVasTaskName";
NSString * const TKVasDataDirectoryKey = @"TKVasDataDirectory";
NSString * const TKVasQuestionFileKey = @"TKVasQuestionFile";
NSString * const TKVasQuestionAccessMethodKey = @"TKVasQuestionAccessMethod";
NSString * const TKVasNumberOfIntededQuestionsKey = @"TKVasNumberOfIntendedQuestions";
NSString * const TKVasNumberOfTickMarksKey = @"TKVasNumberOfTickMarks";
NSString * const TKVasLeftPromptKey = @"TKVasLeftPrompt";
NSString * const TKVasMiddlePromptKey = @"TKVasMiddlePrompt";
NSString * const TKVasRightPromptKey = @"TKVasRightPrompt";
NSString * const TKVasMinValueKey = @"TKVasMinValue";
NSString * const TKVasMaxValueKey = @"TKVasMaxValue";
NSString * const ComRrfComponentVasNibName = @"ComRrfComponentVasMainNib";
