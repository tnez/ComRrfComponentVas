////////////////////////////////////////////////////////////
//  Mock_AppDelegate.h
//  ComRrfComponentVas
//  --------------------------------------------------------
//  Author: Travis Nesland <tnesland@gmail.com>
//  Created: 9/7/10
//  Copyright 2010 smoooosh software. All rights reserved.
/////////////////////////////////////////////////////////////
#import <Cocoa/Cocoa.h>
@class TKComponentConfigurationView;
@interface Mock_AppDelegate : NSObject {

    /** setup material */
    NSDictionary                                *manifest;
    NSArray                                     *componentOptions;
    
    /** view boxes */
    IBOutlet NSScrollView                       *leftView;
    IBOutlet NSView                             *topRightView;
    IBOutlet NSView                             *bottomRightView;
    TKComponentConfigurationView                *componentConfigView;
    
    /** run products */
    NSDictionary                                *componentDefinition;
    NSWindow                                    *sessionWindow;
    NSMutableArray                              *presentedOptions;
}

@property (nonatomic, retain) NSDictionary      *manifest;
@property (nonatomic, retain) NSArray           *componentOptions;
@property (assign) IBOutlet NSScrollView        *leftView;
@property (assign) IBOutlet NSView              *topRightView;
@property (assign) IBOutlet NSView              *bottomRightView;
@property (nonatomic, retain) NSDictionary      *componentDefinition;
@property (nonatomic, retain) NSWindow          *sessionWindow;
@property (nonatomic, retain) NSMutableArray    *presentedOptions;

@end
