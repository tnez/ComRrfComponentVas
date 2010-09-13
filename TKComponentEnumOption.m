////////////////////////////////////////////////////////////
//  TKComponentEnumParameter.m
//  ComRrfComponentVas
//  --------------------------------------------------------
//  Author: Travis Nesland <tnesland@gmail.com>
//  Created: 9/6/10
//  Copyright 2010 Resedential Research Facility,
//  University of Kentucky. All rights reserved.
/////////////////////////////////////////////////////////////
#import "TKComponentEnumOption.h"

@implementation TKComponentEnumOption
@synthesize enumeratedList;

- (void) dealloc {
    [enumeratedList release];
    [super dealloc];
}

- (id)initWithDictionary: (NSDictionary *)values {
    if(self=[super initWithDictionary:values]) {
        [self setEnumeratedList:[values valueForKey:TKComponentOptionEnumeratedListKey]];
        [NSBundle loadNibNamed:TKComponentEnumOptionNibNameKey owner:self];
        return self;
    }
    return nil;
}

- (NSNumber *)value {
    return (NSNumber *)value;
}

@end

NSString * const TKComponentOptionEnumeratedListKey = @"enumeratedList";
NSString * const TKComponentEnumOptionNibNameKey = @"EnumOption";