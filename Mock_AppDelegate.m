////////////////////////////////////////////////////////////
//  Mock_AppDelegate.m
//  ComRrfComponentVas
//  --------------------------------------------------------
//  Author: Travis Nesland <tnesland@gmail.com>
//  Created: 9/7/10
//  Copyright 2010 smoooosh software. All rights reserved.
/////////////////////////////////////////////////////////////
#import "Mock_AppDelegate.h"
#import "TKComponentConfigurationView.h"
#import "TKComponentStringOption.h"
#import "TKComponentNumberOption.h"
#import "TKComponentBooleanOption.h"
#import "TKComponentPathOption.h"
#import "TKComponentEnumOption.h"

@implementation Mock_AppDelegate
@synthesize manifest,componentOptions,leftView,topRightView,bottomRightView,
componentDefinition,sessionWindow,presentedOptions;

- (void)dealloc {
    [manifest release];
    [componentOptions release];
    [componentDefinition release];
    [sessionWindow release];
    [presentedOptions release];
    [super dealloc];
}

- (void)awakeFromNib {
    // find bundle
    NSBundle *compBundle = [[NSBundle bundleWithPath:
                             [[NSBundle mainBundle]
                              pathForResource:@"ComRrfComponentVas" ofType:@"bundle"]] retain];
    // read manifest
    [self setManifest:
     [NSDictionary dictionaryWithContentsOfFile:
      [compBundle pathForResource:@"manifest" ofType:@"plist"]]];
    // get options
    [self setPresentedOptions:[NSMutableArray array]];
    [self setComponentOptions:[NSArray arrayWithArray:
                               [manifest valueForKey:TKComponentOptionsKey]]];
    // load component config view
    componentConfigView =
        [[TKComponentConfigurationView alloc] initWithFrame:[leftView frame]];
    [componentConfigView setMargins:10.0];
    // for each option add a subview
    id tmp = nil;
    for(NSDictionary *option in componentOptions) {
        switch([[option valueForKey:TKComponentOptionTypeKey] integerValue]) {
            case TKComponentOptionTypeString:
                tmp = [[TKComponentStringOption alloc]
                          initWithDictionary:option];
                [componentConfigView addSubview:[tmp view]];
                [presentedOptions addObject:tmp];
                [tmp release]; tmp=nil;
                break;
            case TKComponentOptionTypeNumber:
                tmp = [[TKComponentNumberOption alloc]
                          initWithDictionary:option];
                [componentConfigView addSubview:[tmp view]];
                [presentedOptions addObject:tmp];
                [tmp release]; tmp=nil;                
                break;
            case TKComponentOptionTypeBoolean:
                tmp = [[TKComponentBooleanOption alloc]
                          initWithDictionary:option];
                [componentConfigView addSubview:[tmp view]];
                [presentedOptions addObject:tmp];
                [tmp release]; tmp=nil;                
                break;
            case TKComponentOptionTypePath:
                tmp = [[TKComponentPathOption alloc]
                          initWithDictionary:option];
                [componentConfigView addSubview:[tmp view]];
                [presentedOptions addObject:tmp];
                [tmp release]; tmp=nil;                
                break;
            case TKComponentOptionTypeEnum:
                tmp = [[TKComponentEnumOption alloc]
                          initWithDictionary:option];
                [componentConfigView addSubview:[tmp view]];
                [presentedOptions addObject:tmp];
                [tmp release]; tmp=nil;                
                break;
            default:
                break;
        }   // end switch
    }       // end for
    // add component view to left view
    [leftView setDocumentView:componentConfigView];
    // display views
    [componentConfigView setNeedsDisplay:YES];
    [leftView setNeedsDisplay:YES];
}

@end
