////////////////////////////////////////////////////////////
//  TKComponentStringOption.h
//  ComRrfComponentVas
//  --------------------------------------------------------
//  Author: Travis Nesland <tnesland@gmail.com>
//  Created: 9/6/10
//  Copyright 2010 smoooosh software. All rights reserved.
/////////////////////////////////////////////////////////////
#import <Cocoa/Cocoa.h>
#import "TKComponentOption.h"

@interface TKComponentStringOption : TKComponentOption {

}

- (id)initWithDictionary: (NSDictionary *)values;

- (BOOL)isValid;

- (IBAction)validate: (id)sender;

@end

extern NSString * const TKComponentStringOptionNibNameKey;