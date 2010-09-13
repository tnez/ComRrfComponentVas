////////////////////////////////////////////////////////////
//  TKComponentNumberOption.h
//  ComRrfComponentVas
//  --------------------------------------------------------
//  Author: Travis Nesland <tnesland@gmail.com>
//  Created: 9/7/10
//  Copyright 2010 Resedential Research Facility,
//  University of Kentucky. All rights reserved.
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

- (NSNumber *)value;

@end

extern NSString * const TKComponentOptionMinKey;
extern NSString * const TKComponentOptionMaxKey;

extern NSString * const TKComponentNumberOptionNibNameKey;