//
//  WaveFileDescriptionAppDelegate.m
//  WaveFileDescription
//
//  Created by arab on 12/06/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "WaveFileDescriptionAppDelegate.h"
#import "WaveFileDescriptionViewController.h"

@implementation WaveFileDescriptionAppDelegate

@synthesize window;
@synthesize viewController;


- (void)applicationDidFinishLaunching:(UIApplication *)application {    
    
    // Override point for customization after app launch    
    [window addSubview:viewController.view];
    [window makeKeyAndVisible];
}


- (void)dealloc {
    [viewController release];
    [window release];
    [super dealloc];
}


@end
