////////////////////////////////////////////////////////////
//  TKComponentBooleanParameter.h
//  ComRrfComponentVas
//  --------------------------------------------------------
//  Author: Travis Nesland <tnesland@gmail.com>
//  Created: 9/6/10
//  Copyright 2010 Resedential Research Facility,
//  University of Kentucky. All rights reserved.
/////////////////////////////////////////////////////////////

#import <Cocoa/Cocoa.h>
#import "TKComponentOption.h"

@interface TKComponentBooleanOption : TKComponentOption {

}

- (id)initWithDictionary: (NSDictionary *)values;

- (NSNumber *)value;

@end

extern NSString * const TKComponentBooleanOptionNibNameKey;