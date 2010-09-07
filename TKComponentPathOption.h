////////////////////////////////////////////////////////////
//  TKComponentPathOption.h
//  ComRrfComponentVas
//  --------------------------------------------------------
//  Author: Travis Nesland <tnesland@gmail.com>
//  Created: 9/7/10
//  Copyright 2010 smoooosh software. All rights reserved.
/////////////////////////////////////////////////////////////
#import <Cocoa/Cocoa.h>
#import "TKComponentOption.h"

@interface TKComponentPathOption : TKComponentOption {

    BOOL                    selectionIsDirectoryType;
}

@property (readwrite) BOOL  selectionIsDirectoryType;

- (IBAction)browseForPath: (id)sender;

- (id)initWithDictionary: (NSDictionary *)values;

- (BOOL)isValid;

- (IBAction)validate: (id)sender;
    
@end

extern NSString * const TKComponentOptionIsDirKey;

extern NSString * const TKComponentPathOptionNibNameKey;