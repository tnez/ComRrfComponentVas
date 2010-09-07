////////////////////////////////////////////////////////////
//  TKComponentNumberOption.h
//  ComRrfComponentVas
//  --------------------------------------------------------
//  Author: Travis Nesland <tnesland@gmail.com>
//  Created: 9/7/10
//  Copyright 2010 smoooosh software. All rights reserved.
/////////////////////////////////////////////////////////////
#import <Cocoa/Cocoa.h>
#import "TKComponentOption.h"

@interface TKComponentNumberOption : TKComponentOption {

    NSNumber                                *min;
    NSNumber                                *max;
}

@property (nonatomic, retain) NSNumber      *min;
@property (nonatomic, retain) NSNumber      *max;

- (id)initWithDictionary: (NSDictionary *)values;

- (BOOL)isValid;

- (IBAction)validate: (id)sender;

@end

extern NSString * const TKComponentOptionMinKey;
extern NSString * const TKComponentOptionMaxKey;

extern NSString * const TKComponentNumberOptionNibNameKey;