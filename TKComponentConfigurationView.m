//
//  TKComponentConfigurationView.m
//  ComRrfComponentVas
//
//  Created by Travis Nesland on 9/7/10.
//  Copyright 2010 smoooosh software. All rights reserved.
//

#import "TKComponentConfigurationView.h"


@implementation TKComponentConfigurationView

- (id)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        nextSubviewOrigin = NSMakePoint(0,0);
        [self setAutoresizingMask:NSViewNotSizable];
    }
    return self;
}

- (void)drawRect:(NSRect)rect {

}

- (void)addSubview: (NSView *)theSubview {
    [theSubview setFrameOrigin:nextSubviewOrigin];
    [super addSubview:theSubview];
    [theSubview setNeedsDisplay:YES];
    [self setNeedsDisplay:YES];
    nextSubviewOrigin = NSMakePoint(0,nextSubviewOrigin.y + [theSubview bounds].size.height);    
}
    
- (BOOL)isFlipped {
    return YES; // do this so origin is top left
}

@end
