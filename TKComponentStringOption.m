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

- (id)initWithDictionary: (NSDictionary *)values {
    if(self=[super initWithDictionary:values]) {
        [NSBundle loadNibNamed:TKComponentStringOptionNibNameKey owner:self];
        return self;
    }
    return nil;
}

- (BOOL)isValid {
    return allowsNull || [value length] > 0;
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