////////////////////////////////////////////////////////////
//  TKComponentEnumParameter.h
//  ComRrfComponentVas
//  --------------------------------------------------------
//  Author: Travis Nesland <tnesland@gmail.com>
//  Created: 9/6/10
//  Copyright 2010 smoooosh software. All rights reserved.
/////////////////////////////////////////////////////////////
#import <Cocoa/Cocoa.h>
#import "TKComponentOption.h"

@interface TKComponentEnumOption : TKComponentOption {

    NSArray                             *enumeratedList;
}

@property (nonatomic, retain) NSArray   *enumeratedList;

- (id)initWithDictionary: (NSDictionary *)values;

@end

extern NSString * const TKComponentOptionEnumeratedListKey;
extern NSString * const TKComponentEnumOptionNibNameKey;

