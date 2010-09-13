////////////////////////////////////////////////////////////
//  Mock_AppDelegate.m
//  ComRrfComponentVas
//  --------------------------------------------------------
//  Author: Travis Nesland <tnesland@gmail.com>
//  Created: 9/7/10
//  Copyright 2010 Resedential Research Facility,
//  University of Kentucky. All rights reserved.
/////////////////////////////////////////////////////////////
#import "Mock_AppDelegate.h"
#import "TKComponentConfigurationView.h"
#import "TKComponentOption.h"
#import "TKComponentStringOption.h"
#import "TKComponentNumberOption.h"
#import "TKComponentBooleanOption.h"
#import "TKComponentPathOption.h"
#import "TKComponentEnumOption.h"

@implementation Mock_AppDelegate
@synthesize manifest,componentOptions,subject,leftView,topRightView,bottomRightView,
componentDefinition,setupWindow,sessionWindow,presentedOptions,errorLog;

- (void)dealloc {
    [manifest release];
    [componentOptions release];
    [componentDefinition release];
    [presentedOptions release];
    [errorLog release];
    [super dealloc];
}

- (void)awakeFromNib {
    // reset error log
    errorLog = nil;
    // read manifest
    [self setManifest:[NSDictionary dictionaryWithContentsOfFile:
                       [[NSBundle mainBundle] pathForResource:@"manifest" ofType:@"plist"]]];
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

- (IBAction) preflight: (id)sender {
    // create definition
    for(TKComponentOption *option in presentedOptions) {
        [componentDefinition setValue:[option value]
                               forKey:[option optionKeyName]];
    }
    
    // create component
    component = [[TKComponentController loadFromDefinition:componentDefinition] retain];
    
    // setup component
    [component setSubject:subject];
    [component setSessionWindow:setupWindow];
    
    // test
    [self setErrorLog:[component preflightAndReturnErrorAsString]];
    
    // give back component
    [component release];
}
    
- (IBAction) run: (id)sender {
    
    // create definition
    for(TKComponentOption *option in presentedOptions) {
        [componentDefinition setValue:[option value]
                               forKey:[option optionKeyName]];
    }
    
    // create component
    component = [[TKComponentController loadFromDefinition:componentDefinition] retain];
    
    // load session window
    [NSBundle loadNibNamed:@"SessionWindow" owner:self];
    
    // setup component
    [component setSubject:subject];
    [component setSessionWindow:setupWindow];
    
    // if component is good to go...
    if([component isClearedToBegin]) {
        // ...go
        [component begin];
    } else { // if component is not good...
        // ...
    }
}
        
    
@end
