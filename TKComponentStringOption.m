////////////////////////////////////////////////////////////
//  TKComponentStringOption.m
//  ComRrfComponentVas
//  --------------------------------------------------------
//  Author: Travis Nesland <tnesland@gmail.com>
//  Created: 9/6/10
//  Copyright 2010 Resedential Research Facility,
//  University of Kentucky. All rights reserved.
/////////////////////////////////////////////////////////////
#import "TKComponentStringOption.h"

@implementation TKComponentStringOption

- (void)dealloc {
    [value release];
    [super dealloc];
}

- (id)initWithDictionary: (NSDictionary *)values {
    if(self=[super initWithDictionary:values]) {
        [self setValue:[values valueForKey:TKComponentOptionDefaultKey]];
        [NSBundle loadNibNamed:TKComponentStringOptionNibNameKey owner:self];
        return self;
    }
    return nil;
}

- (BOOL)isValid {
    return allowsNull || [value length] > 0;
}

- (void)setValue: (NSString *)newValue {
    NSString *oldValue = [self value];
    if(![oldValue isEqualToString:newValue]) {
        value = [newValue retain];
        [oldValue release];
    }
}

- (IBAction)validate: (id)sender {
    [self setErrorMessage:nil];
    if(![self isValid]) {
        [self setErrorMessage:@"Value must not be nil"];
    }
}

- (NSString *)value {
    return (NSString *)value;
}

@end

NSString * const TKComponentStringOptionNibNameKey = @"StringOption";