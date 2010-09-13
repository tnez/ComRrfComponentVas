////////////////////////////////////////////////////////////
//  TKComponentBooleanParameter.m
//  ComRrfComponentVas
//  --------------------------------------------------------
//  Author: Travis Nesland <tnesland@gmail.com>
//  Created: 9/6/10
//  Copyright 2010 Resedential Research Facility,
//  University of Kentucky. All rights reserved.
/////////////////////////////////////////////////////////////
#import "TKComponentBooleanOption.h"

@implementation TKComponentBooleanOption

- (id)initWithDictionary: (NSDictionary *)values {
    if(self=[super initWithDictionary:values]) {
        [NSBundle loadNibNamed:TKComponentBooleanOptionNibNameKey owner:self];
        return self;
    }
    return nil;
}

- (NSNumber *)value {
    return (NSNumber *)value;
}

@end

NSString * const TKComponentBooleanOptionNibNameKey = @"BooleanOption";