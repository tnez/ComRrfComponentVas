////////////////////////////////////////////////////////////
//  TKComponentNumberOption.m
//  ComRrfComponentVas
//  --------------------------------------------------------
//  Author: Travis Nesland <tnesland@gmail.com>
//  Created: 9/7/10
//  Copyright 2010 smoooosh software. All rights reserved.
/////////////////////////////////////////////////////////////
#import "TKComponentNumberOption.h"

@implementation TKComponentNumberOption
@synthesize min,max;

- (void)dealloc {
    [min release];
    [max release];
    [super dealloc];
}

- (id)initWithDictionary: (NSDictionary *)values {
    if(self=[super initWithDictionary:values]) {
        [self setMin:[values valueForKey:TKComponentOptionMinKey]];
        [self setMax:[values valueForKey:TKComponentOptionMaxKey]];
        [NSBundle loadNibNamed:TKComponentNumberOptionNibNameKey owner:self];
        return self;
    }
    return nil;
}

- (BOOL)isValid {
    if(!allowsNull && ![value stringValue] > 0) {
        return NO;
    }
    return (!min || [value floatValue] >= [min floatValue]) &&
           (!max || [value floatValue] <= [max floatValue]);
}

- (IBAction)validate: (id)sender {
    // reset error string
    [self setErrorMessage:nil];
    if(![self isValid]) {
        // update error string
        [self setErrorMessage:
         [NSString stringWithFormat:@"Value must be between %@ and %@",
                                    [min stringValue],[max stringValue]]];
    }
}
        
@end

NSString * const TKComponentOptionMinKey = @"min";
NSString * const TKComponentOptionMaxKey = @"max";

NSString * const TKComponentNumberOptionNibNameKey = @"NumberOption";