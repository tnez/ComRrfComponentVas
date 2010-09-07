////////////////////////////////////////////////////////////
//  Mock_AppDelegate.h
//  ComRrfComponentVas
//  --------------------------------------------------------
//  Author: Travis Nesland <tnesland@gmail.com>
//  Created: 9/7/10
//  Copyright 2010 smoooosh software. All rights reserved.
/////////////////////////////////////////////////////////////
#import <Cocoa/Cocoa.h>
@interface Mock_AppDelegate : NSObject {

    /** setup material */
    NSDictionary                                *manifest;
    NSArray                                     *componentOptions;
    
    /** view boxes */
    IBOutlet NSView                             *leftView;
    IBOutlet NSView                             *topRightView;
    IBOutlet NSView                             *bottomRightView;
    NSView                                      *componentConfigView;
    
    /** run products */
    NSDictionary                                *componentDefinition;
    NSWindow                                    *sessionWindow;
    NSMutableArray                              *presentedOptions;
}

@property (nonatomic, retain) NSDictionary      *manifest;
@property (nonatomic, retain) NSArray           *componentOptions;
@property (assign) IBOutlet NSView              *leftView;
@property (assign) IBOutlet NSView              *topRightView;
@property (assign) IBOutlet NSView              *bottomRightView;
@property (nonatomic, retain) NSDictionary      *componentDefinition;
@property (nonatomic, retain) NSWindow          *sessionWindow;
@property (nonatomic, retain) NSMutableArray    *presentedOptions;

@end
